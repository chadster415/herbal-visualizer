import { NextResponse } from 'next/server';

export async function GET() {
  return NextResponse.json({
    status: 'healthy',
    system: 'Herbal Visualizer',
    service: 'herbal-visualizer',
    timestamp: new Date().toISOString(),
  });
}
