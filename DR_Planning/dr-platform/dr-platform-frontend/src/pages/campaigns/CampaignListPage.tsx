import { useEffect, useRef, useState } from 'react'
import { Link } from 'react-router-dom'
import { useCampaigns, useCreateCampaign } from '../../hooks/useCampaigns'
import StatusBadge from '../../components/common/StatusBadge'
import { Calendar, Check, CheckCircle2, ChevronDown, Moon, Plus, Shield, Sun, Sunrise, Sunset, X } from 'lucide-react'
import { format, parseISO } from 'date-fns'

// ── Constants ─────────────────────────────────────────────────────────────────

const QUARTERS = [
  { code: 'Q1', label: 'Q1', range: 'Jan – Mar' },
  { code: 'Q2', label: 'Q2', range: 'Apr – Jun' },
  { code: 'Q3', label: 'Q3', range: 'Jul – Sep' },
  { code: 'Q4', label: 'Q4', range: 'Oct – Dec' },
] as const

const HALVES = [
  { code: 'H1', label: 'H1', range: 'January – June',   sub: '1st half of the year' },
  { code: 'H2', label: 'H2', range: 'July – December',  sub: '2nd half of the year' },
] as const

const TIME_GROUPS = [
  {
    id: 'night',
    Icon: Moon,
    label: 'Night',
    range: '00:00 – 05:00',
    recommended: true,
    iconBg: 'bg-indigo-50',
    iconColor: 'text-indigo-400',
    hours: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00'],
  },
  {
    id: 'morning',
    Icon: Sunrise,
    label: 'Morning',
    range: '06:00 – 11:00',
    recommended: false,
    iconBg: 'bg-amber-50',
    iconColor: 'text-amber-400',
    hours: ['06:00', '07:00', '08:00', '09:00', '10:00', '11:00'],
  },
  {
    id: 'afternoon',
    Icon: Sun,
    label: 'Afternoon',
    range: '12:00 – 17:00',
    recommended: false,
    iconBg: 'bg-orange-50',
    iconColor: 'text-orange-400',
    hours: ['12:00', '13:00', '14:00', '15:00', '16:00', '17:00'],
  },
  {
    id: 'evening',
    Icon: Sunset,
    label: 'Evening',
    range: '18:00 – 23:00',
    recommended: false,
    iconBg: 'bg-purple-50',
    iconColor: 'text-purple-400',
    hours: ['18:00', '19:00', '20:00', '21:00', '22:00', '23:00'],
  },
]

const SUBSIDIARIES = [
  { code: 'KE', name: 'Equity Bank Kenya' },
  { code: 'UG', name: 'Equity Bank Uganda' },
  { code: 'TZ', name: 'Equity Bank Tanzania' },
  { code: 'RW', name: 'Equity Bank Rwanda' },
  { code: 'SS', name: 'Equity Bank South Sudan' },
  { code: 'CD', name: 'Equity BCDC (DRC)' },
  { code: 'ET', name: 'Equity Bank Ethiopia' },
]

type PeriodType = 'quarter' | 'half'

function emptyForm() {
  return {
    name: '',
    periodType: 'quarter' as PeriodType,
    period: 'Q1',
    year: new Date().getFullYear(),
    subsidiaryIds: [] as string[],
    plannedDrDate: '',
    preferredStartTime: '',
    description: '',
  }
}

