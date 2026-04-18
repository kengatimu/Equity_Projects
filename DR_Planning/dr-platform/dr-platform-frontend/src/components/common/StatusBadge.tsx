import clsx from 'clsx'

type StatusVariant = 'success' | 'warning' | 'danger' | 'info' | 'default' | 'purple'

const statusMap: Record<string, StatusVariant> = {
  // Campaign statuses
  DRAFT:         'default',
  PRE_DR_OPEN:   'info',
  APPROVED:      'success',
  IN_PROGRESS:   'purple',
  COMPLETED:     'success',
  CANCELLED:     'danger',
  // Campaign application statuses
  PLANNED:          'default',
  IN_EXECUTION:     'purple',
  VALIDATION:       'warning',
  ROLLED_BACK:      'danger',
  DEFERRED:         'warning',
  // Checklist
  PENDING:          'default',
  IN_PROGRESS_CI:   'info',
  DONE:             'success',
  BLOCKED:          'danger',
  CARRIED_FORWARD:  'warning',
  VERIFIED:         'success',
  // Tiers
  T1: 'danger',
  T2: 'warning',
  T3: 'info',
}

const variantClasses: Record<StatusVariant, string> = {
  success: 'bg-green-50  text-green-700  ring-green-200',
  warning: 'bg-amber-50  text-amber-700  ring-amber-200',
  danger:  'bg-red-50    text-red-700    ring-red-200',
  info:    'bg-blue-50   text-blue-700   ring-blue-200',
  purple:  'bg-purple-50 text-purple-700 ring-purple-200',
  default: 'bg-gray-100  text-gray-600   ring-gray-200',
}

interface StatusBadgeProps {
  status: string
  label?: string
  size?: 'sm' | 'md'
}

export default function StatusBadge({ status, label, size = 'sm' }: StatusBadgeProps) {
  // normalise IN_PROGRESS to avoid checklist collision
  const key = status === 'IN_PROGRESS' && label?.includes('checklist') ? 'IN_PROGRESS_CI' : status
  const variant = statusMap[key] ?? 'default'
  const text = label ?? status.replace(/_/g, ' ')

  return (
    <span
      className={clsx(
        'badge ring-1',
        variantClasses[variant],
        size === 'md' ? 'px-3 py-1 text-sm' : 'px-2.5 py-0.5 text-xs',
      )}
    >
      {text}
    </span>
  )
}
