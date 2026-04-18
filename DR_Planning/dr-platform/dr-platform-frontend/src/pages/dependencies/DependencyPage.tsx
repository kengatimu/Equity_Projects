import { useState } from 'react'
import { Link } from 'react-router-dom'
import { Archive, CheckCircle2, Database, GitMerge, Layers, Link2, Plus, PowerOff, RefreshCw, Server, X } from 'lucide-react'
import { useSharedResources, useArchiveDependency, useCreateSharedResource, useSharedResourceRegistry, useDeactivateSharedResource, useArchiveSharedResource, useSharedResourceHistory, ArchiveSharedResourceResult } from '../../hooks/useDependencies'
import { useApplications, useApplicationHistory } from '../../hooks/useApplications'
import axiosClient from '../../api/axiosClient'
import { useQueryClient } from '@tanstack/react-query'
import { useAppDependencies } from '../../hooks/useDependencies'
import DependencyFormModal from '../../components/dependencies/DependencyFormModal'
import StatusBadge from '../../components/common/StatusBadge'
import { DEP_TYPES } from '../../components/dependencies/ResourcePicker'
import type { SharedResourceDto, SharedResourceSummaryDto, SharedResourceAppRef, DependencyType } from '../../types'

// ─── Dependency type colour ────────────────────────────────────────────────────
export const TYPE_COLOUR: Record<string, string> = {
  DATABASE:   'bg-blue-50 text-blue-700 ring-1 ring-blue-200',
  MIDDLEWARE: 'bg-purple-50 text-purple-700 ring-1 ring-purple-200',
  NETWORK:    'bg-green-50 text-green-700 ring-1 ring-green-200',
  API:        'bg-amber-50 text-amber-700 ring-1 ring-amber-200',
  AUTH:       'bg-rose-50 text-rose-700 ring-1 ring-rose-200',
  DNS:        'bg-teal-50 text-teal-700 ring-1 ring-teal-200',
  VPN:        'bg-indigo-50 text-indigo-700 ring-1 ring-indigo-200',
  OTHER:      'bg-gray-100 text-gray-600 ring-1 ring-gray-200',
}

export const TYPE_ICON: Record<string, React.ReactNode> = {
  DATABASE:   <Database size={13} />,
  MIDDLEWARE: <Layers size={13} />,
  NETWORK:    <GitMerge size={13} />,
  API:        <Server size={13} />,
  AUTH:       <Server size={13} />,
  DNS:        <Server size={13} />,
  VPN:        <Server size={13} />,
  OTHER:      <Server size={13} />,
}

type Tab = 'shared' | 'by-app' | 'registry'

