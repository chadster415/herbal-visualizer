'use client';

import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/lib/supabase';

const BASE_URL = process.env.NEXT_PUBLIC_HERB_IMAGES_BASE_URL ?? '';

interface Props {
  herbId: number;
  isLoggedIn?: boolean;
}

export function HerbImageUpload({ herbId, isLoggedIn }: Props) {
  const imageUrl = `${BASE_URL}/herb-images/${herbId}.png`;
  // null = still probing, true = exists, false = missing
  const [exists, setExists] = useState<boolean | null>(null);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [lightboxOpen, setLightboxOpen] = useState(false);

  async function getToken(): Promise<string | null> {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  const upload = useCallback(async (blob: Blob) => {
    setUploading(true);
    setError(null);
    try {
      const token = await getToken();
      const presignRes = await fetch('/api/herb-image/presign', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify({ herbId }),
      });
      if (!presignRes.ok) throw new Error('Failed to get upload URL');
      const { uploadUrl } = await presignRes.json();

      const putRes = await fetch(uploadUrl, {
        method: 'PUT',
        body: blob,
        headers: { 'Content-Type': 'image/png' },
      });
      if (!putRes.ok) throw new Error('S3 upload failed');

      setExists(true);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Upload failed');
    } finally {
      setUploading(false);
    }
  }, [herbId]);

  const handleRemove = useCallback(async () => {
    setError(null);
    try {
      const token = await getToken();
      const res = await fetch(`/api/herb-image/${herbId}`, {
        method: 'DELETE',
        headers: token ? { Authorization: `Bearer ${token}` } : {},
      });
      if (!res.ok) throw new Error('Failed to remove image');
      setExists(false);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Remove failed');
    }
  }, [herbId]);

  // Paste-to-upload — only active when logged in
  useEffect(() => {
    if (!isLoggedIn) return;
    function handlePaste(e: ClipboardEvent) {
      const items = e.clipboardData?.items;
      if (!items) return;
      for (const item of Array.from(items)) {
        if (item.type.startsWith('image/')) {
          const blob = item.getAsFile();
          if (blob) {
            e.preventDefault();
            upload(blob);
            break;
          }
        }
      }
    }
    document.addEventListener('paste', handlePaste);
    return () => document.removeEventListener('paste', handlePaste);
  }, [upload, isLoggedIn]);

  // Reset probe when switching herbs
  useEffect(() => { setExists(null); setError(null); }, [herbId]);

  if (exists === true) {
    const src = `${imageUrl}?v=${herbId}`;
    return (
      <>
        <div className="relative mb-4 group">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={src}
            alt="Herb reference"
            onClick={() => setLightboxOpen(true)}
            className="w-full max-h-72 object-contain rounded-lg border border-gray-200 bg-gray-50 cursor-zoom-in"
          />
          {isLoggedIn && (
            <div className="absolute top-2 right-2 flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
              <span className="text-xs text-gray-400 bg-white/90 px-2 py-1 rounded-full border border-gray-200">
                ⌘V to replace
              </span>
              <button
                onClick={handleRemove}
                className="text-xs text-red-400 bg-white/90 px-2 py-1 rounded-full border border-red-200 hover:text-red-600 hover:border-red-400 transition-colors"
              >
                Remove
              </button>
            </div>
          )}
          {error && <p className="mt-1 text-xs text-red-400">{error}</p>}
        </div>

        {lightboxOpen && (
          <div
            className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm"
            onClick={() => setLightboxOpen(false)}
          >
            <button
              onClick={() => setLightboxOpen(false)}
              className="absolute top-4 right-4 text-white/80 hover:text-white bg-black/30 hover:bg-black/50 rounded-full w-9 h-9 flex items-center justify-center transition-colors"
              aria-label="Close"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={src}
              alt="Herb reference"
              onClick={(e) => e.stopPropagation()}
              className="max-w-[90vw] max-h-[90vh] object-contain rounded-lg shadow-2xl"
            />
          </div>
        )}
      </>
    );
  }

  return (
    <>
      {/* Hidden probe image — sets exists based on whether S3 object is there */}
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img src={imageUrl} alt="" className="hidden" onLoad={() => setExists(true)} onError={() => setExists(false)} />

      {exists === false && isLoggedIn && (
        <div className="mb-4">
          <div
            className={`border-2 border-dashed rounded-lg py-5 flex flex-col items-center justify-center gap-1.5 transition-colors ${
              uploading
                ? 'border-green-300 bg-green-50'
                : 'border-gray-200 hover:border-green-300 hover:bg-green-50/40'
            }`}
          >
            {uploading ? (
              <div className="flex items-center gap-2 text-green-600 text-sm">
                <svg className="w-4 h-4 animate-spin" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
                </svg>
                Uploading…
              </div>
            ) : (
              <>
                <span className="text-4xl font-thin text-gray-300 leading-none">+</span>
                <span className="text-xs text-gray-400">⌘V to add herb image</span>
              </>
            )}
            {error && <span className="text-xs text-red-400 mt-1">{error}</span>}
          </div>
        </div>
      )}
    </>
  );
}
