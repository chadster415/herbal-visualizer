#!/bin/bash
# Recovery script for when Colima/Supabase get stuck after a hard kill.
# Run via: pnpm restart-colima

set -e

echo "==> Killing stuck supabase and pnpm dev-db processes..."
pkill -9 -f "supabase start" 2>/dev/null || true
pkill -9 -f "supabase stop"  2>/dev/null || true
pkill -9 -f "pnpm dev-db"   2>/dev/null || true

echo "==> Killing stuck colima processes..."
pkill -9 -f "colima stop"   2>/dev/null || true
pkill -9 -f "colima start"  2>/dev/null || true

echo "==> Killing colima daemon and Lima hostagent..."
pkill -9 -f "colima daemon start" 2>/dev/null || true
pkill -9 -f "limactl hostagent"   2>/dev/null || true

sleep 2

echo "==> Removing stale Lima disk lock (if present)..."
DISK_LOCK="$HOME/.colima/_lima/_disks/colima/in_use_by"
if [ -L "$DISK_LOCK" ] || [ -e "$DISK_LOCK" ]; then
  rm -rf "$DISK_LOCK"
  echo "    Removed: $DISK_LOCK"
else
  echo "    No stale lock found."
fi

echo "==> Removing stale pid/sock files (if present)..."
rm -f "$HOME/.colima/_lima/colima/ha.pid" 2>/dev/null || true
rm -f "$HOME/.colima/_lima/colima/ha.sock" 2>/dev/null || true

echo "==> Starting Colima..."
colima start

echo ""
echo "Colima is up. Run 'pnpm dev-db' to start Supabase."
