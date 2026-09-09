'use client';

import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/lib/supabase';

const BASE_URL = process.env.NEXT_PUBLIC_HERB_IMAGES_BASE_URL ?? '';

interface Props {
  recipeId: number;
  isLoggedIn?: boolean;
}

export function RecipeImageUpload({ recipeId, isLoggedIn }: Props) {
  const [imageKey, setImageKey] = useState<string | null | undefined>(undefined);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [lightboxOpen, setLightboxOpen] = useState(false);

  const loadImage = useCallback(async () => {
    const { data } = await supabase
      .from('recipe_images')
      .select('image_key')
      .eq('recipe_id', recipeId)
      .order('created_at', { ascending: false })
      .limit(1)
      .maybeSingle();
    setImageKey(data?.image_key ?? null);
  }, [recipeId]);

  useEffect(() => {
    setImageKey(undefined);
    setError(null);
    loadImage();
  }, [recipeId, loadImage]);

  const upload = useCallback(async (blob: Blob) => {
    setUploading(true);
    setError(null);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token ?? null;

      const presignRes = await fetch('/api/recipe-image/presign', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify({ recipeId }),
      });
      if (!presignRes.ok) throw new Error('Failed to get upload URL');
      const { uploadUrl, imageKey: newKey } = await presignRes.json();

      const putRes = await fetch(uploadUrl, {
        method: 'PUT',
        body: blob,
        headers: { 'Content-Type': 'image/png' },
      });
      if (!putRes.ok) throw new Error('Upload failed');

      // Remove previous image if any
      if (imageKey) {
        await supabase.from('recipe_images').delete().eq('recipe_id', recipeId).eq('image_key', imageKey);
      }
      await supabase.from('recipe_images').insert({ recipe_id: recipeId, image_key: newKey });

      setImageKey(newKey);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Upload failed');
    } finally {
      setUploading(false);
    }
  }, [recipeId, imageKey]);

  const handleRemove = useCallback(async () => {
    if (!imageKey) return;
    setError(null);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token ?? null;
      const res = await fetch(`/api/recipe-image/${recipeId}?key=${encodeURIComponent(imageKey)}`, {
        method: 'DELETE',
        headers: token ? { Authorization: `Bearer ${token}` } : {},
      });
      if (!res.ok) throw new Error('Failed to remove image');
      await supabase.from('recipe_images').delete().eq('recipe_id', recipeId).eq('image_key', imageKey);
      setImageKey(null);
      setLightboxOpen(false);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Remove failed');
    }
  }, [recipeId, imageKey]);

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

  if (imageKey === undefined) {
    return <div className="mb-5 h-48 bg-gray-50 rounded-lg animate-pulse" />;
  }

  if (!imageKey && !isLoggedIn) return null;

  const imgUrl = imageKey ? `${BASE_URL}/${imageKey}` : null;

  return (
    <>
      <div className="mb-6">
        {imgUrl ? (
          <div className="relative group inline-block">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={imgUrl}
              alt="Recipe reference"
              onClick={() => setLightboxOpen(true)}
              className="max-h-64 w-auto object-cover rounded-xl border border-gray-200 shadow-sm cursor-zoom-in"
            />
            {isLoggedIn && (
              <button
                onClick={handleRemove}
                className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity text-xs text-red-400 bg-white/90 px-2 py-1 rounded-full border border-red-200 hover:text-red-600 hover:border-red-400"
              >
                Remove
              </button>
            )}
          </div>
        ) : (
          isLoggedIn && (
            <div
              className={`h-32 w-48 border-2 border-dashed rounded-xl flex flex-col items-center justify-center gap-1 transition-colors ${
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
          )
        )}
        {error && <p className="mt-1 text-xs text-red-400">{error}</p>}
      </div>

      {lightboxOpen && imgUrl && (
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
            src={imgUrl}
            alt="Recipe reference"
            onClick={(e) => e.stopPropagation()}
            className="max-w-[90vw] max-h-[90vh] object-contain rounded-lg shadow-2xl"
          />
        </div>
      )}
    </>
  );
}
