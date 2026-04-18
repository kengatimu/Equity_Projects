import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  X, Loader2, Server, ShieldCheck,
  Plus, Trash2, CheckCircle2, ArrowRight,
  AlertTriangle, RefreshCw, Monitor, Database,
  CornerDownRight, Layers, Zap, RotateCcw,
  Pause, FileText, Clock, Users, GitMerge,
  ChevronUp, User, Mail,
} from 'lucide-react'
import { useApplications, useCreateApplication, useUpdateApplication } from '../../hooks/useApplications'
import axiosClient from '../../api/axiosClient'
import type {
  ApplicationDto, CreateApplicationRequest, AppTier,
  DependencyType,
} from '../../types'
import { ResourcePicker, depMeta } from '../dependencies/ResourcePicker'
import toast from 'react-hot-toast'

// ─── Staged Dependency (held in local state until app is created) ─────────────

interface StagedDependency {
  _id:            string
  dependencyType: DependencyType
  isShared:       boolean
  resourceName?:  string       // SharedResource.code (infrastructure path)
  dependsOnId?:   string       // Application.id (application path)
  description?:   string
  // display helpers — not sent to API
  _displayCode?:  string
  _displayName?:  string
  _displayType?:  DependencyType
  _appName?:      string       // app name for application-path deps
}

type DepKind = 'infrastructure' | 'application'

// ─── Constants ────────────────────────────────────────────────────────────────

const TIERS: { value: AppTier; label: string; sub: string; colour: string }[] = [
  { value: 'T1', label: 'T1 — Critical',  sub: 'Core banking, payment rails', colour: 'border-red-400 bg-red-50 text-red-700' },
  { value: 'T2', label: 'T2 — Important', sub: 'Business systems, channels',  colour: 'border-amber-400 bg-amber-50 text-amber-700' },
  { value: 'T3', label: 'T3 — Standard',  sub: 'Reporting, back-office',      colour: 'border-blue-400 bg-blue-50 text-blue-700' },
]

const SUBSIDIARIES = [
  { id: 'KE',    label: 'Kenya (KE)' },
  { id: 'UG',    label: 'Uganda (UG)' },
  { id: 'TZ',    label: 'Tanzania (TZ)' },
  { id: 'RW',    label: 'Rwanda (RW)' },
  { id: 'DRC',   label: 'DRC (DRC)' },
  { id: 'SS',    label: 'South Sudan (SS)' },
  { id: 'GROUP', label: 'Group / Shared' },
]

// ─── DR Capabilities — with icons and plain-language descriptions ─────────────
// Grouped so users understand which category of DR they are configuring.

type DrCapabilityDef = {
  value: string
  label: string
  icon: React.ElementType
  description: string  // shown in the detail panel when selected / hovered
}

const DR_CAPABILITY_GROUPS: { group: string; colour: string; options: DrCapabilityDef[] }[] = [
  {
    group: 'Live Failover',
    colour: 'text-equity-red',
    options: [
      {
        value: 'FULL_FAILOVER',
        label: 'Full Failover',
        icon: RefreshCw,
        description: 'Complete switch to DR site — application servers, database, and network routes all move. Highest coordination effort; used for Tier 1 systems where every minute counts.',
      },
      {
        value: 'APP_ONLY',
        label: 'App Only',
        icon: Monitor,
        description: 'Application servers move to DR; the database stays at DC and is accessed over the WAN link. Used when a DR database replica is not yet established.',
      },
      {
        value: 'DB_ONLY',
        label: 'DB Only',
        icon: Database,
        description: 'Only the database fails over (e.g. Oracle Data Guard switchover). Application servers stay at DC and are repointed to the DR database host.',
      },
      {
        value: 'APP_REPOINT',
        label: 'App Repoint',
        icon: CornerDownRight,
        description: 'Application is stopped, reconfigured to connect to an already-running DR database, then restarted. No server migration — fastest option when the DR DB is already live.',
      },
      {
        value: 'PARTIAL',
        label: 'Partial',
        icon: Layers,
        description: 'Selected modules, APIs, or business functions move to DR; the rest stay at DC. Used when only a critical subset of functionality must survive an outage.',
      },
      {
        value: 'ACTIVE_ACTIVE',
        label: 'Active-Active',
        icon: Zap,
        description: 'Both DC and DR are live simultaneously, serving traffic. No traditional failover — the DR site simply absorbs full load when DC is taken offline.',
      },
    ],
  },
  {
    group: 'Drills & Tests',
    colour: 'text-equity-red',
    options: [
      {
        value: 'ROLLBACK_DRILL',
        label: 'Rollback Drill',
        icon: RotateCcw,
        description: 'Validates the reverse procedure — returning from DR back to DC cleanly. No customer-visible outage; tests whether the team can undo a failover safely.',
      },
      {
        value: 'COLD_STANDBY',
        label: 'Cold Standby',
        icon: Pause,
        description: 'DR infrastructure exists but is powered off or unprovisioned. Must be started before use. Longer RTO; typically appropriate for Tier 2/3 systems.',
      },
      {
        value: 'TABLETOP',
        label: 'Tabletop Exercise',
        icon: FileText,
        description: 'A meeting-room walkthrough of the DR procedure without touching any systems. Validates the runbook logic, timings, and team readiness. Zero risk.',
      },
      {
        value: 'EXTENDED_OPS',
        label: 'Extended Ops',
        icon: Clock,
        description: 'Continue operating from the current site beyond the normal change window — no failover, no site movement. Tests extended team capacity and monitoring.',
      },
    ],
  },
]

// Flat list for quick lookup
const DR_ALL_CAPS = DR_CAPABILITY_GROUPS.flatMap(g => g.options)


const ALL_TABS = [
  { id: 'basic',        label: 'Basic Info',      icon: Server     },
  { id: 'dr',          label: 'DR & Endpoints',  icon: ShieldCheck },
  { id: 'dependencies', label: 'Dependencies',   icon: GitMerge   },
  { id: 'ownership',   label: 'Ownership & Risk', icon: Users      },
] as const
type TabId = typeof ALL_TABS[number]['id']

