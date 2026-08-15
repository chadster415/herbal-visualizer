import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const verified = request.cookies.get('_hv_verified')
  if (!verified) {
    const url = request.nextUrl.clone()
    url.pathname = '/gateway'
    return NextResponse.redirect(url)
  }
  return NextResponse.next()
}

export const config = {
  matcher: ['/((?!gateway|api|_next|favicon\\.ico|.*\\.(?:jpg|jpeg|png|gif|svg|webp|ico)$).*)'],
}
