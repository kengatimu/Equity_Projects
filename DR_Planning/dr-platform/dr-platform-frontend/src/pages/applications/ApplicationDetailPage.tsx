import { useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useApplication, useArchiveApplication, useDeactivateApplication } from '../../hooks/useApplications'
import {
  useAppDependencies,
  useArchiveDependency,
  useDeactivateDependency,
  useDependencyHistory,
  useSharedResources,
} from '../../hooks/useDependencies'
import StatusBadge from '../../components/common/StatusBadge'
import ApplicationFormModal from '../../components/applications/ApplicationFormModal'
import DependencyFormModal from '../../components/dependencies/DependencyFormModal'
import { Archive, ArrowLeft, ChevronDown, ChevronRight, GitMerge, Pencil, Plus, PowerOff, Server, X } from 'lucide-react'
import type { DependencyDto } from '../../types'

const DEP_TYPE_COLOUR: Record<string, string> = {
  DATABASE:   'bg-blue-50 text-blue-700',
  MIDDLEWARE: 'bg-purple-50 text-purple-700',
  NETWORK:    'bg-green-50 text-green-700',
  API:        'bg-amber-50 text-amber-700',
  AUTH:       'bg-rose-50 text-rose-700',
  DNS:        'bg-teal-50 text-teal-700',
  VPN:        'bg-indigo-50 text-indigo-700',
  OTHER:      'bg-gray-100 text-gray-600',
}

// Drives the pre-action confirmation modal for each dependency
type DepActionMode = 'deactivate' | 'archive'
type DepAction = { dep: DependencyDto; mode: DepActionMode } | null

