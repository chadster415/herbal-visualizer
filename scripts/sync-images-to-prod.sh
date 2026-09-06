#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.prod"
LOCAL_PG="/opt/homebrew/Cellar/libpq/18.1/bin/psql"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env.prod not found"
  exit 1
fi

# Load prod env vars
set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

# Count rows
ROW_COUNT=$(PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
  -c "SELECT COUNT(*) FROM herbal.herb_images;")

if [ "$ROW_COUNT" = "0" ]; then
  echo "No images in local DB — nothing to sync."
  exit 0
fi

# Regenerate the SQL sync file
PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
  -c "SELECT 'INSERT INTO herbal.herb_images (herb_id, image_key) VALUES (' || herb_id || ', ' || quote_literal(image_key) || ') ON CONFLICT DO NOTHING;' FROM herbal.herb_images ORDER BY created_at;" \
  > "$ROOT_DIR/supabase/herb_images_sync.sql"

# Build JSON array from local DB
JSON=$(PGPASSWORD=postgres "$LOCAL_PG" -h 127.0.0.1 -p 54322 -U postgres -d postgres -t -A \
  -c "SELECT json_agg(json_build_object('herb_id', herb_id, 'image_key', image_key) ORDER BY created_at) FROM herbal.herb_images;")

echo "Syncing $ROW_COUNT image row(s) to prod..."

HTTP_STATUS=$(curl -s -o /tmp/sync-images-response.json -w "%{http_code}" \
  -X POST "${NEXT_PUBLIC_SUPABASE_URL}/rest/v1/herb_images?on_conflict=herb_id,image_key" \
  -H "apikey: ${SUPABASE_SERVICE_ROLE_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SERVICE_ROLE_KEY}" \
  -H "Content-Type: application/json" \
  -H "Content-Profile: herbal" \
  -H "Prefer: resolution=ignore-duplicates,return=minimal" \
  -d "$JSON")

if [ "$HTTP_STATUS" = "200" ] || [ "$HTTP_STATUS" = "201" ]; then
  echo "Done — $ROW_COUNT row(s) synced (duplicates silently skipped)."
else
  echo "Error: prod API returned HTTP $HTTP_STATUS"
  cat /tmp/sync-images-response.json
  exit 1
fi