// ── Subsidiary multi-select ───────────────────────────────────────────────────
function SubsidiaryPicker({ value, onChange }: { value: string[]; onChange: (ids: string[]) => void }) {
  const [open, setOpen] = useState(false)
  const ref = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const handler = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false)
    }
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  }, [])

  const toggle = (code: string) =>
    onChange(value.includes(code) ? value.filter(c => c !== code) : [...value, code])
  const allSelected = value.length === SUBSIDIARIES.length
  const toggleAll = () => onChange(allSelected ? [] : SUBSIDIARIES.map(s => s.code))
  const remove = (code: string, e: React.MouseEvent) => { e.stopPropagation(); onChange(value.filter(c => c !== code)) }

  return (
    <div ref={ref} className="relative">
      <button
        type="button"
        onClick={() => setOpen(o => !o)}
        className={`input w-full text-left flex items-center gap-2 min-h-[42px] pr-9 flex-wrap
          ${open ? 'ring-2 ring-equity-red/30 border-equity-red/40' : ''}`}
      >
        {value.length === 0 ? (
          <span className="text-gray-400 text-sm">— select subsidiaries —</span>
        ) : (
          <div className="flex flex-wrap gap-1.5">
            {value.map(code => (
              <span key={code} className="inline-flex items-center gap-1 px-2 py-0.5 rounded-md bg-equity-red/8 border border-equity-red/20 text-equity-red text-xs font-semibold">
                {code}
                <span role="button" onClick={e => remove(code, e)} className="hover:text-equity-red/60 cursor-pointer">
                  <X size={10} strokeWidth={2.5} />
                </span>
              </span>
            ))}
          </div>
        )}
        <ChevronDown size={14} className={`absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 transition-transform ${open ? 'rotate-180' : ''}`} />
      </button>

      {open && (
        <div className="absolute z-50 top-full mt-1.5 w-full bg-white border border-gray-200 rounded-xl shadow-lg overflow-hidden">
          <div className="flex items-center justify-between px-3 py-2 bg-gray-50 border-b border-gray-100">
            <span className="text-[11px] text-gray-400 font-medium">{value.length} of {SUBSIDIARIES.length} selected</span>
            <button type="button" onClick={toggleAll} className="text-[11px] text-equity-red font-semibold hover:underline">
              {allSelected ? 'Clear all' : 'Select all'}
            </button>
          </div>
          <ul className="py-1 max-h-52 overflow-y-auto">
            {SUBSIDIARIES.map(sub => {
              const selected = value.includes(sub.code)
              return (
                <li key={sub.code}>
                  <button type="button" onClick={() => toggle(sub.code)}
                    className={`w-full flex items-center gap-3 px-3 py-2.5 text-left transition-colors
                      ${selected ? 'bg-equity-red/5 text-equity-red' : 'hover:bg-gray-50 text-gray-700'}`}>
                    <span className={`w-4 h-4 rounded border-2 flex items-center justify-center shrink-0 transition-colors
                      ${selected ? 'bg-equity-red border-equity-red' : 'border-gray-300 bg-white'}`}>
                      {selected && <Check size={10} strokeWidth={3} className="text-white" />}
                    </span>
                    <span className="flex items-center gap-2 flex-1 min-w-0">
                      <span className={`text-xs font-bold tabular-nums w-6 ${selected ? 'text-equity-red' : 'text-gray-400'}`}>{sub.code}</span>
                      <span className="text-sm truncate">{sub.name}</span>
                    </span>
                  </button>
                </li>
              )
            })}
          </ul>
        </div>
      )}
    </div>
  )
}

// ── Period picker ─────────────────────────────────────────────────────────────
function PeriodPicker({ periodType, period, onTypeChange, onPeriodChange }: {
  periodType: PeriodType; period: string
  onTypeChange: (t: PeriodType) => void; onPeriodChange: (p: string) => void
}) {
  return (
    <div className="space-y-2.5">
      <div className="flex gap-1 p-1 bg-gray-100 rounded-xl w-fit">
        {(['quarter', 'half'] as PeriodType[]).map(type => (
          <button key={type} type="button"
            onClick={() => { onTypeChange(type); onPeriodChange(type === 'quarter' ? 'Q1' : 'H1') }}
            className={`px-4 py-1.5 rounded-lg text-xs font-semibold transition-all ${
              periodType === type ? 'bg-white shadow-sm text-gray-800' : 'text-gray-500 hover:text-gray-700'
            }`}>
            {type === 'quarter' ? 'Quarterly' : 'Half-Year'}
          </button>
        ))}
      </div>

      {periodType === 'quarter' && (
        <div>
          <div className="grid grid-cols-4 gap-2">
            {QUARTERS.map(q => (
              <button key={q.code} type="button" onClick={() => onPeriodChange(q.code)}
                className={`py-2.5 rounded-xl border-2 font-bold text-sm transition-all ${
                  period === q.code
                    ? 'border-equity-red bg-equity-red/5 text-equity-red'
                    : 'border-gray-200 hover:border-gray-300 text-gray-600'
                }`}>
                {q.label}
              </button>
            ))}
          </div>
          <p className="text-[11px] text-gray-400 mt-1.5">{QUARTERS.find(q => q.code === period)?.range}</p>
        </div>
      )}

      {periodType === 'half' && (
        <div className="grid grid-cols-2 gap-2">
          {HALVES.map(h => (
            <button key={h.code} type="button" onClick={() => onPeriodChange(h.code)}
              className={`py-3 px-4 rounded-xl border-2 text-left transition-all ${
                period === h.code ? 'border-equity-red bg-equity-red/5' : 'border-gray-200 hover:border-gray-300'
              }`}>
              <p className={`text-sm font-bold ${period === h.code ? 'text-equity-red' : 'text-gray-700'}`}>{h.label}</p>
              <p className={`text-[11px] mt-0.5 ${period === h.code ? 'text-equity-red/70' : 'text-gray-400'}`}>{h.range}</p>
              <p className={`text-[10px] mt-0.5 ${period === h.code ? 'text-equity-red/50' : 'text-gray-300'}`}>{h.sub}</p>
            </button>
          ))}
        </div>
      )}
    </div>
  )
}

