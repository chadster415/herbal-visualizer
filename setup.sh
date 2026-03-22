#!/bin/bash

echo "🌿 Herbal Medicine Visualizer Setup"
echo "===================================="
echo ""

# Check if Supabase CLI is installed
if ! command -v supabase &> /dev/null; then
    echo "❌ Supabase CLI not found"
    echo "📦 Installing Supabase CLI..."
    brew install supabase/tap/supabase
fi

echo "✅ Supabase CLI found"
echo ""

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running"
    echo "Please start Docker Desktop and run this script again"
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Initialize Supabase if not already done
if [ ! -d "supabase" ]; then
    echo "🔧 Initializing Supabase..."
    supabase init
fi

echo "🚀 Starting Supabase..."
supabase start

echo ""
echo "📊 Applying database migrations..."
supabase db reset --db-url postgresql://postgres:postgres@localhost:54322/postgres

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'pnpm dev' to start the development server"
echo "2. Open http://localhost:3000 in your browser"
echo ""
echo "Supabase Studio: http://localhost:54323"
echo "Database URL: postgresql://postgres:postgres@localhost:54322/postgres"
