'use client';

import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/lib/supabase';

const BASE_URL = process.env.NEXT_PUBLIC_HERB_IMAGES_BASE_URL ?? '';

interface HerbImage {
  key: string;
  url: string;
}

interface Props {
  herbId: number;
  isLoggedIn?: boolean;
}

export function HerbImageUpload({ herbId, isLoggedIn }: Props) {
  const [images, setImages] = useState<HerbImage[] | null>(null);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null);

  async function getToken(): Promise<string | null> {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  // Load images directly from the browser Supabase client — no API round-trip needed
  const loadImages = useCallback(async () => {
    const { data: rows } = await supabase
      .from('herb_images')
      .select('image_key')
      .eq('herb_id', herbId)
      .order('created_at', { ascending: true });
    setImages((rows ?? []).map(row => ({
      key: row.image_key,
      url: `${BASE_URL}/${row.image_key}`,
    })));
  }, [herbId]);

  useEffect(() => {
    setImages(null);
    setError(null);
    loadImages();
  }, [herbId, loadImages]);

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
      const { uploadUrl, imageKey } = await presignRes.json();

      const putRes = await fetch(uploadUrl, {
        method: 'PUT',
        body: blob,
        headers: { 'Content-Type': 'image/png' },
      });
      if (!putRes.ok) throw new Error('S3 upload failed');

      // Register in DB directly from browser client
      await supabase.from('herb_images').insert({ herb_id: herbId, image_key: imageKey });

      setImages(prev => [
        ...(prev ?? []),
        { key: imageKey, url: `${BASE_URL}/${imageKey}?v=${Date.now()}` },
      ]);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Upload failed');
    } finally {
      setUploading(false);
    }
  }, [herbId]);

  const handleRemove = useCallback(async (key: string) => {
    setError(null);
    try {
      const token = await getToken();
      const res = await fetch(`/api/herb-image/${herbId}?key=${encodeURIComponent(key)}`, {
        method: 'DELETE',
        headers: token ? { Authorization: `Bearer ${token}` } : {},
      });
      if (!res.ok) throw new Error('Failed to remove image');

      // Remove from DB directly from browser client
      await supabase.from('herb_images').delete().eq('herb_id', herbId).eq('image_key', key);

      setImages(prev => (prev ?? []).filter(img => img.key !== key));
      setLightboxIndex(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Remove failed');
    }
  }, [herbId]);

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

  if (images === null) {
    return <div className="mb-4 h-16 bg-gray-50 rounded-lg animate-pulse" />;
  }

  if (images.length === 0 && !isLoggedIn) {
    return null;
  }

  return (
    <>
      <div className="mb-4">
        <div className="flex gap-3 overflow-x-auto pb-1">
          {images.map((img, i) => (
            <div key={img.key} className="relative flex-shrink-0 group">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={img.url}
                alt={`Herb reference ${i + 1}`}
                onClick={() => setLightboxIndex(i)}
                className="h-48 w-auto max-w-xs object-cover rounded-lg border border-gray-200 bg-gray-50 cursor-zoom-in"
              />
              {isLoggedIn && (
                <button
                  onClick={() => handleRemove(img.key)}
                  className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity text-xs text-red-400 bg-white/90 px-2 py-1 rounded-full border border-red-200 hover:text-red-600 hover:border-red-400"
                >
                  Remove
                </button>
              )}
            </div>
          ))}

          {isLoggedIn && (
            <div
              className={`flex-shrink-0 h-48 w-32 border-2 border-dashed rounded-lg flex flex-col items-center justify-center gap-1 transition-colors ${
                uploading
                  ? 'border-green-300 bg-green-50'
                  : 'border-gray-200 hover:border-green-300 hover:bg-green-50/40'
              }`}
            >
              {uploading ? (
                <div className="flex flex-col items-center gap-2 text-green-600 text-sm">
                  <svg className="w-4 h-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
                  </svg>
                  Uploading…
                </div>
              ) : (
                <>
                  <span className="text-4xl font-thin text-gray-300 leading-none">+</span>
                  <span className="text-xs text-gray-400 text-center px-2">⌘V to add image</span>
                </>
              )}
            </div>
          )}
        </div>
        {error && <p className="mt-1 text-xs text-red-400">{error}</p>}
      </div>

      {lightboxIndex !== null && images[lightboxIndex] && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm"
          onClick={() => setLightboxIndex(null)}
        >
          <button
            onClick={() => setLightboxIndex(null)}
            className="absolute top-4 right-4 text-white/80 hover:text-white bg-black/30 hover:bg-black/50 rounded-full w-9 h-9 flex items-center justify-center transition-colors"
            aria-label="Close"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={images[lightboxIndex].url}
            alt="Herb reference"
            onClick={(e) => e.stopPropagation()}
            className="max-w-[90vw] max-h-[90vh] object-contain rounded-lg shadow-2xl"
          />
        </div>
      )}
    </>
  );
}
