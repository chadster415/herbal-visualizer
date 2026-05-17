import { NextResponse } from 'next/server'
import { cookies } from 'next/headers'

export async function POST(request: Request) {
  const { token } = await request.json()

  const form = new FormData()
  form.append('secret', process.env.TURNSTILE_SECRET_KEY!)
  form.append('response', token)

  const result = await fetch('https://challenges.cloudflare.com/turnstile/v0/siteverify', {
    method: 'POST',
    body: form,
  })
  const data = await result.json()

  if (!data.success) {
    return NextResponse.json({ success: false }, { status: 403 })
  }

  const cookieStore = await cookies()
  cookieStore.set('_hv_verified', '1', {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'lax',
    maxAge: 60 * 60 * 24 * 7, // 7 days
  })

  return NextResponse.json({ success: true })
}