export default function ApplicationDetailPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()

  const { data: app,          isLoading       } = useApplication(id!)
  const { data: deps,         isLoading: loadingDeps } = useAppDependencies(id!)
  const { data: depHistory                    } = useDependencyHistory(id!)
  const { data: sharedResources               } = useSharedResources()

  const archiveDep    = useArchiveDependency(id!)
  const deactivateDep = useDeactivateDependency(id!)
  const archiveApp    = useArchiveApplication()
  const deactivateApp = useDeactivateApplication()

  const [editOpen,           setEditOpen]           = useState(false)
  const [depOpen,            setDepOpen]            = useState(false)
  const [confirmArchive,     setConfirmArchive]     = useState(false)
  const [confirmDeactivate,  setConfirmDeactivate]  = useState(false)
  const [depAction,          setDepAction]          = useState<DepAction>(null)
  const [showDepHistory,     setShowDepHistory]     = useState(false)

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-equity-red border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  if (!app) return <div className="card text-center py-12 text-gray-400">Application not found</div>

  // ── Build the list of OTHER apps sharing a dependency's resource ──────────
  function getSharedAppNames(dep: DependencyDto): string[] {
    if (!dep.isShared || !dep.resourceName || !sharedResources) return []
    return (
      sharedResources
        .find(r => r.resourceName === dep.resourceName)
        ?.applications
        .filter(a => a.applicationId !== id)
        .map(a => `${a.applicationName} (${a.applicationCode})`)
      ?? []
    )
  }

  // ── Confirm and execute the pending dependency action ────────────────────
  function executeDependencyAction() {
    if (!depAction) return
    if (depAction.mode === 'archive') {
      archiveDep.mutate(depAction.dep.id, { onSuccess: () => setDepAction(null) })
    } else {
      deactivateDep.mutate(depAction.dep.id, { onSuccess: () => setDepAction(null) })
    }
  }

  const isPending = archiveDep.isPending || deactivateDep.isPending

  return (
    <div className="max-w-4xl space-y-6">

      {/* ── Header ──────────────────────────────────────────────────────── */}
      <div className="flex items-start justify-between gap-4">

        {/* LEFT — identity */}
        <div className="flex items-start gap-3">
          <button onClick={() => navigate(-1)} className="btn-secondary p-2 mt-0.5 shrink-0">
            <ArrowLeft size={16} />
          </button>
          <div className="w-10 h-10 bg-equity-red/10 rounded-xl flex items-center justify-center shrink-0 mt-0.5">
            <Server size={18} className="text-equity-red" />
          </div>
          <div>
            <div className="flex items-center gap-2 flex-wrap">
              <h1 className="text-xl font-bold text-gray-900">{app.name}</h1>
              <StatusBadge status={app.tier} size="md" />
              <StatusBadge
                status={app.isActive ? 'APPROVED' : 'CANCELLED'}
                label={app.isActive ? 'Active' : 'Inactive'}
                size="md"
              />
            </div>
            <p className="text-sm text-gray-400 font-mono mt-0.5">{app.code}</p>
          </div>
        </div>

        {/* RIGHT — actions */}
        <div className="flex items-center gap-2 shrink-0 pt-0.5">
          <button
            onClick={() => { setConfirmArchive(false); setConfirmDeactivate(false); setEditOpen(true) }}
            className="btn-secondary flex items-center gap-1.5 text-sm"
          >
            <Pencil size={14} /> Edit
          </button>

          {/* Deactivate */}
          {confirmDeactivate ? (
            <div className="flex items-center gap-1.5 bg-amber-50 border border-amber-200 rounded-lg px-3 py-1.5">
              <span className="text-xs text-amber-700 font-semibold whitespace-nowrap">Deactivate app?</span>
              <button
                onClick={() => deactivateApp.mutate(app.id, { onSuccess: () => setConfirmDeactivate(false) })}
                disabled={deactivateApp.isPending}
                className="text-xs px-2.5 py-1 rounded-md bg-amber-500 text-white font-semibold hover:bg-amber-600 disabled:opacity-50"
              >
                {deactivateApp.isPending ? 'Saving…' : 'Confirm'}
              </button>
              <button onClick={() => setConfirmDeactivate(false)}
                className="text-xs px-2.5 py-1 rounded-md border border-amber-200 text-amber-700 font-medium hover:bg-amber-100">
                Cancel
              </button>
            </div>
          ) : (
            <button
              onClick={() => setConfirmDeactivate(true)}
              disabled={!app.isActive}
              title={app.isActive ? 'Deactivate this application' : 'Already inactive'}
              className="flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-lg border border-amber-200 text-amber-600 font-semibold hover:bg-amber-50 transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <PowerOff size={14} /> Deactivate
            </button>
          )}

          {/* Archive */}
          {confirmArchive ? (
            <div className="flex items-center gap-1.5 bg-red-50 border border-red-200 rounded-lg px-3 py-1.5">
              <span className="text-xs text-equity-red font-semibold whitespace-nowrap">Archive app?</span>
              <button
                onClick={() => archiveApp.mutate(app.id, { onSuccess: () => navigate('/applications') })}
                disabled={archiveApp.isPending}
                className="text-xs px-2.5 py-1 rounded-md bg-equity-red text-white font-semibold hover:bg-equity-red/90 disabled:opacity-50"
              >
                {archiveApp.isPending ? 'Archiving…' : 'Confirm'}
              </button>
              <button onClick={() => setConfirmArchive(false)}
                className="text-xs px-2.5 py-1 rounded-md border border-red-200 text-equity-red font-medium hover:bg-red-100">
                Cancel
              </button>
            </div>
          ) : (
            <button
              onClick={() => setConfirmArchive(true)}
              className="flex items-center gap-1.5 text-sm px-3 py-1.5 rounded-lg border border-red-200 text-equity-red font-semibold hover:bg-red-50 transition-colors"
            >
              <Archive size={14} /> Archive
            </button>
          )}
        </div>
      </div>

      {/* ── Info cards ──────────────────────────────────────────────────── */}
      <div className="grid md:grid-cols-2 gap-4">
        <InfoCard title="Application Details">
          <InfoRow label="Code"            value={app.code}                               mono />
          <InfoRow label="Name"            value={app.name} />
          <InfoRow label="Tier"            value={<StatusBadge status={app.tier} />} />
          <InfoRow label="Subsidiary"      value={app.subsidiaryId} />
          <InfoRow label="Vendor"          value={app.vendor ?? '—'} />
          <InfoRow label="Customer Impact" value={app.directCustomerImpact ? 'Yes' : 'No'} />
        </InfoCard>

        <InfoCard title="DR Configuration">
          <InfoRow label="DR Capable"    value={app.hasDr ? 'Yes' : 'No'} />
          <InfoRow label="DR Capability" value={app.drCapability ?? '—'} />
          <InfoRow label="DC Endpoint"   value={app.dcEndpoint ?? '—'} mono />
          <InfoRow label="DR Endpoint"   value={app.drEndpoint ?? '—'} mono />
        </InfoCard>

        {app.description && (
          <div className="card md:col-span-2">
            <h3 className="text-sm font-semibold text-gray-700 mb-2">Description</h3>
            <p className="text-sm text-gray-600 leading-relaxed">{app.description}</p>
          </div>
        )}
      </div>

      {/* ── Active Dependencies ─────────────────────────────────────────── */}
      <div className="card space-y-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <GitMerge size={16} className="text-equity-red" />
            <h3 className="text-sm font-semibold text-gray-700">
              Dependencies
              {deps && deps.length > 0 && (
                <span className="ml-2 text-xs font-normal text-gray-400">({deps.length} active)</span>
              )}
            </h3>
          </div>
          <button onClick={() => setDepOpen(true)} className="btn-secondary text-xs py-1.5 flex items-center gap-1.5">
            <Plus size={12} /> Add Dependency
          </button>
        </div>

        {loadingDeps ? (
          <p className="text-xs text-gray-400 py-4 text-center">Loading dependencies…</p>
        ) : !deps || deps.length === 0 ? (
          <div className="py-6 text-center">
            <p className="text-sm text-gray-400">No active dependencies registered.</p>
            <p className="text-xs text-gray-300 mt-1">Add databases, middleware, and other resources this app depends on.</p>
          </div>
        ) : (
          <div className="divide-y divide-gray-50">
            {deps.map(dep => (
              <div key={dep.id} className="flex items-center gap-3 py-2.5">
                {/* Type badge */}
                <span className={`text-xs px-2 py-0.5 rounded-full font-medium shrink-0 ${DEP_TYPE_COLOUR[dep.dependencyType] ?? DEP_TYPE_COLOUR.OTHER}`}>
                  {dep.dependencyType}
                </span>
                {/* Resource name */}
                <span className="font-mono text-xs font-semibold text-gray-700 flex-1 truncate">
                  {dep.resourceName ?? '—'}
                </span>
                {/* Shared badge */}
                {dep.isShared && (
                  <span className="text-[10px] px-1.5 py-0.5 bg-amber-50 text-amber-600 rounded-full font-semibold shrink-0">
                    SHARED
                  </span>
                )}
                {/* Description */}
                {dep.description && (
                  <span className="text-xs text-gray-400 truncate hidden sm:block max-w-[160px]">
                    {dep.description}
                  </span>
                )}

                {/* ── Action buttons — always visible, pipe-separated ── */}
                <div className="flex items-center gap-1 shrink-0">
                  <div className="w-px h-4 bg-gray-200 mx-0.5" />
                  <button
                    onClick={() => setDepAction({ dep, mode: 'deactivate' })}
                    className="text-[11px] px-2 py-1 rounded-md border border-amber-200 text-amber-600 hover:bg-amber-50 flex items-center gap-1 font-semibold transition-colors"
                  >
                    <PowerOff size={11} /> Deactivate
                  </button>
                  <button
                    onClick={() => setDepAction({ dep, mode: 'archive' })}
                    className="text-[11px] px-2 py-1 rounded-md border border-red-200 text-equity-red hover:bg-red-50 flex items-center gap-1 font-semibold transition-colors"
                  >
                    <Archive size={11} /> Archive
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* ── Archived dependencies (collapsible) ── */}
        {depHistory && depHistory.length > 0 && (
          <div className="border-t border-gray-100 pt-3">
            <button
              onClick={() => setShowDepHistory(v => !v)}
              className="flex items-center gap-1.5 text-xs text-gray-400 hover:text-gray-600 font-medium transition-colors"
            >
              {showDepHistory ? <ChevronDown size={13} /> : <ChevronRight size={13} />}
              {depHistory.length} archived {depHistory.length === 1 ? 'dependency' : 'dependencies'}
            </button>
            {showDepHistory && (
              <div className="mt-2 divide-y divide-gray-50">
                {depHistory.map(h => (
                  <div key={h.id} className="flex items-center gap-3 py-2 opacity-50">
                    <span className={`text-xs px-2 py-0.5 rounded-full font-medium shrink-0 ${DEP_TYPE_COLOUR[h.dependencyType] ?? DEP_TYPE_COLOUR.OTHER}`}>
                      {h.dependencyType}
                    </span>
                    <span className="font-mono text-xs font-semibold text-gray-500 flex-1 truncate line-through">
                      {h.resourceName ?? '—'}
                    </span>
                    <span className="text-[10px] text-gray-400 shrink-0">
                      Archived {h.archivedAt
                        ? new Date(h.archivedAt).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
                        : ''}
                      {h.archivedByEmail ? ` · ${h.archivedByEmail}` : ''}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>

      {/* ── Modals ──────────────────────────────────────────────────────── */}
      <ApplicationFormModal isOpen={editOpen} onClose={() => setEditOpen(false)} app={app} />
      <DependencyFormModal applicationId={id!} isOpen={depOpen} onClose={() => setDepOpen(false)} />

      {/* ── Dependency action confirmation modal ─────────────────────────
           Shows BEFORE executing deactivate or archive.
           Lists all other applications that share the same resource
           so the user can make an informed decision.
      ──────────────────────────────────────────────────────────────────── */}
      {depAction && (() => {
        const isArchive       = depAction.mode === 'archive'
        const sharedAppNames  = getSharedAppNames(depAction.dep)
        const hasSharedApps   = sharedAppNames.length > 0
        const actionLabel     = isArchive ? 'Archive' : 'Deactivate'
        const actionColour    = isArchive
          ? 'bg-equity-red hover:bg-equity-red/90'
          : 'bg-amber-500 hover:bg-amber-600'
        const headerColour    = isArchive ? 'text-equity-red' : 'text-amber-600'

        return (
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4">
            <div className="bg-white rounded-2xl shadow-xl w-full max-w-md p-6 space-y-4">

              {/* Modal header */}
              <div className="flex items-start justify-between">
                <div>
                  <h3 className={`text-base font-bold ${headerColour}`}>{actionLabel} Dependency</h3>
                  <p className="text-sm text-gray-500 mt-0.5">
                    {depAction.dep.resourceName ?? depAction.dep.dependencyType}
                    <span className={`ml-2 text-xs px-1.5 py-0.5 rounded-full font-medium ${DEP_TYPE_COLOUR[depAction.dep.dependencyType] ?? DEP_TYPE_COLOUR.OTHER}`}>
                      {depAction.dep.dependencyType}
                    </span>
                  </p>
                </div>
                <button onClick={() => setDepAction(null)} className="text-gray-400 hover:text-gray-600 transition-colors mt-0.5">
                  <X size={18} />
                </button>
              </div>

              {/* Shared-apps warning */}
              {hasSharedApps && (
                <div className="bg-amber-50 border border-amber-200 rounded-xl p-3 space-y-2">
                  <p className="text-xs font-semibold text-amber-700">
                    ⚠️  This resource is also registered for {sharedAppNames.length} other {sharedAppNames.length === 1 ? 'application' : 'applications'}:
                  </p>
                  <ul className="space-y-1 max-h-32 overflow-y-auto">
                    {sharedAppNames.map(name => (
                      <li key={name} className="flex items-center gap-2 text-xs text-amber-800">
                        <span className="w-1.5 h-1.5 rounded-full bg-amber-400 shrink-0" />
                        {name}
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* Action explanation */}
              <p className="text-sm text-gray-600">
                {isArchive
                  ? 'Archiving moves this dependency record to history and removes it from the active list. '
                  : 'Deactivating marks this dependency as inactive without removing the record. '}
                {hasSharedApps
                  ? 'Other applications listed above keep their own dependency records — they are not affected.'
                  : 'This dependency is not shared with any other application.'}
              </p>

              {/* Actions */}
              <div className="flex justify-end gap-2 pt-1">
                <button
                  onClick={() => setDepAction(null)}
                  className="btn-secondary text-sm"
                >
                  Cancel
                </button>
                <button
                  onClick={executeDependencyAction}
                  disabled={isPending}
                  className={`text-sm px-4 py-2 rounded-lg text-white font-semibold transition-colors disabled:opacity-50 ${actionColour}`}
                >
                  {isPending ? `${actionLabel}…` : actionLabel}
                </button>
              </div>
            </div>
          </div>
        )
      })()}
    </div>
  )
}

function InfoCard({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="card">
      <h3 className="text-sm font-semibold text-gray-700 mb-4">{title}</h3>
      <div className="space-y-2.5">{children}</div>
    </div>
  )
}

function InfoRow({ label, value, mono }: { label: string; value: React.ReactNode; mono?: boolean }) {
  return (
    <div className="flex justify-between items-center py-1 border-b border-gray-50 last:border-0">
      <span className="text-xs text-gray-500">{label}</span>
      <span className={`text-xs font-medium text-gray-800 max-w-[60%] truncate text-right ${mono ? 'font-mono' : ''}`}>
        {value}
      </span>
    </div>
  )
}
