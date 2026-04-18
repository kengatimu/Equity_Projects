import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useApplications, useArchiveApplication, useDeactivateApplication, useExportApplications } from '../../hooks/useApplications'
import StatusBadge from '../../components/common/StatusBadge'
import ApplicationFormModal from '../../components/applications/ApplicationFormModal'
import { Archive, Download, Plus, PowerOff, Search, Upload } from 'lucide-react'
import type { ApplicationDto } from '../../types'

function appCompleteness(app: ApplicationDto): number {
  const checks = [
    !!(app.techOwnerName  ?? '').trim(),
    !!(app.techOwnerEmail ?? '').trim(),
    !!(app.businessOwner  ?? '').trim(),
    !!(app.businessOwnerEmail ?? '').trim(),
    !app.hasDr || !!(app.drCapability ?? '').trim(),
    !app.hasDr || !!(app.drEndpoint   ?? '').trim(),
    !!(app.dcEndpoint ?? '').trim(),
  ]
  return Math.round(checks.filter(Boolean).length / checks.length * 100)
}

// Per-row confirmation state — only needed when the user is confirming a destructive action
type RowMode = 'confirmDeactivate' | 'confirmArchive'
type RowState = { id: string; mode: RowMode } | null

export default function ApplicationListPage() {
  const navigate = useNavigate()
  const [search, setSearch]           = useState('')
  const [tier, setTier]               = useState('')
  const [subsidiaryId, setSubsidiaryId] = useState('')
  const [page, setPage]               = useState(0)

  const [modalOpen, setModalOpen]     = useState(false)
  const [editingApp, setEditingApp]   = useState<ApplicationDto | undefined>(undefined)
  // Single state drives all per-row action UI — avoids multiple parallel confirms
  const [rowState, setRowState]       = useState<RowState>(null)

  const { mutate: doExport,     isPending: isExporting   } = useExportApplications()
  const { mutate: doArchive,    isPending: isArchiving    } = useArchiveApplication()
  const { mutate: doDeactivate, isPending: isDeactivating } = useDeactivateApplication()

  const { data, isLoading } = useApplications({
    name: search || undefined,
    tier: tier || undefined,
    subsidiaryId: subsidiaryId || undefined,
    page,
    size: 20,
  })

  function openCreate() { setEditingApp(undefined); setModalOpen(true) }
  function openEdit(app: ApplicationDto) { setEditingApp(app); setModalOpen(true) }
  function closeModal() { setModalOpen(false); setEditingApp(undefined) }

  return (
    <div className="space-y-5 max-w-7xl">
      {/* ── Page header ─────────────────────────────────────────────────── */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Application Registry</h1>
          <p className="text-gray-500 text-sm mt-0.5">{data?.totalElements ?? 0} applications registered</p>
        </div>
        <div className="flex gap-2">
          <button onClick={() => navigate('/applications/history')} className="btn-secondary">
            <Archive size={16} /> History
          </button>
          <button onClick={() => doExport()} disabled={isExporting} className="btn-secondary">
            <Download size={16} /> {isExporting ? 'Exporting…' : 'Export Excel'}
          </button>
          <button onClick={() => navigate('/applications/import')} className="btn-secondary">
            <Upload size={16} /> Import Excel
          </button>
          <button className="btn-primary" onClick={openCreate}>
            <Plus size={16} /> Add Application
          </button>
        </div>
      </div>

      {/* ── Filters ─────────────────────────────────────────────────────── */}
      <div className="card flex gap-3 flex-wrap">
        <div className="relative flex-1 min-w-52">
          <Search size={15} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="Search by name…"
            value={search}
            onChange={e => { setSearch(e.target.value); setPage(0) }}
            className="input pl-9"
          />
        </div>
        <select value={tier} onChange={e => { setTier(e.target.value); setPage(0) }} className="input w-36">
          <option value="">All tiers</option>
          <option value="T1">T1 — Critical</option>
          <option value="T2">T2 — Important</option>
          <option value="T3">T3 — Standard</option>
        </select>
        <select value={subsidiaryId} onChange={e => { setSubsidiaryId(e.target.value); setPage(0) }} className="input w-44">
          <option value="">All subsidiaries</option>
          <option value="KE">Kenya (KE)</option>
          <option value="UG">Uganda (UG)</option>
          <option value="TZ">Tanzania (TZ)</option>
          <option value="RW">Rwanda (RW)</option>
          <option value="DRC">DRC (DRC)</option>
          <option value="SS">South Sudan (SS)</option>
          <option value="GROUP">Group / Shared</option>
        </select>
      </div>

      {/* ── Table ───────────────────────────────────────────────────────── */}
      <div className="card p-0 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-100">
                <th className="table-header">Code</th>
                <th className="table-header">Name</th>
                <th className="table-header">Tier</th>
                <th className="table-header">Subsidiary</th>
                <th className="table-header">DR Capable</th>
                <th className="table-header">Profile</th>
                <th className="table-header">Status</th>
                {/* Actions column — wider to accommodate expanded states */}
                <th className="table-header w-64"></th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {isLoading
                ? Array.from({ length: 8 }).map((_, i) => (
                    <tr key={i}>
                      {Array.from({ length: 8 }).map((_, j) => (
                        <td key={j} className="table-cell">
                          <div className="h-4 bg-gray-100 rounded animate-pulse" />
                        </td>
                      ))}
                    </tr>
                  ))
                : data?.content.map(app => {
                    const mode = rowState?.id === app.id ? rowState.mode : null
                    return (
                      <tr key={app.id} className="hover:bg-gray-50 transition-colors">
                        <td className="table-cell font-mono text-xs font-medium text-equity-red">{app.code}</td>
                        <td className="table-cell font-medium text-gray-800">{app.name}</td>
                        <td className="table-cell"><StatusBadge status={app.tier} /></td>
                        <td className="table-cell text-gray-500">{app.subsidiaryId}</td>
                        <td className="table-cell">
                          <span className={`text-xs font-medium ${app.hasDr ? 'text-green-600' : 'text-gray-400'}`}>
                            {app.hasDr ? 'Yes' : 'No'}
                          </span>
                        </td>
                        <td className="table-cell">
                          {(() => {
                            const pct = appCompleteness(app)
                            return (
                              <div className="flex items-center gap-1.5">
                                <div className="w-12 h-1 bg-gray-100 rounded-full overflow-hidden">
                                  <div
                                    className={`h-full rounded-full ${pct === 100 ? 'bg-green-500' : pct >= 75 ? 'bg-amber-400' : 'bg-equity-red'}`}
                                    style={{ width: `${pct}%` }}
                                  />
                                </div>
                                <span className={`text-[10px] font-semibold ${pct === 100 ? 'text-green-600' : pct >= 75 ? 'text-amber-500' : 'text-equity-red'}`}>
                                  {pct}%
                                </span>
                              </div>
                            )
                          })()}
                        </td>
                        <td className="table-cell">
                          <StatusBadge status={app.isActive ? 'APPROVED' : 'CANCELLED'} label={app.isActive ? 'Active' : 'Inactive'} />
                        </td>

                        {/* ── Actions column ──────────────────────────────────────── */}
                        <td className="table-cell">

                          {/* ── Confirm archive ── */}
                          {mode === 'confirmArchive' ? (
                            <div className="flex items-center gap-1.5">
                              <span className="text-[10px] text-equity-red font-semibold whitespace-nowrap">Archive app?</span>
                              <button
                                onClick={() => doArchive(app.id, { onSuccess: () => setRowState(null) })}
                                disabled={isArchiving}
                                className="text-[11px] px-2.5 py-1 rounded-md bg-equity-red text-white font-semibold hover:bg-equity-red/90 disabled:opacity-50"
                              >
                                Confirm
                              </button>
                              <button
                                onClick={() => setRowState(null)}
                                className="text-[11px] px-2.5 py-1 rounded-md border border-gray-200 text-gray-600 font-medium hover:bg-gray-50"
                              >
                                Cancel
                              </button>
                            </div>

                          /* ── Confirm deactivate ── */
                          ) : mode === 'confirmDeactivate' ? (
                            <div className="flex items-center gap-1.5">
                              <span className="text-[10px] text-amber-600 font-semibold whitespace-nowrap">Deactivate?</span>
                              <button
                                onClick={() => doDeactivate(app.id, { onSuccess: () => setRowState(null) })}
                                disabled={isDeactivating}
                                className="text-[11px] px-2.5 py-1 rounded-md bg-amber-500 text-white font-semibold hover:bg-amber-600 disabled:opacity-50"
                              >
                                Confirm
                              </button>
                              <button
                                onClick={() => setRowState(null)}
                                className="text-[11px] px-2.5 py-1 rounded-md border border-gray-200 text-gray-600 font-medium hover:bg-gray-50"
                              >
                                Cancel
                              </button>
                            </div>

                          /* ── Default — primary actions always visible,
                                destructive actions revealed on row hover ── */
                          ) : (
                            <div className="flex items-center gap-1.5">

                              {/* Always visible — primary actions */}
                              <Link
                                to={`/applications/${app.id}`}
                                className="text-[11px] px-2.5 py-1 rounded-lg bg-equity-red text-white font-semibold hover:bg-equity-red/90 transition-colors"
                              >
                                View
                              </Link>
                              <button
                                onClick={() => openEdit(app)}
                                className="text-[11px] px-2.5 py-1 rounded-lg border border-gray-300 text-gray-600 font-semibold hover:bg-gray-50 transition-colors"
                              >
                                Edit
                              </button>

                              {/* Pipe separator + destructive actions — always visible */}
                              <div className="flex items-center gap-1">
                                <div className="w-px h-4 bg-gray-200 mx-0.5" />
                                <button
                                  onClick={() => setRowState({ id: app.id, mode: 'confirmDeactivate' })}
                                  disabled={!app.isActive}
                                  title={app.isActive ? 'Deactivate application' : 'Already inactive'}
                                  className="text-[11px] px-2 py-1 rounded-md border border-amber-200 text-amber-600 hover:bg-amber-50 flex items-center gap-1 font-semibold disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                                >
                                  <PowerOff size={11} /> Deactivate
                                </button>
                                <button
                                  onClick={() => setRowState({ id: app.id, mode: 'confirmArchive' })}
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

        {/* ── Pagination ──────────────────────────────────────────────── */}
        {data && data.totalPages > 1 && (
          <div className="flex items-center justify-between px-4 py-3 border-t border-gray-100">
            <p className="text-sm text-gray-500">
              Showing {page * 20 + 1}–{Math.min((page + 1) * 20, data.totalElements)} of {data.totalElements}
            </p>
            <div className="flex gap-2">
              <button
                disabled={data.first}
                onClick={() => setPage(p => p - 1)}
                className="btn-secondary py-1 px-3 text-xs disabled:opacity-40"
              >
                Previous
              </button>
              <button
                disabled={data.last}
                onClick={() => setPage(p => p + 1)}
                className="btn-secondary py-1 px-3 text-xs disabled:opacity-40"
              >
                Next
              </button>
            </div>
          </div>
        )}
      </div>

      <ApplicationFormModal isOpen={modalOpen} onClose={closeModal} app={editingApp} />
    </div>
  )
}