// ─── Page ─────────────────────────────────────────────────────────────────────
export default function DependencyPage() {
  const [tab, setTab] = useState<Tab>('registry')
  const [addForApp, setAddForApp] = useState<string | null>(null)
  const [registerOpen, setRegisterOpen] = useState(false)
  const [linkResource, setLinkResource] = useState<SharedResourceDto | null>(null)

  // Fixed-position apps popover (escapes table overflow)
  const [appsPopover, setAppsPopover] = useState<{
    x: number; y: number; apps: SharedResourceAppRef[]
  } | null>(null)

  // Registry row actions
  type RegistryRowMode = 'confirmDeactivate' | 'confirmArchive' | 'warningArchive'
  type RegistryRowState = { id: string; mode: RegistryRowMode; warningApps?: string[] } | null
  const [regRowState, setRegRowState] = useState<RegistryRowState>(null)

  const deactivateRes = useDeactivateSharedResource()
  const archiveRes    = useArchiveSharedResource()

  const { data: shared, isLoading: loadingShared, refetch } = useSharedResources()
  const { data: apps, isLoading: loadingApps } = useApplications({ size: 200 })
  const { data: registry, isLoading: loadingRegistry, refetch: refetchRegistry } = useSharedResourceRegistry()
  useSharedResourceHistory() // pre-warm cache for /dependencies/history page

  const totalShared = shared?.length ?? 0
  // Count apps that have ANY dependency (shared or not) using the hasDependency flag
  const totalAppsWithDeps = apps?.content.filter(a => a.hasDependency).length ?? 0

  return (
    <div className="space-y-5 max-w-7xl">
      {/* Header */}
      <div className="flex items-start justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Dependency Engine</h1>
          <p className="text-gray-500 text-sm mt-0.5">
            Map shared infrastructure and detect DR scheduling conflicts.
          </p>
        </div>
        <div className="flex items-center gap-2 shrink-0">
          <button
            onClick={() => refetch()}
            className="btn-secondary flex items-center gap-1.5"
          >
            <RefreshCw size={14} /> Refresh
          </button>
          <button
            onClick={() => setRegisterOpen(true)}
            className="btn-primary flex items-center gap-1.5"
          >
            <Plus size={14} /> Register Resource
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-4">
        <StatCard label="Shared Resources" value={totalShared} sub="databases, middleware, APIs" colour="blue" />
        <StatCard label="Apps with Dependencies" value={totalAppsWithDeps} sub="have at least one dependency (shared or not)" colour="purple" />
        <StatCard
          label="Conflict Risk"
          value={shared?.filter(r => r.applicationCount >= 3).length ?? 0}
          sub="resources shared by 3+ apps"
          colour="red"
        />
      </div>

      {/* Tab bar */}
      <div className="flex border-b border-gray-200">
        {([
          ['registry', `Resource Registry${registry ? ` (${registry.length})` : ''}`],
          ['shared',   `Shared Resources${shared ? ` (${shared.length})` : ''}`],
          ['by-app',   `By Application${apps ? ` (${apps.content.filter(a => a.hasDependency).length})` : ''}`],
        ] as [Tab, string][]).map(([t, label]) => (
          <button
            key={t}
            onClick={() => setTab(t)}
            className={`px-4 py-2.5 text-sm font-medium border-b-2 transition-colors -mb-px ${
              tab === t
                ? 'border-equity-red text-equity-red'
                : 'border-transparent text-gray-500 hover:text-gray-700'
            }`}
          >
            {label}
          </button>
        ))}
      </div>

      {/* ── Shared Resources tab ──────────────────────────────────────────── */}
      {tab === 'shared' && (
        <div>
          {loadingShared ? (
            <Loading />
          ) : !shared || shared.length === 0 ? (
            <EmptyState
              title="No shared resources registered yet"
              sub="Register a shared resource above, or open an application and declare its dependencies."
              onRegister={() => setRegisterOpen(true)}
            />
          ) : (
            <div className="grid sm:grid-cols-2 xl:grid-cols-3 gap-4">
              {shared.map(resource => (
                <SharedResourceCard key={resource.resourceName} resource={resource} />
              ))}
            </div>
          )}
        </div>
      )}

      {/* ── By Application tab ────────────────────────────────────────────── */}
      {tab === 'by-app' && (
        <div className="space-y-3">
          {loadingApps ? (
            <Loading />
          ) : (
            apps?.content.map(app => (
              <AppDependencyRow
                key={app.id}
                appId={app.id}
                appCode={app.code}
                appName={app.name}
                appTier={app.tier}
              />
            ))
          )}
        </div>
      )}

      {/* ── Resource Registry tab ─────────────────────────────────────────── */}
      {tab === 'registry' && (
        <div className="card p-0 overflow-hidden">
          <div className="flex items-center justify-between px-5 py-3.5 border-b border-gray-100">
            <div>
              <p className="text-sm font-semibold text-gray-800">Registered Infrastructure Resources</p>
              <p className="text-xs text-gray-400 mt-0.5">
                All resources in the catalog — link them to applications to see them on the Shared Resources tab.
              </p>
            </div>
            <div className="flex items-center gap-2">
              <Link to="/dependencies/history" className="btn-secondary text-xs flex items-center gap-1.5 py-1.5">
                <Archive size={12} /> History
              </Link>
              <button
                onClick={() => { refetchRegistry(); refetch() }}
                className="btn-secondary text-xs flex items-center gap-1.5 py-1.5"
              >
                <RefreshCw size={12} /> Refresh
              </button>
            </div>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-100">
                  <th className="table-header">Type</th>
                  <th className="table-header">Code</th>
                  <th className="table-header">Name</th>
                  <th className="table-header">Host / Endpoint</th>
                  <th className="table-header">Environment</th>
                  <th className="table-header">Apps Linked</th>
                  <th className="table-header">Status</th>
                  <th className="table-header w-72">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-50">
                {loadingRegistry
                  ? Array.from({ length: 4 }).map((_, i) => (
                      <tr key={i}>
                        {Array.from({ length: 8 }).map((_, j) => (
                          <td key={j} className="table-cell">
                            <div className="h-4 bg-gray-100 rounded animate-pulse" />
                          </td>
                        ))}
                      </tr>
                    ))
                  : !registry || registry.length === 0
                  ? (
                    <tr>
                      <td colSpan={8} className="table-cell py-12 text-center text-gray-400 text-sm">
                        No resources registered yet.{' '}
                        <button
                          onClick={() => setRegisterOpen(true)}
                          className="text-equity-red hover:underline font-medium"
                        >
                          Register the first one
                        </button>
                      </td>
                    </tr>
                  )
                  : registry.map(res => {
                      // Count how many apps are using this resource (from the shared summary)
                      const sharedEntry  = shared?.find(s => s.resourceName === res.code)
                      const linkedApps   = sharedEntry?.applicationCount ?? 0
                      const linkedAppRefs = sharedEntry?.applications ?? []
                      return (
                        <tr key={res.id} className="hover:bg-gray-50 transition-colors">
                          <td className="table-cell">
                            <span className={`inline-flex items-center gap-1 text-xs px-2 py-0.5 rounded-full font-medium ${TYPE_COLOUR[res.resourceType] ?? TYPE_COLOUR.OTHER}`}>
                              {TYPE_ICON[res.resourceType]}
                              {res.resourceType}
                            </span>
                          </td>
                          <td className="table-cell font-mono text-xs font-semibold text-equity-red">
                            {res.code}
                          </td>
                          <td className="table-cell text-sm font-medium text-gray-800">
                            {res.name}
                          </td>
                          <td className="table-cell text-xs text-gray-500 max-w-[180px] truncate" title={res.host}>
                            {res.host ?? <span className="text-gray-300">—</span>}
                          </td>
                          <td className="table-cell">
                            <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                              res.environment === 'PRODUCTION' ? 'bg-green-50 text-green-700' :
                              res.environment === 'DR'         ? 'bg-blue-50 text-blue-700' :
                                                                 'bg-gray-100 text-gray-600'
                            }`}>
                              {res.environment}
                            </span>
                          </td>
                          <td className="table-cell text-center">
                            {linkedApps > 0 ? (
                              <span
                                className="text-xs font-semibold text-equity-red cursor-default underline decoration-dotted underline-offset-2"
                                onMouseEnter={e => {
                                  const r = (e.currentTarget as HTMLElement).getBoundingClientRect()
                                  setAppsPopover({ x: r.left + r.width / 2, y: r.bottom, apps: linkedAppRefs })
                                }}
                                onMouseLeave={() => setAppsPopover(null)}
                              >
                                {linkedApps} app{linkedApps !== 1 ? 's' : ''}
                              </span>
                            ) : (
                              <span className="text-xs text-gray-300">none</span>
                            )}
                          </td>
                          <td className="table-cell">
                            <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                              res.isActive ? 'bg-green-50 text-green-700' : 'bg-gray-100 text-gray-400'
                            }`}>
                              {res.isActive ? 'Active' : 'Inactive'}
                            </span>
                          </td>
                          <td className="table-cell whitespace-nowrap">
                            {regRowState?.id === res.id ? (
                              /* ── Inline confirm / warning ── */
                              regRowState.mode === 'warningArchive' ? (
                                <div className="space-y-1.5">
                                  <div className="flex items-start gap-1.5 p-2 bg-amber-50 border border-amber-200 rounded-lg">
                                    <span className="text-[10px] text-amber-800 leading-relaxed">
                                      ⚠ Used by {regRowState.warningApps?.join(', ')}. Archive anyway?
                                    </span>
                                  </div>
                                  <div className="flex gap-1">
                                    <button
                                      onClick={() => archiveRes.mutate(
                                        { id: res.id, force: true },
                                        { onSuccess: () => setRegRowState(null) }
                                      )}
                                      disabled={archiveRes.isPending}
                                      className="text-[10px] px-2 py-0.5 rounded bg-equity-red text-white font-semibold hover:bg-equity-red/90 disabled:opacity-50"
                                    >
                                      Yes, archive
                                    </button>
                                    <button onClick={() => setRegRowState(null)} className="text-[10px] px-2 py-0.5 rounded border border-gray-200 text-gray-600 hover:bg-gray-50">
                                      Cancel
                                    </button>
                                  </div>
                                </div>
                              ) : regRowState.mode === 'confirmDeactivate' ? (
                                <div className="flex items-center gap-1">
                                  <span className="text-[10px] text-amber-700 font-medium">Deactivate?</span>
                                  <button
                                    onClick={() => deactivateRes.mutate(res.id, { onSuccess: () => setRegRowState(null) })}
                                    disabled={deactivateRes.isPending}
                                    className="text-[10px] px-2 py-0.5 rounded bg-amber-500 text-white font-semibold hover:bg-amber-600 disabled:opacity-50"
                                  >
                                    Yes
                                  </button>
                                  <button onClick={() => setRegRowState(null)} className="text-[10px] px-2 py-0.5 rounded border border-gray-200 text-gray-600 hover:bg-gray-50">
                                    No
                                  </button>
                                </div>
                              ) : (
                                /* confirmArchive */
                                <div className="flex items-center gap-1">
                                  <span className="text-[10px] text-equity-red font-medium">Archive?</span>
                                  <button
                                    onClick={() => {
                                      archiveRes.mutate(
                                        { id: res.id, force: false },
                                        {
                                          onSuccess: (result: ArchiveSharedResourceResult) => {
                                            if (result.hasWarnings && !result.archived) {
                                              setRegRowState({ id: res.id, mode: 'warningArchive', warningApps: result.warningApps })
                                            } else {
                                              setRegRowState(null)
                                            }
                                          },
                                        },
                                      )
                                    }}
                                    disabled={archiveRes.isPending}
                                    className="text-[10px] px-2 py-0.5 rounded bg-equity-red text-white font-semibold hover:bg-equity-red/90 disabled:opacity-50"
                                  >
                                    Yes
                                  </button>
                                  <button onClick={() => setRegRowState(null)} className="text-[10px] px-2 py-0.5 rounded border border-gray-200 text-gray-600 hover:bg-gray-50">
                                    No
                                  </button>
                                </div>
                              )
                            ) : (
                              /* ── Default action buttons ── */
                              <div className="flex items-center gap-1.5">
                                <button
                                  onClick={() => setLinkResource(res)}
                                  className="text-[11px] px-2 py-1 rounded-lg bg-equity-red text-white font-semibold hover:bg-equity-red/90 transition-colors inline-flex items-center gap-1 whitespace-nowrap"
                                >
                                  <Link2 size={11} /> Link to App
                                </button>
                                <div className="flex items-center gap-1">
                                  <div className="w-px h-4 bg-gray-200 mx-0.5" />
                                  <button
                                    onClick={() => setRegRowState({ id: res.id, mode: 'confirmDeactivate' })}
                                    disabled={!res.isActive}
                                    title={res.isActive ? 'Deactivate resource' : 'Already inactive'}
                                    className="text-[11px] px-2 py-1 rounded-md border border-amber-200 text-amber-600 hover:bg-amber-50 flex items-center gap-1 font-semibold disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                                  >
                                    <PowerOff size={11} /> Deactivate
                                  </button>
                                  <button
                                    onClick={() => setRegRowState({ id: res.id, mode: 'confirmArchive' })}
                                    className="text-[11px] px-2 py-1 rounded-md border border-red-200 text-equity-red hover:bg-red-50 flex items-center gap-1 font-semibold transition-colors"
                                  >
                                    <Archive size={11} /> Archive
                                  </button>
                                </div>
                              </div>
                            )}
                          </td>
                        </tr>
                      )
                    })}
              </tbody>
            </table>
          </div>

        </div>
      )}

      {/* Add dependency modal (per-application) */}
      {addForApp && (
        <DependencyFormModal
          applicationId={addForApp}
          isOpen={!!addForApp}
          onClose={() => setAddForApp(null)}
        />
      )}

      {/* Link resource to app modal (from Registry tab) */}
      {linkResource && (
        <LinkResourceModal
          resource={linkResource}
          apps={apps?.content ?? []}
          onClose={() => setLinkResource(null)}
          onLinked={() => { refetch(); refetchRegistry() }}
        />
      )}

      {/* Register standalone shared resource modal */}
      <RegisterResourceModal
        isOpen={registerOpen}
        onClose={() => setRegisterOpen(false)}
        onSuccess={() => { setRegisterOpen(false); setTab('registry'); refetch(); refetchRegistry() }}
      />

      {/* ── Fixed apps popover — escapes table overflow ── */}
      {appsPopover && (
        <div
          className="fixed z-[9999] pointer-events-none"
          style={{ left: appsPopover.x, top: appsPopover.y + 8, transform: 'translateX(-50%)' }}
        >
          {/* Caret */}
          <div className="flex justify-center mb-0">
            <div className="border-[6px] border-transparent border-b-equity-red" />
          </div>
          <div className="rounded-xl overflow-hidden shadow-2xl border border-equity-red/20 min-w-[180px]">
            <div className="bg-equity-red px-3 py-1.5">
              <p className="text-[10px] font-bold text-white uppercase tracking-widest whitespace-nowrap">
                {appsPopover.apps.length} Linked App{appsPopover.apps.length !== 1 ? 's' : ''}
              </p>
            </div>
            <div className="bg-white divide-y divide-gray-100">
              {appsPopover.apps.map(app => (
                <div key={String(app.dependencyId)} className="flex items-center gap-2.5 px-3 py-2">
                  <span className="shrink-0 w-1.5 h-1.5 rounded-full bg-equity-red" />
                  <div>
                    <p className="font-mono text-[11px] font-bold text-gray-900 whitespace-nowrap">{app.applicationCode}</p>
                    {app.applicationName !== app.applicationCode && (
                      <p className="text-[10px] text-gray-400 whitespace-nowrap">{app.applicationName}</p>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

// ─── Shared Resource Card ──────────────────────────────────────────────────────
function SharedResourceCard({ resource }: { resource: SharedResourceSummaryDto }) {
  return (
    <div className="card hover:shadow-md transition-shadow">
      {/* Card header */}
      <div className="flex items-start justify-between gap-2 mb-3">
        <div className="min-w-0">
          <p className="font-mono text-sm font-semibold text-gray-800 truncate">{resource.resourceName}</p>
          <span className={`inline-flex items-center gap-1 mt-1 text-xs px-2 py-0.5 rounded-full font-medium ${TYPE_COLOUR[resource.dependencyType] ?? TYPE_COLOUR.OTHER}`}>
            {TYPE_ICON[resource.dependencyType]}
            {resource.dependencyType}
          </span>
        </div>
      </div>

      {/* Applications */}
      <div className="space-y-1.5 mt-3">
        <p className="text-[11px] uppercase tracking-wide text-gray-400 font-semibold mb-1.5">
          {resource.applicationCount} application{resource.applicationCount !== 1 ? 's' : ''}
        </p>
        {resource.applications.map(app => (
          <div key={app.applicationId} className="flex items-center gap-2 text-xs">
            <div className="w-1.5 h-1.5 rounded-full bg-equity-red/40 shrink-0" />
            <Link
              to={`/applications/${app.applicationId}`}
              className="font-mono text-equity-red hover:underline font-medium"
            >
              {app.applicationCode}
            </Link>
            <span className="text-gray-600 truncate flex-1">{app.applicationName}</span>
            {app.applicationTier && <StatusBadge status={app.applicationTier} />}
          </div>
        ))}
      </div>

      {resource.applicationCount >= 2 && (
        <p className="mt-3 pt-3 border-t border-gray-50 text-[11px] text-gray-400 leading-relaxed">
          ⚠ These applications share this resource — scheduling them in the same campaign may cause a conflict.
        </p>
      )}
    </div>
  )
}

// ─── Per-Application dependency row ───────────────────────────────────────────
function AppDependencyRow({
  appId, appCode, appName, appTier,
}: {
  appId: string
  appCode: string
  appName: string
  appTier: string
}) {
  const [open, setOpen]           = useState(false)
  const [confirmId, setConfirmId] = useState<string | null>(null)
  const { data: deps, isLoading } = useAppDependencies(open ? appId : '')
  const archive = useArchiveDependency(appId)

  return (
    <div className="card">
      <div
        className="flex items-center gap-3 cursor-pointer select-none"
        onClick={() => setOpen(v => !v)}
      >
        <div className="w-7 h-7 bg-equity-red/10 rounded-lg flex items-center justify-center shrink-0">
          <Server size={13} className="text-equity-red" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <span className="font-mono text-xs font-semibold text-equity-red">{appCode}</span>
            <span className="text-sm font-medium text-gray-800 truncate">{appName}</span>
            <StatusBadge status={appTier} />
          </div>
        </div>
        <Link
          to={`/applications/${appId}`}
          onClick={e => e.stopPropagation()}
          className="inline-flex items-center gap-1 text-xs px-2.5 py-1 rounded-lg border border-gray-200 text-gray-600 hover:border-equity-red hover:text-equity-red font-medium transition-colors shrink-0"
        >
          Manage <span className="text-[10px]">→</span>
        </Link>
        <span className="text-gray-400 text-sm">{open ? '▲' : '▼'}</span>
      </div>

      {open && (
        <div className="mt-3 pt-3 border-t border-gray-50">
          {isLoading ? (
            <p className="text-xs text-gray-400 py-2">Loading…</p>
          ) : !deps || deps.length === 0 ? (
            <p className="text-xs text-gray-400 py-2">No dependencies registered for this application.</p>
          ) : (
            <div className="space-y-2">
              {deps.map(dep => (
                <div key={dep.id} className="flex items-center gap-3 text-xs py-1.5 px-2 rounded-lg hover:bg-gray-50 group">
                  <span className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full font-medium shrink-0 ${TYPE_COLOUR[dep.dependencyType] ?? TYPE_COLOUR.OTHER}`}>
                    {dep.dependencyType}
                  </span>
                  <span className="font-mono text-gray-700 font-medium flex-1 truncate">
                    {dep.resourceName ?? '—'}
                  </span>
                  {dep.isShared && (
                    <span className="text-[10px] px-1.5 py-0.5 bg-amber-50 text-amber-600 rounded-full font-semibold">
                      SHARED
                    </span>
                  )}
                  {dep.description && (
                    <span className="text-gray-400 truncate hidden group-hover:block max-w-[200px]">
                      {dep.description}
                    </span>
                  )}
                  {/* Confirm-then-archive */}
                  {confirmId === dep.id ? (
                    <div className="flex items-center gap-1 shrink-0">
                      <span className="text-[10px] text-equity-red font-semibold">Archive?</span>
                      <button
                        onClick={() => archive.mutate(dep.id, { onSuccess: () => setConfirmId(null) })}
                        disabled={archive.isPending}
                        className="text-[10px] px-2 py-0.5 rounded bg-equity-red text-white font-semibold hover:bg-equity-red/90 disabled:opacity-50"
                      >
                        Yes
                      </button>
                      <button
                        onClick={() => setConfirmId(null)}
                        className="text-[10px] px-2 py-0.5 rounded border border-gray-200 text-gray-600 hover:bg-gray-50"
                      >
                        No
                      </button>
                    </div>
                  ) : (
                    <button
                      onClick={() => setConfirmId(dep.id)}
                      className="p-1 text-gray-300 hover:text-equity-red transition-colors opacity-0 group-hover:opacity-100 shrink-0"
                      title="Archive dependency"
                    >
                      <Archive size={12} />
                    </button>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─── Per-type field hints ──────────────────────────────────────────────────────
const TYPE_HINTS: Record<string, { name: string; code: string; host: string }> = {
  DATABASE:   { name: 'e.g. Oracle DataGuard Cluster',       code: 'ORACLE_DG_CLUSTER',    host: 'e.g. db-primary.corp.internal' },
  MIDDLEWARE: { name: 'e.g. Oracle SOA Suite Middleware',     code: 'ORACLE_SOA_MIDDLEWARE',  host: 'e.g. soa-server-01.corp.internal' },
  NETWORK:    { name: 'e.g. F5 BIG-IP Load Balancer',        code: 'F5_BIGIP_LB',           host: 'e.g. 10.0.1.245 (F5 management IP)' },
  API:        { name: 'e.g. SWIFT Payment Gateway',          code: 'SWIFT_GATEWAY',         host: 'e.g. https://swift.banknet.internal/api' },
  AUTH:       { name: 'e.g. Active Directory Primary DC',    code: 'AD_PRIMARY_DC',         host: 'e.g. ldap://ad.corp.internal' },
  DNS:        { name: 'e.g. Internal DNS Resolver',          code: 'INTERNAL_DNS',          host: 'e.g. 10.0.0.53' },
  VPN:        { name: 'e.g. Site-to-Site VPN Tunnel',        code: 'VPN_SITE_TUNNEL',       host: 'e.g. vpn-gateway.corp.internal' },
  OTHER:      { name: 'e.g. NFS Storage Mount',              code: 'NFS_STORAGE',           host: 'e.g. nfs-server.corp.internal:/exports/data' },
}

// ─── Link Resource to App Modal ───────────────────────────────────────────────
function LinkResourceModal({
  resource, apps, onClose, onLinked,
}: {
  resource: SharedResourceDto
  apps: Array<{ id: string; code: string; name: string }>
  onClose: () => void
  onLinked: () => void
}) {
  const [selectedAppId, setSelectedAppId] = useState('')
  const [linking, setLinking]             = useState(false)
  const [linked, setLinked]               = useState<string[]>([])
  const qc = useQueryClient()

  const handleLink = async () => {
    if (!selectedAppId) return
    setLinking(true)
    try {
      await axiosClient.post(`/applications/${selectedAppId}/dependencies`, {
        dependencyType: resource.resourceType,
        isShared: true,
        resourceName: resource.name,
      })
      const appName = apps.find(a => a.id === selectedAppId)?.name ?? selectedAppId
      setLinked(prev => [...prev, appName])
      setSelectedAppId('')
      qc.invalidateQueries({ queryKey: ['dependencies', 'shared'] })
      qc.invalidateQueries({ queryKey: ['dependencies', 'app', selectedAppId] })
      onLinked()
    } finally {
      setLinking(false)
    }
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm px-4"
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-md p-6 space-y-4">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div>
            <h3 className="text-sm font-bold text-gray-900">Link Resource to Application</h3>
            <p className="text-xs text-gray-500 mt-0.5">
              Add <span className="font-mono font-semibold text-equity-red">{resource.code}</span> as a shared dependency on an application.
            </p>
          </div>
          <button onClick={onClose} className="p-1.5 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100">
            <X size={16} />
          </button>
        </div>

        {/* Resource info pill */}
        <div className="flex items-center gap-2 px-3 py-2 bg-gray-50 rounded-xl border border-gray-100">
          <span className={`inline-flex items-center gap-1 text-xs px-2 py-0.5 rounded-full font-medium ${TYPE_COLOUR[resource.resourceType] ?? TYPE_COLOUR.OTHER}`}>
            {TYPE_ICON[resource.resourceType]}
            {resource.resourceType}
          </span>
          <span className="text-sm font-medium text-gray-700 flex-1">{resource.name}</span>
          {resource.host && <span className="text-xs text-gray-400 font-mono truncate max-w-[120px]">{resource.host}</span>}
        </div>

        {/* Already linked list */}
        {linked.length > 0 && (
          <div className="space-y-1">
            {linked.map(n => (
              <div key={n} className="flex items-center gap-2 text-xs text-green-700 bg-green-50 rounded-lg px-3 py-1.5">
                <CheckCircle2 size={12} className="shrink-0" />
                Linked to <span className="font-semibold">{n}</span>
              </div>
            ))}
          </div>
        )}

        {/* App selector */}
        <div className="flex gap-2">
          <select
            value={selectedAppId}
            onChange={e => setSelectedAppId(e.target.value)}
            className="input flex-1"
          >
            <option value="">— select an application —</option>
            {apps
              .filter(a => !linked.includes(a.name))
              .map(a => (
                <option key={a.id} value={a.id}>
                  {a.code} — {a.name}
                </option>
              ))}
          </select>
          <button
            onClick={handleLink}
            disabled={!selectedAppId || linking}
            className="btn-primary px-4 flex items-center gap-1.5 shrink-0 disabled:opacity-50"
          >
            {linking
              ? <span className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
              : <Link2 size={14} />}
            Link
          </button>
        </div>

        <div className="pt-1 border-t border-gray-100">
          <button onClick={onClose} className="btn-secondary w-full text-sm">
            {linked.length > 0 ? 'Done' : 'Cancel'}
          </button>
        </div>
      </div>
    </div>
  )
}

// ─── Register Resource Modal ───────────────────────────────────────────────────
function RegisterResourceModal({
  isOpen,
  onClose,
  onSuccess,
}: {
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}) {
  const [name, setName]             = useState('')
  const [code, setCode]             = useState('')
  const [codeEdited, setCodeEdited] = useState(false)
  const [resType, setResType]       = useState<DependencyType>('DATABASE')
  const [host, setHost]             = useState('')
  const [hoveredType, setHoveredType] = useState<DependencyType | null>(null)

  // Step 2 state — link the new resource to app(s)
  const [createdResource, setCreatedResource] = useState<{ code: string; name: string; type: DependencyType } | null>(null)
  const [alreadyExisted, setAlreadyExisted]   = useState(false) // true when 409 — resource was already in registry
  const [selectedAppId, setSelectedAppId]     = useState('')
  const [linking, setLinking]                 = useState(false)
  const [linked, setLinked]                   = useState<string[]>([]) // app names already linked

  const createRes = useCreateSharedResource()
  const { data: apps } = useApplications({ size: 200 })
  const { data: appHistory } = useApplicationHistory()
  const hasArchivedApps = (appHistory?.length ?? 0) > 0
  const qc = useQueryClient()

  // Auto-derive code
  const toCodeLocal = (n: string) => n.trim().toUpperCase().replace(/[^A-Z0-9]+/g, '_').replace(/^_+|_+$/g, '')
  const syncCode = (n: string) => { if (!codeEdited) setCode(toCodeLocal(n)) }

  const reset = () => {
    setName(''); setCode(''); setCodeEdited(false)
    setResType('DATABASE'); setHost('')
    setHoveredType(null); setCreatedResource(null)
    setAlreadyExisted(false); setSelectedAppId(''); setLinking(false); setLinked([])
  }

  const handleClose = () => { reset(); onClose() }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    try {
      const created = await createRes.mutateAsync({
        code: code.trim(),
        name: name.trim(),
        resourceType: resType,
        host: host.trim() || undefined,
      })
      // Advance to Step 2 — do NOT close the modal yet
      setCreatedResource({ code: created.code, name: created.name, type: resType })
    } catch (err: any) {
      if (err?.response?.status === 409) {
        // Resource already exists in registry — skip re-registration, go straight to Step 2
        setAlreadyExisted(true)
        setCreatedResource({ code: code.trim().toUpperCase(), name: name.trim(), type: resType })
      }
      // All other errors are handled by the global axios error interceptor (toast)
    }
  }

  const handleDone = () => {
    reset()
    onSuccess()
  }

  // Link the resource to the selected application as a shared dependency
  const handleLink = async () => {
    if (!selectedAppId || !createdResource) return
    setLinking(true)
    try {
      await axiosClient.post(`/applications/${selectedAppId}/dependencies`, {
        dependencyType: createdResource.type,
        isShared: true,
        resourceName: createdResource.name,
      })
      const appName = apps?.content.find(a => a.id === selectedAppId)?.name ?? selectedAppId
      setLinked(prev => [...prev, appName])
      setSelectedAppId('')
      // Refresh the shared-resources summary so the card appears immediately
      qc.invalidateQueries({ queryKey: ['dependencies', 'shared'] })
      qc.invalidateQueries({ queryKey: ['dependencies', 'app', selectedAppId] })
      qc.invalidateQueries({ queryKey: ['applications'] })
    } finally {
      setLinking(false)
    }
  }

  if (!isOpen) return null

  const hints      = TYPE_HINTS[resType] ?? TYPE_HINTS.OTHER
  const activeType = hoveredType
    ? DEP_TYPES.find(t => t.value === hoveredType)
    : DEP_TYPES.find(t => t.value === resType)

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm px-4"
      onClick={e => { if (e.target === e.currentTarget) handleClose() }}
    >
      <div className="bg-white rounded-2xl shadow-xl w-full max-w-lg">

        {createdResource ? (
          /* ── Step 2: Link to application(s) ────────────────────────────── */
          <div className="p-6 space-y-5">
            {/* Header */}
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <div className={`w-10 h-10 rounded-xl flex items-center justify-center shrink-0 ${alreadyExisted ? 'bg-amber-50' : 'bg-green-50'}`}>
                  <CheckCircle2 size={20} className={alreadyExisted ? 'text-amber-500' : 'text-green-500'} />
                </div>
                <div>
                  <h3 className="text-sm font-bold text-gray-900">
                    {alreadyExisted ? 'Resource already in registry' : 'Resource registered in catalog'}
                  </h3>
                  <p className="text-xs text-gray-500 mt-0.5">
                    <span className="font-mono font-semibold text-equity-red">{createdResource.code}</span>
                    {' '}— {createdResource.name}
                  </p>
                </div>
              </div>
              <button onClick={handleClose} className="p-1.5 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100">
                <X size={16} />
              </button>
            </div>

            {/* Explanation banner */}
            {alreadyExisted ? (
              <div className="bg-amber-50 border border-amber-200 rounded-xl p-3.5 space-y-1">
                <p className="text-xs font-semibold text-amber-800">Resource already in registry</p>
                <p className="text-xs text-amber-700 leading-relaxed">
                  <span className="font-mono font-semibold">{createdResource?.code}</span> already exists — no need to register again.
                  Select applications below to link them to this resource now.
                </p>
              </div>
            ) : (
              <div className="bg-blue-50 border border-blue-200 rounded-xl p-3.5 space-y-1">
                <p className="text-xs font-semibold text-blue-800">Step 2 of 2 — Link to application(s)</p>
                <p className="text-xs text-blue-700 leading-relaxed">
                  The resource is in the registry but won't appear on this page until at least one application
                  declares a dependency on it. Select applications below to link them now.
                </p>
              </div>
            )}

            {/* Already linked */}
            {linked.length > 0 && (
              <div className="space-y-1.5">
                <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide">Linked so far</p>
                {linked.map(n => (
                  <div key={n} className="flex items-center gap-2 text-xs text-green-700 bg-green-50 rounded-lg px-3 py-1.5">
                    <CheckCircle2 size={12} className="shrink-0" />
                    {n}
                  </div>
                ))}
              </div>
            )}

            {/* App selector */}
            <div className="space-y-2">
              <label className="label">Select application</label>
              {apps?.content.length === 0 ? (
                <div className="bg-amber-50 border border-amber-200 rounded-xl p-3.5 space-y-2">
                  <p className="text-xs font-semibold text-amber-800">No applications available to link</p>
                  <p className="text-xs text-amber-700 leading-relaxed">
                    A dependency links this resource to a specific application. You need an application first.
                  </p>
                  <div className="flex flex-col gap-1.5 pt-0.5">
                    <Link
                      to="/applications"
                      className="inline-flex items-center gap-1.5 text-xs px-3 py-1.5 rounded-lg bg-equity-red text-white font-semibold hover:bg-equity-red/90 w-fit"
                      onClick={handleClose}
                    >
                      <Plus size={11} /> Add Application
                    </Link>
                    {hasArchivedApps && (
                      <Link
                        to="/applications/history"
                        className="text-xs underline text-amber-800 font-medium"
                        onClick={handleClose}
                      >
                        Or restore an archived application →
                      </Link>
                    )}
                  </div>
                </div>
              ) : (
                <div className="flex gap-2">
                  <select
                    value={selectedAppId}
                    onChange={e => setSelectedAppId(e.target.value)}
                    className="input flex-1"
                  >
                    <option value="">— choose an application —</option>
                    {apps?.content
                      .filter(a => !linked.includes(a.name))
                      .map(a => (
                        <option key={a.id} value={a.id}>
                          {a.code} — {a.name}
                        </option>
                      ))}
                  </select>
                  <button
                    onClick={handleLink}
                    disabled={!selectedAppId || linking}
                    className="btn-primary px-4 flex items-center gap-1.5 shrink-0 disabled:opacity-50"
                  >
                    {linking
                      ? <span className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                      : <Plus size={14} />}
                    Link
                  </button>
                </div>
              )}
            </div>

            {/* Footer */}
            <div className="flex gap-2 pt-1 border-t border-gray-100">
              <button onClick={() => reset()} className="btn-secondary flex-1 text-sm">
                Register Another
              </button>
              <button onClick={handleDone} className="btn-primary flex-1 text-sm">
                {linked.length > 0 ? 'Done' : 'Skip for now'}
              </button>
            </div>
          </div>
        ) : (
          /* ── Form ───────────────────────────────────────────────────────── */
          <form onSubmit={handleSubmit}>
            {/* Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100">
              <div>
                <h3 className="text-base font-bold text-gray-900">Register Shared Resource</h3>
                <p className="text-xs text-gray-400 mt-0.5">
                  Add an infrastructure resource to the shared registry so applications can declare a dependency on it.
                </p>
              </div>
              <button type="button" onClick={handleClose} className="p-2 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100 transition-colors">
                <X size={16} />
              </button>
            </div>

            <div className="px-6 py-5 space-y-4">

              {/* Resource Type */}
              <div>
                <label className="label">
                  Type
                  <span className="ml-1 text-gray-400 font-normal text-[11px]">Hover a card for details</span>
                </label>
                <div className="grid grid-cols-4 gap-1.5">
                  {DEP_TYPES.map(t => {
                    const Icon     = t.icon
                    const selected = resType === t.value
                    return (
                      <button
                        key={t.value}
                        type="button"
                        onMouseEnter={() => setHoveredType(t.value)}
                        onMouseLeave={() => setHoveredType(null)}
                        onClick={() => { setResType(t.value); if (!codeEdited && !name) setCode('') }}
                        className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 text-center transition-all ${
                          selected
                            ? `border-current ${t.colour} shadow-sm`
                            : 'border-gray-100 hover:border-gray-200 text-gray-500 hover:bg-gray-50'
                        }`}
                      >
                        <Icon size={13} />
                        <span className="text-[10px] font-medium leading-tight">{t.label}</span>
                      </button>
                    )
                  })}
                </div>
                {activeType && (
                  <div className={`mt-2 flex items-start gap-2.5 p-3 rounded-xl border ${activeType.colour}`}>
                    <activeType.icon size={12} className="mt-0.5 shrink-0" />
                    <div>
                      <p className="text-[11px] font-semibold leading-none mb-1">{activeType.label}</p>
                      <p className="text-[11px] leading-relaxed opacity-90">{activeType.description}</p>
                    </div>
                  </div>
                )}
              </div>

              {/* Name */}
              <div>
                <label className="label">Name *</label>
                <input
                  type="text"
                  required
                  className="input"
                  placeholder={hints.name}
                  value={name}
                  onChange={e => { setName(e.target.value); syncCode(e.target.value) }}
                />
              </div>

              {/* Code */}
              <div>
                <label className="label">
                  Registry Code *
                  <span className="ml-1 text-gray-400 font-normal text-[11px]">auto-generated, uppercase</span>
                </label>
                <input
                  type="text"
                  required
                  className="input font-mono text-sm"
                  placeholder={hints.code}
                  value={code}
                  onChange={e => { setCode(e.target.value.toUpperCase().replace(/[^A-Z0-9_]/g, '')); setCodeEdited(true) }}
                />
              </div>

              {/* Host (optional) */}
              <div>
                <label className="label">
                  Hostname / Endpoint
                  <span className="text-gray-400 font-normal ml-1 text-[11px]">(optional)</span>
                </label>
                <input
                  type="text"
                  className="input"
                  placeholder={hints.host}
                  value={host}
                  onChange={e => setHost(e.target.value)}
                />
              </div>
            </div>

            {/* Footer */}
            <div className="flex gap-2 px-6 pb-5">
              <button type="button" onClick={handleClose} className="btn-secondary flex-1">
                Cancel
              </button>
              <button
                type="submit"
                disabled={!name.trim() || !code.trim() || createRes.isPending}
                className="btn-primary flex-1 flex items-center justify-center gap-2"
              >
                {createRes.isPending ? (
                  <span className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                ) : (
                  <Plus size={14} />
                )}
                Register Resource
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  )
}

// ─── Helpers ──────────────────────────────────────────────────────────────────
function StatCard({ label, value, sub, colour }: { label: string; value: number; sub: string; colour: string }) {
  const colours: Record<string, string> = {
    blue:   'text-blue-600 bg-blue-50',
    purple: 'text-purple-600 bg-purple-50',
    red:    'text-equity-red bg-equity-red/10',
  }
  return (
    <div className="card">
      <p className="text-xs text-gray-500 font-medium">{label}</p>
      <p className={`text-3xl font-bold mt-1 ${colours[colour]?.split(' ')[0]}`}>{value}</p>
      <p className="text-xs text-gray-400 mt-0.5">{sub}</p>
    </div>
  )
}

function Loading() {
  return (
    <div className="flex justify-center py-16">
      <div className="w-7 h-7 border-4 border-equity-red border-t-transparent rounded-full animate-spin" />
    </div>
  )
}

function EmptyState({ title, sub, onRegister }: { title: string; sub: string; onRegister?: () => void }) {
  return (
    <div className="card flex flex-col items-center py-14 text-center gap-3">
      <GitMerge size={36} className="text-gray-200" />
      <p className="font-medium text-gray-600">{title}</p>
      <p className="text-sm text-gray-400 max-w-sm">{sub}</p>
      {onRegister && (
        <button onClick={onRegister} className="btn-primary flex items-center gap-1.5 mt-1">
          <Plus size={14} /> Register First Resource
        </button>
      )}
    </div>
  )
}