// ─── Helpers ──────────────────────────────────────────────────────────────────

function parseEndpoints(jsonStr?: string, primary?: string): string[] {
  if (jsonStr) {
    try {
      const parsed = JSON.parse(jsonStr)
      if (Array.isArray(parsed) && parsed.length > 0) return parsed
    } catch { /* fall through */ }
  }
  return primary ? [primary] : ['']
}

function serializeEndpoints(list: string[]): { primary: string | undefined; json: string | undefined } {
  const clean = list.map(s => s.trim()).filter(Boolean)
  return {
    primary: clean[0] || undefined,
    json:    clean.length > 0 ? JSON.stringify(clean) : undefined,
  }
}

const emptyForm = (): CreateApplicationRequest => ({
  code: '', name: '', tier: 'T2', subsidiaryId: 'KE',
  hasDr: false, directCustomerImpact: false, hasInterdependency: false,
  drCapability: '', businessOwner: '', businessOwnerEmail: '',
  techOwnerName: '', techOwnerEmail: '',
  vendor: '', description: '', notes: '',
  scheduleHalf: '', drQuarter: '', preferredDrMonth: '', preferredDrTime: '',
})

interface Props {
  isOpen: boolean
  onClose: () => void
  app?: ApplicationDto
}

// ─── Component ────────────────────────────────────────────────────────────────

