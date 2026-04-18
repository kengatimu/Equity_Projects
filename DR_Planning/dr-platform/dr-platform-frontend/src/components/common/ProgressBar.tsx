import clsx from 'clsx'

interface ProgressBarProps {
  value: number      // 0-100
  label?: string
  showPercent?: boolean
  size?: 'sm' | 'md'
  colorClass?: string
}

export default function ProgressBar({
  value,
  label,
  showPercent = true,
  size = 'sm',
  colorClass,
}: ProgressBarProps) {
  const pct = Math.min(Math.max(Math.round(value), 0), 100)

  const autoColor =
    pct >= 80 ? 'bg-green-500' :
    pct >= 50 ? 'bg-amber-500' :
    'bg-red-500'

  return (
    <div className="w-full">
      {(label || showPercent) && (
        <div className="flex justify-between items-center mb-1">
          {label && <span className="text-xs text-gray-500">{label}</span>}
          {showPercent && <span className="text-xs font-semibold text-gray-700">{pct}%</span>}
        </div>
      )}
      <div className={clsx('w-full bg-gray-100 rounded-full overflow-hidden', size === 'md' ? 'h-3' : 'h-2')}>
        <div
          className={clsx('h-full rounded-full transition-all duration-500', colorClass ?? autoColor)}
          style={{ width: `${pct}%` }}
        />
      </div>
    </div>
  )
}
