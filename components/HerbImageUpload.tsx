'use client';

import { useState, useEffect, useCallback } from 'react';

interface Props {
  herbId: number;
  imageUrl: string | null | undefined;
  onImageUpdate: (url: string | null) => void;
}

export function HerbImageUpload({ herbId, imageUrl, onImageUpdate }: Props) {
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const upload = useCallback(async (blob: Blob) => {
    setUploading(true);
    setError(null);
    try {
      const presignRes = await fetch('/api/herb-image/presign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ herbId, contentType: blob.type || 'image/png' }),
      });
      if (!presignRes.ok) throw new Error('Failed to get upload URL');
      const { uploadUrl, publicUrl } = await presignRes.json();

      const putRes = await fetch(uploadUrl, {
        method: 'PUT',
        body: blob,
        headers: { 'Content-Type': blob.type || 'image/png' },
      });
      if (!putRes.ok) throw new Error('S3 upload failed');

      const patchRes = await fetch(`/api/herb-image/${herbId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ imageUrl: publicUrl }),
      });
      if (!patchRes.ok) throw new Error('Failed to save image');

      onImageUpdate(publicUrl);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Upload failed');
    } finally {
      setUploading(false);
    }
  }, [herbId, onImageUpdate]);

  const handleRemove = useCallback(async () => {
    setError(null);
    try {
      const res = await fetch(`/api/herb-image/${herbId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ imageUrl: null }),
      });
      if (!res.ok) throw new Error('Failed to remove image');
      onImageUpdate(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Remove failed');
    }
  }, [herbId, onImageUpdate]);

  useEffect(() => {
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
  }, [upload]);

  if (imageUrl) {
    return (
      <div className="relative mb-4 group">
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={imageUrl}
          alt="Herb reference"
          className="w-full max-h-72 object-contain rounded-lg border border-gray-200 bg-gray-50"
        />
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
        {error && <p className="mt-1 text-xs text-red-400">{error}</p>}
      </div>
    );
  }

  return (
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
  );
}