// ── Start-time picker ─────────────────────────────────────────────────────────
function StartTimePicker({ value, onChange }: { value: string; onChange: (v: string) => void }) {
  // Default active tab = group containing current value, else Night (recommended)
  const [activeId, setActiveId] = useState<string>(() =>
    TIME_GROUPS.find(g => g.hours.includes(value))?.id ?? 'night'
  )

  // If parent clears the value, stay on current tab (no reset needed)
  const activeGroup = TIME_GROUPS.find(g => g.id === activeId)!

  return (
    <div className="space-y-2">
      {/* Tab strip */}
      <div className="flex gap-1 p-1 bg-gray-100 rounded-xl">
        {TIME_GROUPS.map(group => {
          const isActive = activeId === group.id
          const hasSelection = group.hours.includes(value)
          return (
            <button
              key={group.id}
              type="button"
              onClick={() => setActiveId(group.id)}
              className={`relative flex-1 flex flex-col items-center gap-0.5 py-1.5 rounded-lg transition-all ${
                isActive ? 'bg-white shadow-sm' : 'hover:bg-white/60'
              }`}
            >
              <group.Icon
                size={13}
                className={isActive ? group.iconColor : 'text-gray-400'}
              />
              <span className={`text-[10px] font-semibold ${isActive ? 'text-gray-700' : 'text-gray-400'}`}>
                {group.label}
              </span>
              {/* Dot indicator: red if has selected, indigo if recommended and empty */}
              {hasSelection ? (
                <span className="absolute top-1 right-1.5 w-1.5 h-1.5 rounded-full bg-equity-red" />
              ) : group.recommended && !value ? (
                <span className="absolute top-1 right-1.5 w-1.5 h-1.5 rounded-full bg-indigo-400" />
              ) : null}
            </button>
          )
        })}
      </div>

      {/* Range + recommended hint */}
      <div className="flex items-center gap-1.5 px-0.5">
        <span className="text-[11px] text-gray-400">{activeGroup.range} EAT</span>
        {activeGroup.recommended && (
          <span className="text-[10px] font-semibold text-indigo-500 bg-indigo-50 border border-indigo-100 rounded px-1.5 py-px">
            Recommended
          </span>
        )}
      </div>

      {/* Hour pills — 3 cols × 2 rows */}
      <div className="grid grid-cols-6 gap-1.5">
        {activeGroup.hours.map(hour => {
          const selected = value === hour
          return (
            <button
              key={hour}
              type="button"
              onClick={() => onChange(selected ? '' : hour)}
              className={`py-2 rounded-xl border text-xs font-medium transition-all ${
                selected
                  ? 'border-equity-red bg-equity-red text-white shadow-sm'
                  : 'border-gray-200 bg-white text-gray-600 hover:border-equity-red/40 hover:text-equity-red hover:bg-equity-red/5'
              }`}
            >
              {hour}
            </button>
          )
        })}
      </div>

      {/* Footer: selected state or hint */}
      <div className="flex items-center justify-between px-0.5 min-h-[16px]">
        {value ? (
          <>
            <p className="text-[11px] font-medium text-equity-red">✓ {value} EAT selected</p>
            <button type="button" onClick={() => onChange('')}
              className="text-[11px] text-gray-400 hover:text-gray-600 underline">
              Clear
            </button>
          </>
        ) : (
          <p className="text-[11px] text-gray-400">
            Select a time · click again to deselect
          </p>
        )}
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────────────────────────────────────

export default function CampaignListPage() {
  const [page, setPage] = useState(0)
  const [showModal, setShowModal] = useState(false)
  const [created, setCreated] = useState<{ name: string; period: string; year: number; subsidiaryIds: string[] } | null>(null)
  const { data, isLoading } = useCampaigns({ page, size: 10 })
  const createMutation = useCreateCampaign()
  const [form, setForm] = useState(emptyForm())

  const set = <K extends keyof ReturnType<typeof emptyForm>>(k: K, v: ReturnType<typeof emptyForm>[K]) =>
    setForm(f => ({ ...f, [k]: v }))

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault()
    await createMutation.mutateAsync({
      name: form.name,
      quarter: form.period,
      year: Number(form.year),
      subsidiaryIds: form.subsidiaryIds,
      plannedDrDate: form.plannedDrDate || undefined,
      preferredStartTime: form.preferredStartTime || undefined,
      description: form.description || undefined,
    })
    setCreated({ name: form.name, period: form.period, year: form.year, subsidiaryIds: form.subsidiaryIds })
  }

  const handleClose = () => {
    setShowModal(false)
    setCreated(null)
    setForm(emptyForm())
  }

  return (
    <div className="space-y-5 max-w-7xl">

      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">DR Campaigns</h1>
          <p className="text-gray-500 text-sm mt-0.5">{data?.totalElements ?? 0} campaigns total</p>
        </div>
        <button onClick={() => setShowModal(true)} className="btn-primary flex items-center gap-1.5">
          <Plus size={15} /> New Campaign
        </button>
      </div>

      {/* Campaign cards */}
      {isLoading ? (
        <div className="grid md:grid-cols-2 gap-4">
          {Array.from({ length: 4 }).map((_, i) => (
            <div key={i} className="card h-40 animate-pulse bg-gray-100" />
          ))}
        </div>
      ) : (data?.content.length ?? 0) === 0 ? (
        <div className="card py-16 text-center space-y-3">
          <Shield size={40} className="text-gray-200 mx-auto" />
          <p className="text-gray-500 font-medium">No campaigns yet</p>
          <p className="text-sm text-gray-400">Create your first DR campaign to start scheduling exercises.</p>
          <button onClick={() => setShowModal(true)} className="btn-primary inline-flex items-center gap-1.5 mt-1">
            <Plus size={14} /> New Campaign
          </button>
        </div>
      ) : (
        <div className="grid md:grid-cols-2 gap-4">
          {data?.content.map(c => (
            <Link key={c.id} to={`/campaigns/${c.id}`}
              className="card hover:shadow-md hover:border-equity-red/20 transition-all block">
              <div className="flex items-start justify-between mb-3">
                <div className="flex-1 min-w-0">
                  <p className="font-semibold text-gray-800 truncate">{c.name}</p>
                  <p className="text-xs text-gray-400 mt-0.5">
                    {c.quarter} {c.year}
                    {c.plannedDrDate ? ` · ${format(parseISO(c.plannedDrDate), 'dd MMM yyyy')}` : ''}
                  </p>
                  {c.subsidiaryIds?.length > 0 && (
                    <div className="flex flex-wrap gap-1 mt-1">
                      {c.subsidiaryIds.map(s => (
                        <span key={s} className="px-1.5 py-px rounded text-[10px] font-semibold bg-gray-100 text-gray-500">
                          {s}
                        </span>
                      ))}
                    </div>
                  )}
                </div>
                <StatusBadge status={c.status} />
              </div>
              {c.description && <p className="text-sm text-gray-500 line-clamp-2 mb-3">{c.description}</p>}
              <div className="flex items-center gap-2 text-xs text-gray-400">
                <Calendar size={12} />
                <span>Created {format(parseISO(c.createdAt), 'dd MMM yyyy')}</span>
              </div>
            </Link>
          ))}
        </div>
      )}

      {/* Pagination */}
      {data && data.totalPages > 1 && (
        <div className="flex justify-center gap-2">
          <button disabled={data.first} onClick={() => setPage(p => p - 1)} className="btn-secondary py-1.5 px-4 text-sm">Previous</button>
          <span className="flex items-center text-sm text-gray-500">Page {page + 1} of {data.totalPages}</span>
          <button disabled={data.last} onClick={() => setPage(p => p + 1)} className="btn-secondary py-1.5 px-4 text-sm">Next</button>
        </div>
      )}

      {/* ── New Campaign Modal ────────────────────────────────────────────────── */}
      {showModal && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm px-4"
          onClick={e => { if (e.target === e.currentTarget) handleClose() }}
        >
          <div className="bg-white rounded-2xl shadow-xl w-full max-w-lg max-h-[92vh] flex flex-col">

            {created ? (
              /* ── Success ───────────────────────────────────────────────── */
              <div className="p-8 text-center space-y-4">
                <div className="w-14 h-14 bg-green-50 rounded-full flex items-center justify-center mx-auto">
                  <CheckCircle2 size={30} className="text-green-500" />
                </div>
                <div>
                  <h3 className="text-base font-bold text-gray-900">Campaign Created</h3>
                  <p className="text-sm text-gray-500 mt-1">
                    <span className="font-semibold text-equity-red">{created.name}</span>{' '}
                    ({created.period} {created.year}) is ready.
                  </p>
                  {created.subsidiaryIds.length > 0 && (
                    <div className="flex flex-wrap justify-center gap-1.5 mt-2">
                      {created.subsidiaryIds.map(code => (
                        <span key={code} className="px-2 py-0.5 rounded-md bg-equity-red/8 border border-equity-red/20 text-equity-red text-xs font-semibold">
                          {code}
                        </span>
                      ))}
                    </div>
                  )}
                  <p className="text-xs text-gray-400 mt-3">Add applications to the campaign to begin scheduling.</p>
                </div>
                <div className="flex gap-2 pt-2">
                  <button onClick={handleClose} className="btn-secondary flex-1">Close</button>
                  <button onClick={() => { setCreated(null); setForm(emptyForm()) }} className="btn-primary flex-1">
                    New Campaign
                  </button>
                </div>
              </div>
            ) : (
              /* ── Form ──────────────────────────────────────────────────── */
              <form onSubmit={handleCreate} className="flex flex-col min-h-0">

                {/* Header */}
                <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 shrink-0">
                  <div>
                    <h2 className="text-base font-bold text-gray-900">New DR Campaign</h2>
                    <p className="text-xs text-gray-400 mt-0.5">Define the campaign scope and schedule window</p>
                  </div>
                  <button type="button" onClick={handleClose}
                    className="p-2 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100 transition-colors">
                    <X size={16} />
                  </button>
                </div>

                {/* Body */}
                <div className="flex-1 overflow-y-auto px-6 py-4 space-y-4">

                  {/* Identity */}
                  <div className="space-y-3">
                    <div>
                      <label className="label">Campaign Name *</label>
                      <input className="input" required value={form.name}
                        onChange={e => set('name', e.target.value)}
                        placeholder="e.g. Q2 2026 Equity Kenya DR Exercise" />
                    </div>
                    <div>
                      <label className="label">
                        Subsidiaries *
                        {form.subsidiaryIds.length > 0 && (
                          <span className="ml-1.5 text-[11px] font-normal text-gray-400">{form.subsidiaryIds.length} selected</span>
                        )}
                      </label>
                      <SubsidiaryPicker value={form.subsidiaryIds}
                        onChange={ids => setForm(f => ({ ...f, subsidiaryIds: ids }))} />
                      {form.subsidiaryIds.length === 0 && (
                        <p className="text-[11px] text-gray-400 mt-1">Select one or more subsidiaries participating in this DR exercise.</p>
                      )}
                    </div>
                  </div>

                  <div className="border-t border-gray-100" />

                  {/* Schedule */}
                  <div className="space-y-3">
                    <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest">Schedule</p>

                    <div>
                      <label className="label">Period *</label>
                      <PeriodPicker
                        periodType={form.periodType} period={form.period}
                        onTypeChange={t => setForm(f => ({ ...f, periodType: t }))}
                        onPeriodChange={p => setForm(f => ({ ...f, period: p }))}
                      />
                    </div>

                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <label className="label">Year *</label>
                        <input type="number" className="input" min={2024} max={2035}
                          value={form.year} onChange={e => set('year', Number(e.target.value))} />
                      </div>
                      <div>
                        <label className="label">Planned DR Date</label>
                        <input type="date" className="input" value={form.plannedDrDate}
                          onChange={e => set('plannedDrDate', e.target.value)} />
                      </div>
                    </div>

                    <div>
                      <label className="label">
                        Preferred Start Time
                        <span className="ml-1 text-gray-400 font-normal text-[11px]">(EAT) — optional</span>
                      </label>
                      <StartTimePicker
                        value={form.preferredStartTime}
                        onChange={v => set('preferredStartTime', v)}
                      />
                    </div>
                  </div>

                  <div className="border-t border-gray-100" />

                  {/* Notes */}
                  <div>
                    <label className="label">
                      Notes
                      <span className="ml-1 text-gray-400 font-normal text-[11px]">(optional)</span>
                    </label>
                    <textarea className="input resize-none" rows={2} value={form.description}
                      onChange={e => set('description', e.target.value)}
                      placeholder="Scope, objectives, known constraints, participating teams…" />
                  </div>
                </div>

                {/* Footer */}
                <div className="flex gap-2 px-6 py-4 border-t border-gray-100 shrink-0">
                  <button type="button" onClick={handleClose} className="btn-secondary flex-1">Cancel</button>
                  <button type="submit"
                    disabled={!form.name.trim() || form.subsidiaryIds.length === 0 || createMutation.isPending}
                    className="btn-primary flex-1 flex items-center justify-center gap-2">
                    {createMutation.isPending
                      ? <span className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                      : <Plus size={14} />}
                    Create Campaign
                  </button>
                </div>
              </form>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
