/**
 * Shared Dependency-type metadata + ResourcePicker + SelectedResourceChip.
 *
 * Extracted so both DependencyFormModal and the ApplicationFormModal
 * Dependencies step can reuse the same components without duplication.
 */
import { useEffect, useRef, useState } from 'react'
import {
  ArrowLeft,
  CheckCircle2,
  Database,
  Globe,
  HardDrive,
  Key,
  Layers,
  Network,
  Plus,
  Search,
  Shield,
  Wifi,
} from 'lucide-react'
import { useCreateSharedResource, useSharedResourceRegistry } from '../../hooks/useDependencies'
import type { CreateSharedResourceRequest, DependencyType, SharedResourceDto } from '../../types'

// ─── Dependency type metadata ──────────────────────────────────────────────────

export interface DepTypeMeta {
  value:       DependencyType
  label:       string
  icon:        React.ElementType
  colour:      string    // Tailwind classes: text + bg + border
  description: string    // shown in the hover detail panel
}

export const DEP_TYPES: DepTypeMeta[] = [
  {
    value: 'DATABASE', label: 'Database', icon: Database,
    colour: 'text-blue-600 bg-blue-50 border-blue-200',
    description: 'Oracle, PostgreSQL, MySQL and other RDBMS. Failover typically involves DataGuard switchover, replica promotion, or connection-string re-pointing.',
  },
  {
    value: 'MIDDLEWARE', label: 'Middleware', icon: Layers,
    colour: 'text-purple-600 bg-purple-50 border-purple-200',
    description: 'Message brokers, ESBs, and integration layers (MQ, Kafka, Tibco). Loss of middleware can cascade to all consuming services simultaneously.',
  },
  {
    value: 'NETWORK', label: 'Network', icon: Network,
    colour: 'text-green-600 bg-green-50 border-green-200',
    description: "Load balancers, switches, firewalls, and SD-WAN links. Declare these when your app's DR procedure depends on a specific network path or device.",
  },
  {
    value: 'API', label: 'External API', icon: Globe,
    colour: 'text-orange-600 bg-orange-50 border-orange-200',
    description: 'Third-party or inter-bank APIs (SWIFT, RTGS, payment gateways). These are outside your control — knowing the dependency flags it for coordinator review.',
  },
  {
    value: 'AUTH', label: 'Auth / Identity', icon: Key,
    colour: 'text-yellow-600 bg-yellow-50 border-yellow-200',
    description: 'LDAP, Active Directory, OAuth servers, and HSMs. If auth is unavailable during DR, users cannot log in regardless of application readiness.',
  },
  {
    value: 'DNS', label: 'DNS', icon: HardDrive,
    colour: 'text-slate-600 bg-slate-50 border-slate-200',
    description: 'Internal or external DNS resolvers. Applications that resolve hostnames at runtime (not startup) can silently fail when DNS is unreachable at the DR site.',
  },
  {
    value: 'VPN', label: 'VPN', icon: Shield,
    colour: 'text-teal-600 bg-teal-50 border-teal-200',
    description: 'Site-to-site or client VPN tunnels required to reach DC resources from the DR site. Must be verified before any application failover in the same window.',
  },
  {
    value: 'OTHER', label: 'Other', icon: Wifi,
    colour: 'text-gray-600 bg-gray-50 border-gray-200',
    description: 'Any infrastructure dependency not covered by the categories above — e.g. NFS mounts, SMTP relays, or hardware security appliances.',
  },
]

export function depMeta(type: DependencyType): DepTypeMeta {
  return DEP_TYPES.find(d => d.value === type) ?? DEP_TYPES[DEP_TYPES.length - 1]
}

// Derive a canonical UPPERCASE_SNAKE code from a plain-text name
export function toCode(name: string): string {
  return name
    .trim()
    .toUpperCase()
    .replace(/[^A-Z0-9]+/g, '_')
    .replace(/^_+|_+$/g, '')
}

// ─── ResourcePicker ────────────────────────────────────────────────────────────
// Two-stage: search existing registry → select, or register a new entry inline.

type PickerView = 'search' | 'create'

export interface ResourcePickerProps {
  depType: DependencyType
  onSelect: (resource: SharedResourceDto) => void
  /** If provided, "Register a new shared resource" calls this instead of opening the inline form.
   *  Use this when the caller wants to redirect the user to the Dependency Engine page. */
  onRegisterNew?: () => void
}