export default function ApplicationFormModal({ isOpen, onClose, app }: Props) {
  const isEdit = !!app
  const navigate = useNavigate()

  const [activeTab, setActiveTab]       = useState<TabId>('basic')
  const [form, setForm]                 = useState<CreateApplicationRequest>(emptyForm)
  const [dcEndpoints, setDcEndpoints]   = useState<string[]>([''])
  const [drEndpoints, setDrEndpoints]   = useState<string[]>([''])
  const [hoveredCap, setHoveredCap]     = useState<string | null>(null)
  const [createdId, setCreatedId]       = useState<string | null>(null)

  // ── Dependencies tab ─────────────────────────────────────────────────────────
  const [stagedDeps, setStagedDeps]         = useState<StagedDependency[]>([])
  const [depFormOpen, setDepFormOpen]       = useState(false)
  const [depKind, setDepKind]               = useState<DepKind | null>(null)
  const [depFormType]                       = useState<DependencyType>('DATABASE')
  const [depFormAppId, setDepFormAppId]     = useState('')

  const { data: apps } = useApplications({ size: 200 })

  // All 4 tabs shown in both create and edit mode.
  // Dependencies tab shows different content per mode (staging vs. manage-on-detail-page).
  const tabs = ALL_TABS
  const lastTabId = tabs[tabs.length - 1].id

  const createMutation = useCreateApplication()
  const updateMutation = useUpdateApplication(app?.id ?? '')
  const isPending = createMutation.isPending || updateMutation.isPending
  const [submitAttempted, setSubmitAttempted] = useState(false)

  useEffect(() => {
    if (!isOpen) {
      setCreatedId(null); setActiveTab('basic'); setHoveredCap(null)
      setStagedDeps([]); setDepFormOpen(false); setDepKind(null)
      setDepFormAppId('')
      setSubmitAttempted(false)
      return
    }
    if (app) {
      setForm({
        code: app.code, name: app.name, tier: app.tier,
        subsidiaryId: app.subsidiaryId, hasDr: app.hasDr,
        directCustomerImpact: app.directCustomerImpact,
        hasInterdependency: app.hasInterdependency ?? false,
        drCapability: app.drCapability ?? '',
        businessOwner: app.businessOwner ?? '',
        businessOwnerEmail: app.businessOwnerEmail ?? '',
        techOwnerName: app.techOwnerName ?? '',
        techOwnerEmail: app.techOwnerEmail ?? '',
        vendor: app.vendor ?? '',
        description: app.description ?? '',
        notes: app.notes ?? '',
        scheduleHalf: app.scheduleHalf ?? '',
        drQuarter: app.drQuarter ?? '',
        preferredDrMonth: app.preferredDrMonth ?? '',
        preferredDrTime: app.preferredDrTime ?? '',
      })
      setDcEndpoints(parseEndpoints(app.dcServers, app.dcEndpoint))
      setDrEndpoints(parseEndpoints(app.drServers, app.drEndpoint))
    } else {
      setForm(emptyForm())
      setDcEndpoints([''])
      setDrEndpoints([''])
    }
  }, [app, isOpen])

  const set = <K extends keyof CreateApplicationRequest>(k: K, v: CreateApplicationRequest[K]) =>
    setForm(f => ({ ...f, [k]: v }))

  // ── Validation (Tier 2: conditional + always-required) ───────────────────
  const formErrors: { tab: TabId; msg: string }[] = [
    form.hasDr && !form.drCapability
      ? { tab: 'dr',        msg: 'Select a DR Capability type (DR & Endpoints tab)' }
      : null,
    !(form.techOwnerName ?? '').trim()
      ? { tab: 'ownership', msg: 'Technical Owner Name is required (Ownership & Risk tab)' }
      : null,
    !(form.techOwnerEmail ?? '').trim()
      ? { tab: 'ownership', msg: 'Technical Owner Email is required (Ownership & Risk tab)' }
      : null,
  ].filter(Boolean) as { tab: TabId; msg: string }[]

  const tabHasError = (tabId: TabId) => submitAttempted && formErrors.some(e => e.tab === tabId)

  // ── Profile completeness (shown in footer as progress bar) ───────────────
  const completenessChecks = [
    !!(form.code           ?? '').trim(),
    !!(form.name           ?? '').trim(),
    !!(form.techOwnerName  ?? '').trim(),
    !!(form.techOwnerEmail ?? '').trim(),
    !form.hasDr || !!form.drCapability,
    !form.hasDr || drEndpoints.some(e => e.trim()),
    !!(form.businessOwner      ?? '').trim(),
    !!(form.businessOwnerEmail ?? '').trim(),
    dcEndpoints.some(e => e.trim()),
  ]
  const completeness = Math.round(completenessChecks.filter(Boolean).length / completenessChecks.length * 100)
  const completionColour = completeness === 100 ? 'bg-green-500' : completeness >= 75 ? 'bg-amber-400' : 'bg-equity-red'

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setSubmitAttempted(true)
    if (formErrors.length > 0) {
      setActiveTab(formErrors[0].tab)   // jump to the first tab with an error
      return
    }
    const dcSer = serializeEndpoints(dcEndpoints)
    const drSer = serializeEndpoints(drEndpoints)
    // Auto-derive hasInterdependency from staged deps (any app-to-app dep sets it)
    const hasInterdependency = isEdit
      ? form.hasInterdependency
      : stagedDeps.some(d => !!d.dependsOnId)
    const payload: CreateApplicationRequest = {
      ...form,
      hasInterdependency,
      dcEndpoint:       dcSer.primary,
      dcServers:        dcSer.json,
      drEndpoint:       form.hasDr ? drSer.primary  : undefined,
      drServers:        form.hasDr ? drSer.json      : undefined,
      drCapability:     form.drCapability  || undefined,
      businessOwner:    form.businessOwner || undefined,
      vendor:           form.vendor        || undefined,
      description:      form.description   || undefined,
      notes:            form.notes         || undefined,
      businessOwnerEmail: form.businessOwnerEmail || undefined,
      techOwnerName:      form.techOwnerName      || undefined,
      techOwnerEmail:     form.techOwnerEmail      || undefined,
      scheduleHalf:     form.scheduleHalf  || undefined,
      drQuarter:        form.drQuarter     || undefined,
      preferredDrMonth: form.preferredDrMonth || undefined,
      preferredDrTime:  form.preferredDrTime  || undefined,
    }
    if (isEdit) {
      await updateMutation.mutateAsync(payload)
      onClose()
    } else {
      const created = await createMutation.mutateAsync(payload)
      // Batch-register any dependencies staged during the form
      if (stagedDeps.length > 0) {
        await Promise.allSettled(
          stagedDeps.map(dep =>
            axiosClient.post(`/applications/${created.id}/dependencies`, {
              dependencyType: dep.dependencyType,
              isShared:       dep.isShared,
              resourceName:   dep.resourceName,
              dependsOnId:    dep.dependsOnId,
              description:    dep.description,
            }),
          ),
        )
      }
      setCreatedId(created.id)
    }
  }

  if (!isOpen) return null

  // ── Post-create success state ────────────────────────────────────────────────
  if (createdId) {
    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm px-4">
        <div className="bg-white rounded-2xl shadow-xl w-full max-w-md p-8 text-center space-y-5">
          <div className="w-16 h-16 bg-green-50 rounded-full flex items-center justify-center mx-auto">
            <CheckCircle2 size={36} className="text-green-500" />
          </div>
          <div>
            <h2 className="text-xl font-bold text-gray-900">Application created!</h2>
            <p className="text-sm text-gray-500 mt-1">
              <span className="font-mono font-semibold text-equity-red">{form.code}</span> has been added to the registry.
            </p>
          </div>
          <div className="space-y-2 pt-2">
            <button
              onClick={() => { navigate(`/applications/${createdId}`); onClose() }}
              className="btn-primary w-full flex items-center justify-center gap-2"
            >
              <ArrowRight size={15} /> View Application & Add Dependencies
            </button>
            <button
              onClick={() => {
                setCreatedId(null)
                setForm(emptyForm())
                setDcEndpoints([''])
                setDrEndpoints([''])
                setActiveTab('basic')
                setStagedDeps([])
                setDepFormOpen(false)
                
                
              }}
              className="btn-secondary w-full"
            >
              Add Another Application
            </button>
            <button onClick={onClose} className="text-sm text-gray-400 hover:text-gray-600 w-full py-1">
              Done
            </button>
          </div>
        </div>
      </div>
    )
  }

  // Which cap def is "active" for the description panel (hover > selected)
  const activeCap = DR_ALL_CAPS.find(c => c.value === (hoveredCap ?? form.drCapability))

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm px-4"
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-3xl max-h-[92vh] flex flex-col">

        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100 shrink-0">
          <div>
            <h2 className="text-lg font-bold text-gray-900">
              {isEdit ? 'Edit Application' : 'Add Application'}
            </h2>
            {isEdit && <p className="text-xs text-gray-400 font-mono mt-0.5">{app.code}</p>}
          </div>
          <button onClick={onClose} className="p-2 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100 transition-colors">
            <X size={18} />
          </button>
        </div>

        {/* Tab bar */}
        <div className="flex border-b border-gray-100 px-6 shrink-0">
          {tabs.map(tab => {
            const Icon = tab.icon
            return (
              <button
                key={tab.id}
                type="button"
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center gap-1.5 px-3 py-3 text-xs font-medium border-b-2 transition-colors -mb-px relative ${
                  activeTab === tab.id
                    ? 'border-equity-red text-equity-red'
                    : 'border-transparent text-gray-500 hover:text-gray-700'
                }`}
              >
                <Icon size={13} />
                {tab.label}
                {/* Badge showing staged dep count on Dependencies tab */}
                {tab.id === 'dependencies' && stagedDeps.length > 0 && (
                  <span className="ml-1 w-4 h-4 rounded-full bg-equity-red text-white text-[9px] font-bold flex items-center justify-center">
                    {stagedDeps.length}
                  </span>
                )}
                {/* Warning dot when tab has validation errors and user attempted submit */}
                {tabHasError(tab.id) && (
                  <span className="absolute top-2 right-0 w-1.5 h-1.5 rounded-full bg-amber-500" />
                )}
              </button>
            )
          })}
        </div>

        {/* Scrollable body */}
        <form onSubmit={handleSubmit} id="app-form" className="flex-1 overflow-y-auto px-6 py-5">

          {/* ── Tab 1: Basic Info ───────────────────────────────────────── */}
          {activeTab === 'basic' && (
            <div className="space-y-5">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="label">Application Code <span className="text-equity-red">*</span></label>
                  <input
                    className="input font-mono uppercase"
                    placeholder="e.g. FINACLE_CORE_TZ"
                    value={form.code}
                    onChange={e => set('code', e.target.value.toUpperCase().replace(/\s+/g,'_'))}
                    disabled={isEdit}
                    required
                  />
                  {isEdit
                    ? <p className="text-xs text-gray-400 mt-1">Code cannot be changed after creation.</p>
                    : <p className="text-xs text-gray-400 mt-1">UPPERCASE_SNAKE — unique across the platform.</p>
                  }
                </div>
                <div>
                  <label className="label">Application Name <span className="text-equity-red">*</span></label>
                  <input
                    className="input"
                    placeholder="e.g. Finacle Core Tanzania"
                    value={form.name}
                    onChange={e => set('name', e.target.value)}
                    required
                  />
                </div>
              </div>

              {/* Tier — visual card selector */}
              <div>
                <label className="label">Tier <span className="text-equity-red">*</span></label>
                <div className="grid grid-cols-3 gap-3">
                  {TIERS.map(t => (
                    <button
                      key={t.value}
                      type="button"
                      onClick={() => set('tier', t.value)}
                      className={`p-3 rounded-xl border-2 text-left transition-all ${
                        form.tier === t.value ? t.colour + ' shadow-sm' : 'border-gray-200 hover:border-gray-300 text-gray-600'
                      }`}
                    >
                      <p className="text-sm font-bold">{t.label.split(' — ')[0]}</p>
                      <p className="text-xs font-semibold mt-0.5">{t.label.split(' — ')[1]}</p>
                      <p className="text-[11px] mt-1 opacity-70">{t.sub}</p>
                    </button>
                  ))}
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="label">Subsidiary <span className="text-equity-red">*</span></label>
                  <select className="input" value={form.subsidiaryId} onChange={e => set('subsidiaryId', e.target.value)} required>
                    {SUBSIDIARIES.map(s => <option key={s.id} value={s.id}>{s.label}</option>)}
                  </select>
                </div>
                <div>
                  <label className="label">Vendor / Technology</label>
                  <input
                    className="input"
                    placeholder="e.g. Infosys, Oracle, In-house"
                    value={form.vendor ?? ''}
                    onChange={e => set('vendor', e.target.value || undefined)}
                  />
                </div>
              </div>

              <div>
                <label className="label">App Description</label>
                <textarea
                  className="input resize-none"
                  rows={3}
                  placeholder="Brief description of what this application does and its DR requirements…"
                  value={form.description ?? ''}
                  onChange={e => set('description', e.target.value || undefined)}
                />
              </div>
            </div>
          )}

          {/* ── Tab 3: DR & Endpoints ────────────────────────────────────── */}
          {activeTab === 'dr' && (
            <div className="space-y-5">

              {/* DR Capable — full-width now that customer-facing lives in Ownership */}
              <button
                type="button"
                onClick={() => {
                  set('hasDr', !form.hasDr)
                  if (form.hasDr) set('drCapability', '')
                }}
                className={`w-full p-4 rounded-xl border-2 text-left transition-all ${
                  form.hasDr
                    ? 'border-equity-red bg-equity-red/5'
                    : 'border-gray-200 bg-white hover:border-gray-300'
                }`}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2.5">
                    <div className={`w-9 h-9 rounded-xl flex items-center justify-center ${form.hasDr ? 'bg-equity-red text-white' : 'bg-gray-100 text-gray-400'}`}>
                      <ShieldCheck size={17} />
                    </div>
                    <div>
                      <p className={`text-sm font-semibold ${form.hasDr ? 'text-equity-red' : 'text-gray-700'}`}>
                        DR Capable
                      </p>
                      <p className={`text-xs mt-0.5 leading-relaxed ${form.hasDr ? 'text-equity-red/70' : 'text-gray-400'}`}>
                        {form.hasDr
                          ? 'This application has a documented DR failover procedure and will be included in DR campaigns.'
                          : 'Enable to configure DR capability type, endpoints, and include this app in DR campaigns.'}
                      </p>
                    </div>
                  </div>
                  <TogglePill on={form.hasDr} />
                </div>
              </button>

              {/* DR Capability — only expands when DR Capable is ON.
                  No locked placeholder: an inactive toggle already communicates "off".
                  Showing nothing is cleaner than a large empty box. */}
              {form.hasDr && (
                <div className="space-y-5">

                  {/* DR Capability — card grid + description panel */}
                  <div>
                    <label className="label">DR Capability Type <span className="text-equity-red">*</span></label>
                    <p className="text-xs text-gray-400 mb-3">
                      Select how this application is failed over. Hover a card for details.
                    </p>

                    {DR_CAPABILITY_GROUPS.map(group => (
                      <div key={group.group} className="mb-3">
                        <p className={`text-[11px] font-bold uppercase tracking-widest mb-2 ${group.colour}`}>
                          {group.group}
                        </p>
                        <div className="grid grid-cols-3 gap-2">
                          {group.options.map(cap => {
                            const Icon     = cap.icon
                            const isSelected = form.drCapability === cap.value
                            const isHovered  = hoveredCap === cap.value
                            return (
                              <button
                                key={cap.value}
                                type="button"
                                onClick={() => set('drCapability', cap.value)}
                                onMouseEnter={() => setHoveredCap(cap.value)}
                                onMouseLeave={() => setHoveredCap(null)}
                                className={`p-2.5 rounded-lg border-2 text-left transition-all ${
                                  isSelected
                                    ? 'border-equity-red bg-equity-red/5 shadow-sm'
                                    : isHovered
                                    ? 'border-gray-300 bg-gray-50'
                                    : 'border-gray-200 hover:border-gray-300'
                                }`}
                              >
                                <div className="flex items-center gap-1.5">
                                  <Icon size={13} className={isSelected ? 'text-equity-red' : 'text-gray-400'} />
                                  <span className={`text-xs font-semibold leading-tight ${isSelected ? 'text-equity-red' : 'text-gray-700'}`}>
                                    {cap.label}
                                  </span>
                                </div>
                              </button>
                            )
                          })}
                        </div>
                      </div>
                    ))}

                    {/* Description panel — only renders when a card is hovered or selected.
                        Empty state is a lightweight hint with no border or background. */}
                    {activeCap && (
                      <div className="rounded-xl p-3.5 bg-equity-red/5 border border-equity-red/20 transition-all">
                        <p className="text-xs font-bold text-equity-red mb-1">{activeCap.label}</p>
                        <p className="text-xs text-equity-red/75 leading-relaxed">{activeCap.description}</p>
                      </div>
                    )}
                    {submitAttempted && !form.drCapability && (
                      <p className="text-[11px] text-red-500 mt-1">Select a DR Capability type to continue</p>
                    )}
                  </div>

                </div>
              )}

              {/* DC Endpoints — always visible regardless of DR status.
                  Every application has a DC-side URL; it doesn't depend on DR capability. */}
              <div>
                <label className="label">DC Application Endpoints</label>
                <p className="text-xs text-gray-400 mb-2">
                  Primary application URL(s) at the Data Centre. Add multiple for HA deployments.
                </p>
                <EndpointList
                  endpoints={dcEndpoints}
                  onChange={setDcEndpoints}
                  placeholder="https://app.dc.equitybank.co.ke"
                />
              </div>

              {/* DR Endpoints — only when DR Capable is ON */}
              {form.hasDr && (
                <div>
                  <label className="label">DR Application Endpoints</label>
                  <p className="text-xs text-gray-400 mb-2">
                    DR-side application URLs. Validated during the Post-DR review after each campaign.
                  </p>
                  <EndpointList
                    endpoints={drEndpoints}
                    onChange={setDrEndpoints}
                    placeholder="https://app.dr.equitybank.co.ke"
                  />
                </div>
              )}
            </div>
          )}

          {/* ── Tab 4: Ownership & Risk ──────────────────────────────────── */}
          {activeTab === 'ownership' && (
            <div className="space-y-4">

              {/* Business Owner */}
              <div className="rounded-xl border border-gray-200 p-4 space-y-3">
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-full bg-blue-50 border border-blue-100 flex items-center justify-center shrink-0">
                    <User size={14} className="text-blue-500" />
                  </div>
                  <div>
                    <p className="text-sm font-semibold text-gray-800">Business Owner</p>
                    <p className="text-[11px] text-gray-400">Accountable for DR sign-off and regulatory reporting</p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="label">Full Name</label>
                    <input
                      className="input"
                      placeholder="e.g. Jane Doe"
                      value={form.businessOwner ?? ''}
                      onChange={e => set('businessOwner', e.target.value || undefined)}
                    />
                  </div>
                  <div>
                    <label className="label">Work Email</label>
                    <div className="relative">
                      <Mail size={13} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
                      <input type="email" className="input pl-8"
                        placeholder="e.g. jane.doe@equitybank.co.ke"
                        value={form.businessOwnerEmail ?? ''}
                        onChange={e => set('businessOwnerEmail', e.target.value || undefined)}
                      />
                    </div>
                  </div>
                </div>
              </div>

              {/* Technical Owner */}
              <div className="rounded-xl border border-gray-200 p-4 space-y-3">
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-full bg-purple-50 border border-purple-100 flex items-center justify-center shrink-0">
                    <User size={14} className="text-purple-500" />
                  </div>
                  <div>
                    <p className="text-sm font-semibold text-gray-800">
                    Technical Owner <span className="text-equity-red">*</span>
                    <span className="ml-2 text-[10px] font-normal text-equity-red/70 bg-equity-red/8 px-1.5 py-0.5 rounded">required</span>
                  </p>
                    <p className="text-[11px] text-gray-400">Responsible for the runbook, execution, and post-DR validation</p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="label">Full Name <span className="text-equity-red">*</span></label>
                    <input
                      className={`input ${submitAttempted && !(form.techOwnerName ?? '').trim() ? 'border-red-300 ring-1 ring-red-200' : ''}`}
                      placeholder="e.g. John Doe"
                      value={form.techOwnerName ?? ''}
                      onChange={e => set('techOwnerName', e.target.value || undefined)}
                    />
                    {submitAttempted && !(form.techOwnerName ?? '').trim() && (
                      <p className="text-[11px] text-red-500 mt-1">Required — who will execute the DR runbook?</p>
                    )}
                  </div>
                  <div>
                    <label className="label">Work Email <span className="text-equity-red">*</span></label>
                    <div className="relative">
                      <Mail size={13} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
                      <input type="email" className={`input pl-8 ${submitAttempted && !(form.techOwnerEmail ?? '').trim() ? 'border-red-300 ring-1 ring-red-200' : ''}`}
                        placeholder="e.g. john.doe@equitybank.co.ke"
                        value={form.techOwnerEmail ?? ''}
                        onChange={e => set('techOwnerEmail', e.target.value || undefined)}
                      />
                    </div>
                    {submitAttempted && !(form.techOwnerEmail ?? '').trim() && (
                      <p className="text-[11px] text-red-500 mt-1">Required — used to link the runbook owner in campaigns</p>
                    )}
                  </div>
                </div>
              </div>

              {/* Customer-Facing risk */}
              <button
                type="button"
                onClick={() => set('directCustomerImpact', !form.directCustomerImpact)}
                className={`w-full p-4 rounded-xl border-2 text-left transition-all ${
                  form.directCustomerImpact
                    ? 'border-amber-400 bg-amber-50'
                    : 'border-gray-200 bg-white hover:border-gray-300'
                }`}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2.5">
                    <div className={`w-8 h-8 rounded-xl flex items-center justify-center shrink-0 ${form.directCustomerImpact ? 'bg-amber-500 text-white' : 'bg-gray-100 text-gray-400'}`}>
                      <Users size={14} />
                    </div>
                    <div>
                      <p className={`text-sm font-semibold ${form.directCustomerImpact ? 'text-amber-700' : 'text-gray-700'}`}>
                        Customer-Facing Application
                      </p>
                      <p className={`text-[11px] mt-0.5 ${form.directCustomerImpact ? 'text-amber-600' : 'text-gray-400'}`}>
                        A failure in this system is directly visible to Equity customers
                      </p>
                    </div>
                  </div>
                  <TogglePill on={form.directCustomerImpact} colour="amber" />
                </div>
              </button>

              {form.directCustomerImpact && (
                <div className="flex gap-3 p-3.5 rounded-xl border border-amber-200 bg-amber-50">
                  <AlertTriangle size={14} className="text-amber-600 mt-0.5 shrink-0" />
                  <div className="space-y-1">
                    <p className="text-xs font-semibold text-amber-700">Elevated handling applies</p>
                    {[
                      'Shown on the executive dashboard during any DR campaign',
                      'Requires sign-off from both App Owner and Coordinator to close',
                      'Blocked checklist items escalate automatically',
                      'Post-DR review flags RTO breaches for regulatory disclosure',
                    ].map((item, i) => (
                      <p key={i} className="text-[11px] text-amber-700 leading-relaxed">· {item}</p>
                    ))}
                  </div>
                </div>
              )}

              {/* Internal Notes */}
              <div>
                <label className="label">
                  Internal Notes
                  <span className="ml-1 text-gray-400 font-normal text-[11px]">(optional)</span>
                </label>
                <textarea
                  className="input resize-none"
                  rows={2}
                  placeholder="Special procedures, known risks, escalation contacts, vendor contacts…"
                  value={form.notes ?? ''}
                  onChange={e => set('notes', e.target.value || undefined)}
                />
              </div>

            </div>
          )}

          {/* ── Tab 3: Dependencies ───────────────────────────────────────── */}
          {activeTab === 'dependencies' && (
            <div className="space-y-4">

              {/* Info banner */}
              <div className="flex gap-3 p-3.5 bg-equity-red/5 border border-equity-red/20 rounded-xl">
                <GitMerge size={15} className="text-equity-red mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs font-semibold text-equity-red">Why declare dependencies?</p>
                  <p className="text-[11px] text-equity-red/75 mt-0.5 leading-relaxed">
                    The conflict scanner uses these to flag scheduling clashes — e.g. two apps sharing
                    the same Oracle DataGuard cluster in different DR windows. Declare as many as you know.
                  </p>
                </div>
              </div>

              {isEdit ? (
                /* Edit mode: direct to detail page */
                <div className="rounded-xl border border-dashed border-gray-200 p-6 text-center space-y-2">
                  <GitMerge size={20} className="text-gray-300 mx-auto" />
                  <p className="text-xs font-medium text-gray-600">
                    Manage dependencies from the Application Detail page
                  </p>
                  <p className="text-[11px] text-gray-400 leading-relaxed">
                    Search the shared resource registry, add new dependencies, and review all existing ones.
                  </p>
                </div>
              ) : (
                /* Create mode: clean staging area */
                <>
                  {/* Staged list */}
                  {stagedDeps.length > 0 && (
                    <div className="space-y-2">
                      <p className="text-[11px] font-bold text-gray-400 uppercase tracking-widest">
                        {stagedDeps.length} {stagedDeps.length === 1 ? 'Dependency' : 'Dependencies'} Added
                      </p>
                      {stagedDeps.map(dep => {
                        const isAppDep = !!dep.dependsOnId
                        const meta     = depMeta(dep._displayType ?? dep.dependencyType)
                        const Icon     = meta.icon
                        return (
                          <div key={dep._id} className="flex items-center gap-3 p-3 rounded-xl border border-gray-100 bg-gray-50">
                            <span className={`flex-shrink-0 p-2 rounded-lg border ${isAppDep ? 'text-purple-600 bg-purple-50 border-purple-200' : meta.colour}`}>
                              {isAppDep ? <GitMerge size={13} /> : <Icon size={13} />}
                            </span>
                            <div className="flex-1 min-w-0">
                              <p className="text-xs font-semibold text-gray-800 truncate">
                                {isAppDep ? dep._displayCode : (dep._displayCode ?? dep.resourceName)}
                              </p>
                              <p className="text-[11px] text-gray-500 truncate">
                                {isAppDep
                                  ? `Application dependency · ${dep._appName ?? ''}`
                                  : `${dep._displayName} · ${meta.label}`}
                              </p>
                              {dep.description && (
                                <p className="text-[11px] text-gray-400 truncate mt-0.5">{dep.description}</p>
                              )}
                            </div>
                            <button
                              type="button"
                              onClick={() => setStagedDeps(prev => prev.filter(d => d._id !== dep._id))}
                              className="flex-shrink-0 p-1.5 text-gray-300 hover:text-red-500 rounded-lg hover:bg-red-50 transition-colors"
                            >
                              <X size={13} />
                            </button>
                          </div>
                        )
                      })}
                    </div>
                  )}

                  {/* Add button or inline mini-wizard */}
                  {!depFormOpen ? (
                    <button
                      type="button"
                      onClick={() => { setDepFormOpen(true); setDepKind(null) }}
                      className="w-full flex items-center justify-center gap-2 p-3 border-2 border-dashed border-gray-200 rounded-xl text-sm text-gray-400 hover:border-equity-red hover:text-equity-red hover:bg-equity-red/5 transition-all"
                    >
                      <Plus size={14} />
                      {stagedDeps.length === 0 ? 'Add a Dependency' : 'Add Another'}
                    </button>
                  ) : (
                    <div className="border border-gray-200 rounded-2xl overflow-hidden shadow-sm">

                      {/* Mini-wizard header */}
                      <div className="flex items-center justify-between px-4 py-3 bg-gray-50 border-b border-gray-100">
                        <p className="text-xs font-semibold text-gray-700 flex items-center gap-1.5">
                          <Plus size={12} className="text-equity-red" />
                          Add Dependency
                        </p>
                        <button
                          type="button"
                          title="Collapse"
                          onClick={() => { setDepFormOpen(false); setDepKind(null); setDepFormAppId('') }}
                          className="flex items-center gap-1.5 px-2.5 py-1 text-xs font-medium text-equity-red bg-equity-red/10 hover:bg-equity-red/20 rounded-lg border border-equity-red/20 transition-colors"
                        >
                          <ChevronUp size={12} />
                          Collapse
                        </button>
                      </div>

                      <div className="px-4 py-4 space-y-4">

                        {/* ── Step 1: choose kind ────────────────────────────── */}
                        {!depKind ? (
                          <div>
                            <p className="text-xs font-semibold text-gray-700 mb-3">
                              What does this application depend on?
                            </p>
                            <div className="grid grid-cols-2 gap-3">
                              <button
                                type="button"
                                onClick={() => setDepKind('infrastructure')}
                                className="flex flex-col items-start gap-2 p-4 rounded-xl border-2 border-gray-100 hover:border-equity-red hover:bg-equity-red/5 text-left transition-all group"
                              >
                                <div className="w-8 h-8 rounded-lg bg-gray-100 group-hover:bg-equity-red/10 flex items-center justify-center transition-colors">
                                  <Database size={15} className="text-gray-500 group-hover:text-equity-red transition-colors" />
                                </div>
                                <div>
                                  <p className="text-xs font-semibold text-gray-800">Infrastructure Resource</p>
                                  <p className="text-[11px] text-gray-400 mt-0.5 leading-snug">Database, network, API, auth service…</p>
                                </div>
                              </button>
                              <button
                                type="button"
                                onClick={() => setDepKind('application')}
                                className="flex flex-col items-start gap-2 p-4 rounded-xl border-2 border-gray-100 hover:border-purple-400 hover:bg-purple-50 text-left transition-all group"
                              >
                                <div className="w-8 h-8 rounded-lg bg-gray-100 group-hover:bg-purple-100 flex items-center justify-center transition-colors">
                                  <GitMerge size={15} className="text-gray-500 group-hover:text-purple-600 transition-colors" />
                                </div>
                                <div>
                                  <p className="text-xs font-semibold text-gray-800">Another Application</p>
                                  <p className="text-[11px] text-gray-400 mt-0.5 leading-snug">This app calls another system in this registry</p>
                                </div>
                              </button>
                            </div>
                          </div>
                        ) : (
                          <>
                            {/* Kind badge + change link */}
                            <div className="flex items-center gap-2">
                              <span className={`inline-flex items-center gap-1.5 text-[11px] font-medium px-2.5 py-1 rounded-full border ${
                                depKind === 'infrastructure'
                                  ? 'text-equity-red bg-equity-red/5 border-equity-red/20'
                                  : 'text-purple-600 bg-purple-50 border-purple-200'
                              }`}>
                                {depKind === 'infrastructure' ? <Database size={10} /> : <GitMerge size={10} />}
                                {depKind === 'infrastructure' ? 'Infrastructure Resource' : 'Application Dependency'}
                              </span>
                              <button
                                type="button"
                                onClick={() => { setDepKind(null); setDepFormAppId('') }}
                                className="flex items-center gap-1 text-[11px] font-medium text-equity-red hover:underline"
                              >
                                ← Change
                              </button>
                            </div>

                            {/* ── Infrastructure path ────────────────────────── */}
                            {depKind === 'infrastructure' && (
                              <div>
                                <label className="label">
                                  Resource *
                                  <span className="ml-1 text-gray-400 font-normal text-[11px]">search the shared registry</span>
                                </label>
                                <ResourcePicker
                                    depType={depFormType}
                                    onSelect={r => {
                                      // Deduplicate — ignore if already staged
                                      const alreadyStaged = stagedDeps.some(d => d.resourceName === r.code || d._displayCode === r.code)
                                      if (alreadyStaged) { toast.error(`${r.code} is already added`); return }
                                      // Auto-stage immediately — no extra button click needed
                                      setStagedDeps(prev => [...prev, {
                                        _id:            crypto.randomUUID(),
                                        dependencyType: r.resourceType,
                                        isShared:       true,
                                        resourceName:   r.code,
                                        _displayCode:   r.code,
                                        _displayName:   r.name,
                                        _displayType:   r.resourceType,
                                      }])
                                      setDepFormOpen(false); setDepKind(null); ; 
                                    }}
                                    onRegisterNew={() => window.open('/dependencies', '_blank', 'noopener,noreferrer')}
                                  />
                              </div>
                            )}

                            {/* ── Application path ───────────────────────────── */}
                            {depKind === 'application' && (
                              apps && apps.content.length === 0 ? (
                                /* ── Empty state: no apps registered ─────────── */
                                <div className="rounded-xl border border-dashed border-gray-200 p-5 text-center space-y-2.5">
                                  <div className="w-9 h-9 rounded-full bg-gray-100 flex items-center justify-center mx-auto">
                                    <GitMerge size={16} className="text-gray-400" />
                                  </div>
                                  <div>
                                    <p className="text-xs font-semibold text-gray-700">No other applications in the registry</p>
                                    <p className="text-[11px] text-gray-400 mt-0.5 leading-relaxed">
                                      The other application must be registered first before you can declare a dependency on it.
                                    </p>
                                  </div>
                                  <div className="space-y-1.5 pt-1">
                                    <a
                                      href="/applications"
                                      target="_blank"
                                      rel="noopener noreferrer"
                                      className="inline-flex items-center gap-1.5 text-xs font-semibold text-equity-red bg-equity-red/8 hover:bg-equity-red/15 px-3 py-1.5 rounded-lg border border-equity-red/20 transition-colors"
                                    >
                                      Register Application →
                                    </a>
                                    <p className="text-[10px] text-gray-400">Opens in a new tab — your form progress is saved here.</p>
                                  </div>
                                </div>
                              ) : (
                                /* ── App selector ──────────────────────────── */
                                <div className="space-y-3">
                                  <div>
                                    <label className="label">Select the application *</label>
                                    <select
                                      className="input"
                                      value={depFormAppId}
                                      onChange={e => {
                                        const id = e.target.value
                                        if (!id) return
                                        // Deduplicate
                                        if (stagedDeps.some(d => d.dependsOnId === id)) {
                                          toast.error('That application is already added'); return
                                        }
                                        const selectedApp = apps?.content.find(a => a.id === id)
                                        // Auto-stage immediately — no extra button click needed
                                        setStagedDeps(prev => [...prev, {
                                          _id:            crypto.randomUUID(),
                                          dependencyType: 'OTHER',
                                          isShared:       false,
                                          dependsOnId:    id,
                                          _displayCode:   selectedApp?.code ?? id,
                                          _appName:       selectedApp?.name,
                                        }])
                                        setDepFormOpen(false); setDepKind(null); setDepFormAppId(''); 
                                      }}
                                    >
                                      <option value="">— choose an application —</option>
                                      {apps?.content.map(a => (
                                        <option key={a.id} value={a.id}>{a.code} — {a.name}</option>
                                      ))}
                                    </select>
                                  </div>

                                  {/* Inline hint */}
                                  <div className="flex gap-2.5 p-3 bg-gray-50 rounded-xl border border-gray-100">
                                    <GitMerge size={13} className="text-gray-400 mt-0.5 shrink-0" />
                                    <div className="space-y-0.5">
                                      <p className="text-[11px] text-gray-600 leading-relaxed">
                                        This app's DR window will run <span className="font-semibold">only after</span> the selected application has fully failed over.
                                      </p>
                                      <p className="text-[10px] text-gray-400">
                                        e.g. Loan Processing → Core Banking · Mobile App → API Gateway · Branch System → Customer Registry
                                      </p>
                                    </div>
                                  </div>
                                </div>
                              )
                            )}

                          </>
                        )}
                      </div>
                    </div>
                  )}

                  <p className="text-[11px] text-gray-400 text-center">
                    Don't know all dependencies yet? Continue — you can declare them after the application is created.
                  </p>
                </>
              )}
            </div>
          )}
        </form>

        {/* Footer */}
        <div className="flex items-center justify-between gap-3 px-6 py-4 border-t border-gray-100 shrink-0">
          {/* Profile completeness */}
          <div className="flex-1 min-w-0 mr-2">
            <div className="flex items-center gap-2">
              <div className="h-1 w-24 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className={`h-full rounded-full transition-all duration-500 ${completionColour}`}
                  style={{ width: `${completeness}%` }}
                />
              </div>
              <span className="text-[10px] text-gray-400 shrink-0">{completeness}% complete</span>
            </div>
            {submitAttempted && formErrors.length > 0 && (
              <p className="text-[10px] text-amber-600 mt-0.5 truncate">{formErrors[0].msg}</p>
            )}
          </div>
          <div className="flex gap-2">
            {activeTab !== 'basic' && (
              <button
                type="button"
                onClick={() => {
                  const idx = tabs.findIndex(t => t.id === activeTab)
                  setActiveTab(tabs[idx - 1].id)
                }}
                className="btn-secondary text-xs"
              >
                ← Back
              </button>
            )}
            {activeTab !== lastTabId && (
              <button
                type="button"
                onClick={() => {
                  const idx = tabs.findIndex(t => t.id === activeTab)
                  setActiveTab(tabs[idx + 1].id)
                }}
                className="btn-secondary text-xs"
              >
                Next →
              </button>
            )}
          </div>
          <div className="flex gap-3">
            <button type="button" onClick={onClose} className="btn-secondary" disabled={isPending}>
              Cancel
            </button>
            <button
              type="submit"
              form="app-form"
              disabled={isPending || completeness < 100}
              className="btn-primary"
              title={completeness < 100 ? `Form is ${completeness}% complete — fill all required fields to submit` : undefined}
            >
              {isPending && <Loader2 size={15} className="animate-spin" />}
              {isPending ? 'Saving…' : isEdit ? 'Save Changes' : 'Create Application'}
            </button>
          </div>
        </div>

      </div>
    </div>
  )
}

// ─── EndpointList ─────────────────────────────────────────────────────────────

function EndpointList({
  endpoints, onChange, placeholder,
}: {
  endpoints: string[]
  onChange: (list: string[]) => void
  placeholder?: string
}) {
  const update = (i: number, v: string) => onChange(endpoints.map((e, idx) => idx === i ? v : e))
  const add    = () => onChange([...endpoints, ''])
  const remove = (i: number) => onChange(endpoints.filter((_, idx) => idx !== i))

  return (
    <div className="space-y-2">
      {endpoints.map((ep, i) => (
        <div key={i} className="flex items-center gap-2">
          <span className={`text-[10px] font-bold w-14 shrink-0 text-right ${i === 0 ? 'text-gray-500' : 'text-gray-300'}`}>
            {i === 0 ? 'PRIMARY' : `HA ${i}`}
          </span>
          <input
            className="input font-mono text-xs flex-1"
            placeholder={placeholder}
            value={ep}
            onChange={e => update(i, e.target.value)}
          />
          {endpoints.length > 1 && (
            <button type="button" onClick={() => remove(i)} className="p-1.5 text-gray-300 hover:text-red-500 transition-colors">
              <Trash2 size={13} />
            </button>
          )}
        </div>
      ))}
      <button
        type="button"
        onClick={add}
        className="flex items-center gap-1.5 text-xs text-gray-400 hover:text-equity-red transition-colors pl-16"
      >
        <Plus size={12} /> Add another endpoint
      </button>
    </div>
  )
}

// ─── Toggle Pill ──────────────────────────────────────────────────────────────

function TogglePill({ on, colour = 'red' }: { on: boolean; colour?: 'red' | 'amber' | 'purple' }) {
  const bg = on
    ? colour === 'amber'  ? 'bg-amber-500'
    : colour === 'purple' ? 'bg-purple-500'
    : 'bg-equity-red'
    : 'bg-gray-300'
  return (
    <div className={`w-10 h-6 rounded-full relative shrink-0 transition-colors ${bg}`}>
      <span className={`absolute top-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform ${on ? 'translate-x-4.5' : 'translate-x-0.5'}`} />
    </div>
  )
}
