#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.prod"
LOCAL_PG="/opt/homebrew/Cellar/libpq/18.6/bin/psql"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env.prod not found"
  exit 1
fi

# Load prod env vars
set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

sync_table() {
  local TABLE="$1"
  local CONFLICT_COL="$2"
  local SELECT_JSON="$3"
  local SELECT_SQL="$4"
  local SQL_FILE="$5"

  ROW_COUNT=$(PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
    -c "SELECT COUNT(*) FROM herbal.${TABLE};")

  if [ "$ROW_COUNT" = "0" ]; then
    echo "${TABLE}: no rows — skipping."
    return
  fi

  # Regenerate the SQL sync file
  PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
    -c "$SELECT_SQL" > "$ROOT_DIR/supabase/${SQL_FILE}"

  # Build JSON array and POST to prod
  JSON=$(PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
    -c "$SELECT_JSON")

  echo "Syncing ${TABLE}: ${ROW_COUNT} row(s)..."

  HTTP_STATUS=$(curl -s -o /tmp/sync-images-response.json -w "%{http_code}" \
    -X POST "${NEXT_PUBLIC_SUPABASE_URL}/rest/v1/${TABLE}?on_conflict=${CONFLICT_COL}" \
    -H "apikey: ${SUPABASE_SERVICE_ROLE_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_SERVICE_ROLE_KEY}" \
    -H "Content-Type: application/json" \
    -H "Content-Profile: herbal" \
    -H "Prefer: resolution=ignore-duplicates,return=minimal" \
    -d "$JSON")

  if [ "$HTTP_STATUS" = "200" ] || [ "$HTTP_STATUS" = "201" ]; then
    echo "${TABLE}: done — ${ROW_COUNT} row(s) synced (duplicates silently skipped)."
  else
    echo "Error: ${TABLE} prod API returned HTTP $HTTP_STATUS"
    cat /tmp/sync-images-response.json
    exit 1
  fi
}

sync_table \
  "herb_images" \
  "herb_id,image_key" \
  "SELECT json_agg(json_build_object('herb_id', herb_id, 'image_key', image_key) ORDER BY created_at) FROM herbal.herb_images;" \
  "SELECT 'INSERT INTO herbal.herb_images (herb_id, image_key) VALUES (' || herb_id || ', ' || quote_literal(image_key) || ') ON CONFLICT DO NOTHING;' FROM herbal.herb_images ORDER BY created_at;" \
  "herb_images_sync.sql"

sync_table \
  "recipe_images" \
  "recipe_id" \
  "SELECT json_agg(json_build_object('recipe_id', recipe_id, 'image_key', image_key) ORDER BY created_at) FROM herbal.recipe_images;" \
  "SELECT 'INSERT INTO herbal.recipe_images (recipe_id, image_key) VALUES (' || recipe_id || ', ' || quote_literal(image_key) || ') ON CONFLICT DO NOTHING;' FROM herbal.recipe_images ORDER BY created_at;" \
  "recipe_images_sync.sql"