export function ResourcePicker({ depType, onSelect, onRegisterNew }: ResourcePickerProps) {
  const [query, setQuery]           = useState('')
  const [debounced, setDebounced]   = useState('')
  const [view, setView]             = useState<PickerView>('search')
  const [createName, setCreateName] = useState('')
  const [createCode, setCreateCode] = useState('')
  const [codeEdited, setCodeEdited] = useState(false)
  const [createHost, setCreateHost] = useState('')
  const [createEnv, setCreateEnv]   = useState('PRODUCTION')
  const searchRef                   = useRef<HTMLInputElement>(null)

  const { data: results, isLoading } = useSharedResourceRegistry(debounced || undefined)
  const createRes                    = useCreateSharedResource()

  // Debounce
  useEffect(() => {
    const t = setTimeout(() => setDebounced(query), 280)
    return () => clearTimeout(t)
  }, [query])

  // Auto-focus search on mount
  useEffect(() => { searchRef.current?.focus() }, [])

  // Auto-derive code from name (stop if user manually edited it)
  useEffect(() => {
    if (!codeEdited) setCreateCode(toCode(createName))
  }, [createName, codeEdited])

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault()
    const body: CreateSharedResourceRequest = {
      code: createCode,
      name: createName.trim(),
      resourceType: depType,
      host: createHost.trim() || undefined,
      environment: createEnv || 'PRODUCTION',
    }
    const created = await createRes.mutateAsync(body)
    onSelect(created)
  }

  const { icon: DepIcon, colour } = depMeta(depType)
  const trimmed                   = query.trim()
  const suggestedCode             = trimmed ? toCode(trimmed) : ''

  // ── Create-new view ──────────────────────────────────────────────────────────
  if (view === 'create') {
    return (
      <form onSubmit={handleCreate} className="space-y-3 pt-1">
        <div className="flex items-center gap-2 mb-1">
          <button
            type="button"
            onClick={() => setView('search')}
            className="p-1 text-gray-400 hover:text-gray-600 rounded-md hover:bg-gray-100 transition-colors"
          >
            <ArrowLeft size={14} />
          </button>
          <p className="text-xs font-semibold text-gray-600 uppercase tracking-wide">
            Register new shared resource
          </p>
        </div>

        {/* Type pre-filled from parent */}
        <div className={`inline-flex items-center gap-1.5 text-xs font-medium px-2.5 py-1 rounded-full border ${colour}`}>
          <DepIcon size={11} />
          {depMeta(depType).label}
          <span className="text-gray-400 font-normal ml-1">— type inherited</span>
        </div>

        <div>
          <label className="label">Display Name *</label>
          <input
            autoFocus
            type="text"
            className="input"
            placeholder="e.g. Oracle DataGuard Primary"
            value={createName}
            onChange={e => setCreateName(e.target.value)}
            required
          />
        </div>

        <div>
          <label className="label">
            Registry Code *
            <span className="ml-1 text-gray-400 font-normal text-[11px]">UPPERCASE_SNAKE — permanent</span>
          </label>
          <input
            type="text"
            className="input font-mono text-xs tracking-wider"
            placeholder="e.g. ORACLE_DG_PRIMARY"
            value={createCode}
            onChange={e => { setCodeEdited(true); setCreateCode(e.target.value.toUpperCase().replace(/[^A-Z0-9_]/g, '')) }}
            required
            pattern="^[A-Z0-9_]+$"
            title="Uppercase letters, numbers, and underscores only"
          />
          <p className="text-[11px] text-gray-400 mt-1">
            Auto-generated from name. Edit if needed — this code is used for conflict detection and cannot change.
          </p>
        </div>

        <div>
          <label className="label">
            Host / Endpoint <span className="text-gray-400 font-normal text-[11px]">(optional)</span>
          </label>
          <input
            type="text"
            className="input font-mono text-xs"
            placeholder="e.g. db-primary.prod.internal"
            value={createHost}
            onChange={e => setCreateHost(e.target.value)}
          />
        </div>

        <div>
          <label className="label">Environment</label>
          <select className="input" value={createEnv} onChange={e => setCreateEnv(e.target.value)}>
            {['PRODUCTION', 'STAGING', 'DR', 'SHARED'].map(env => (
              <option key={env} value={env}>{env}</option>
            ))}
          </select>
        </div>

        <button
          type="submit"
          disabled={!createCode || !createName.trim() || createRes.isPending}
          className="btn-primary w-full mt-1"
        >
          {createRes.isPending ? 'Registering…' : 'Create & Select Resource'}
        </button>
      </form>
    )
  }

  // ── Search view ──────────────────────────────────────────────────────────────
  return (
    <div className="space-y-2">
      <div className="relative">
        <Search size={13} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
        <input
          ref={searchRef}
          type="text"
          className="input pl-8 text-sm"
          placeholder="Search registry by name or code…"
          value={query}
          onChange={e => setQuery(e.target.value)}
        />
      </div>

      <div className="border border-gray-100 rounded-xl overflow-hidden divide-y divide-gray-50 max-h-48 overflow-y-auto">
        {isLoading && (
          <div className="px-3 py-4 text-center text-xs text-gray-400">Searching…</div>
        )}

        {!isLoading && results?.length === 0 && !trimmed && (
          <div className="px-3 py-4 text-center text-xs text-gray-400">
            No shared resources in the registry yet.
          </div>
        )}

        {!isLoading && results?.map(r => {
          const { icon: RIcon, colour: rc } = depMeta(r.resourceType)
          return (
            <button
              key={r.id}
              type="button"
              onClick={() => onSelect(r)}
              className="w-full flex items-center gap-3 px-3 py-2.5 hover:bg-gray-50 transition-colors text-left"
            >
              <span className={`flex-shrink-0 p-1.5 rounded-lg border ${rc}`}>
                <RIcon size={13} />
              </span>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-mono font-semibold text-gray-800 truncate">{r.code}</p>
                <p className="text-[11px] text-gray-500 truncate">{r.name}</p>
              </div>
              <span className={`flex-shrink-0 text-[10px] font-medium px-2 py-0.5 rounded-full border ${rc}`}>
                {depMeta(r.resourceType).label}
              </span>
            </button>
          )
        })}

        {/* Always-last: register new */}
        {onRegisterNew ? (
          /* External registration (e.g. from ApplicationFormModal) — navigate to Dependency Engine */
          <button
            type="button"
            onClick={onRegisterNew}
            className="w-full flex items-center gap-3 px-3 py-2.5 hover:bg-equity-red/5 text-equity-red transition-colors text-left border-t border-gray-50"
          >
            <span className="flex-shrink-0 p-1.5 rounded-lg border border-equity-red/20 bg-equity-red/5">
              <Plus size={13} />
            </span>
            <div className="flex-1 min-w-0">
              <p className="text-xs font-semibold">Register a new shared resource</p>
              <p className="text-[11px] text-equity-red/60">Opens Dependency Engine in a new tab — your form progress is saved</p>
            </div>
          </button>
        ) : (
          /* Inline registration (e.g. from DependencyFormModal on the Dependency Engine page) */
          <button
            type="button"
            onClick={() => { setCreateName(trimmed); setCodeEdited(false); setView('create') }}
            className="w-full flex items-center gap-3 px-3 py-2.5 hover:bg-equity-red/5 text-equity-red transition-colors text-left border-t border-gray-50"
          >
            <span className="flex-shrink-0 p-1.5 rounded-lg border border-equity-red/20 bg-equity-red/5">
              <Plus size={13} />
            </span>
            <div className="flex-1 min-w-0">
              <p className="text-xs font-semibold">
                {trimmed
                  ? <>Register <span className="font-mono">&ldquo;{suggestedCode}&rdquo;</span> as new shared resource</>
                  : 'Register a new shared resource'}
              </p>
              <p className="text-[11px] text-red-400">Only if it doesn&apos;t appear in the list above</p>
            </div>
          </button>
        )}
      </div>
    </div>
  )
}

// ─── SelectedResourceChip ──────────────────────────────────────────────────────

export function SelectedResourceChip({
  resource,
  onClear,
}: {
  resource: SharedResourceDto
  onClear: () => void
}) {
  const { icon: Icon, colour } = depMeta(resource.resourceType)
  return (
    <div className="flex items-center gap-3 p-3 rounded-xl border border-green-200 bg-green-50">
      <CheckCircle2 size={16} className="text-green-500 flex-shrink-0" />
      <span className={`flex-shrink-0 p-1.5 rounded-lg border ${colour}`}>
        <Icon size={13} />
      </span>
      <div className="flex-1 min-w-0">
        <p className="text-xs font-mono font-semibold text-gray-800 truncate">{resource.code}</p>
        <p className="text-[11px] text-gray-500 truncate">{resource.name}</p>
      </div>
      <button
        type="button"
        onClick={onClear}
        className="flex-shrink-0 text-[11px] text-gray-500 hover:text-gray-700 underline transition-colors"
      >
        Change
      </button>
    </div>
  )
}
