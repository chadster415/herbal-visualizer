'use client'

import { Turnstile } from '@marsidev/react-turnstile'
import { useRouter } from 'next/navigation'
import { useState } from 'react'

export default function GatewayPage() {
  const router = useRouter()
  const [error, setError] = useState(false)

  async function handleSuccess(token: string) {
    setError(false)
    const res = await fetch('/api/verify-turnstile', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ token }),
    })
    if (res.ok) {
      router.push('/')
    } else {
      setError(true)
    }
  }

  return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-6 p-8">
      <div className="text-center space-y-2">
        <h1 className="text-2xl font-semibold tracking-tight">Herbal Medicine Visualizer</h1>
        <p className="text-sm opacity-60">Verifying you&apos;re human…</p>
      </div>

      <Turnstile
        siteKey={process.env.NEXT_PUBLIC_TURNSTILE_SITE_KEY!}
        onSuccess={handleSuccess}
        onError={() => setError(true)}
      />

      {error && (
        <p className="text-sm text-red-500">Verification failed — please refresh and try again.</p>
      )}
    </div>
  )
}
