'use client';

interface Props {
  temperature?: string | null;
  moisture?: string | null;
  tone?: string | null;
  taste?: string | null;
  temperatureInferred?: boolean;
  moistureInferred?: boolean;
  toneInferred?: boolean;
  tasteInferred?: boolean;
  className?: string;
}

function EmojiTip({ emoji, label, inferred }: { emoji: string; label: string; inferred?: boolean }) {
  return (
    <span className={`relative inline-block group/etip${inferred ? ' opacity-40' : ''}`}>
      {emoji}
      <span className="pointer-events-none absolute right-full top-1/2 -translate-y-1/2 mr-1.5 px-2 py-1 rounded bg-gray-800 text-white text-xs whitespace-nowrap opacity-0 group-hover/etip:opacity-100 transition-opacity z-[200]">
        {label}{inferred ? ' (inferred)' : ''}
        <span className="absolute left-full top-1/2 -translate-y-1/2 border-4 border-transparent border-l-gray-800" />
      </span>
    </span>
  );
}

export function EnergeticEmojis({ temperature, moisture, tone, taste, temperatureInferred, moistureInferred, toneInferred, tasteInferred, className }: Props) {
  const emojis: { emoji: string; label: string; inferred?: boolean }[] = [];

  if (temperature === 'warming') emojis.push({ emoji: '🔥', label: 'Warming', inferred: temperatureInferred });
  if (temperature === 'cooling') emojis.push({ emoji: '❄️', label: 'Cooling', inferred: temperatureInferred });
  if (moisture === 'moistening') emojis.push({ emoji: '💧', label: 'Moistening', inferred: moistureInferred });
  if (moisture === 'drying')     emojis.push({ emoji: '🌵', label: 'Drying', inferred: moistureInferred });
  if (tone === 'toning')         emojis.push({ emoji: '⚡', label: 'Toning', inferred: toneInferred });
  if (tone === 'relaxing')       emojis.push({ emoji: '🌊', label: 'Relaxing', inferred: toneInferred });
  if (taste === 'sweet')         emojis.push({ emoji: '🍯', label: 'Sweet taste', inferred: tasteInferred });
  if (taste === 'bitter')        emojis.push({ emoji: '☕', label: 'Bitter taste', inferred: tasteInferred });
  if (taste === 'pungent')       emojis.push({ emoji: '🌶️', label: 'Pungent taste', inferred: tasteInferred });
  if (taste === 'salty')         emojis.push({ emoji: '🧂', label: 'Salty taste', inferred: tasteInferred });
  if (taste === 'sour')          emojis.push({ emoji: '🍋', label: 'Sour taste', inferred: tasteInferred });

  if (emojis.length === 0) return null;

  return (
    <span className={`inline-flex gap-1 ${className ?? ''}`}>
      {emojis.map(({ emoji, label, inferred }) => (
        <EmojiTip key={emoji} emoji={emoji} label={label} inferred={inferred} />
      ))}
    </span>
  );
}
