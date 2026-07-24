'use client';

interface Props {
  temperature?: string | null;
  moisture?: string | null;
  tone?: string | null;
  className?: string;
}

function EmojiTip({ emoji, label }: { emoji: string; label: string }) {
  return (
    <span className="relative inline-block group/etip">
      {emoji}
      <span className="pointer-events-none absolute bottom-full left-1/2 -translate-x-1/2 mb-1.5 px-2 py-1 rounded bg-gray-800 text-white text-xs whitespace-nowrap opacity-0 group-hover/etip:opacity-100 transition-opacity z-[200]">
        {label}
        <span className="absolute top-full left-1/2 -translate-x-1/2 border-4 border-transparent border-t-gray-800" />
      </span>
    </span>
  );
}

export function EnergeticEmojis({ temperature, moisture, tone, className }: Props) {
  const emojis: { emoji: string; label: string }[] = [];

  if (temperature === 'warming') emojis.push({ emoji: '🔥', label: 'Warming' });
  if (temperature === 'cooling') emojis.push({ emoji: '❄️', label: 'Cooling' });
  if (moisture === 'moistening') emojis.push({ emoji: '💧', label: 'Moistening' });
  if (moisture === 'drying')     emojis.push({ emoji: '🌵', label: 'Drying' });
  if (tone === 'toning')         emojis.push({ emoji: '⚡', label: 'Toning' });
  if (tone === 'relaxing')       emojis.push({ emoji: '🌊', label: 'Relaxing' });

  if (emojis.length === 0) return null;

  return (
    <span className={className}>
      {emojis.map(({ emoji, label }) => (
        <EmojiTip key={emoji} emoji={emoji} label={label} />
      ))}
    </span>
  );
}
