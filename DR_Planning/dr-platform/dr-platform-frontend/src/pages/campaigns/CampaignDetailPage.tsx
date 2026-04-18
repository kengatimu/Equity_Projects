import { useState } from 'react'
import { useParams, useNavigate, Link } from 'react-router-dom'
import {
  useAddApplicationToCampaign, useApproveCampaign,
  useCampaign, useCampaignGateCheck, useCampaignTimeline, useOpenPreDr
} from '../../hooks/useCampaigns'
import { useCampaignConflicts, useResolveConflict, useScanConflicts } from '../../hooks/useDependencies'
import { useApplications } from '../../hooks/useApplications'
import StatusBadge from '../../components/common/StatusBadge'
import { AlertTriangle, ArrowLeft, Calendar, CheckCircle2, ChevronRight, GitMerge, Plus, RefreshCw, XCircle } from 'lucide-react'
import { format, parseISO } from 'date-fns'
import type { ConflictDto } from '../../types'

export default function CampaignDetailPage() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { data: campaign, isLoading } = useCampaign(id!)
  const { data: gate } = useCampaignGateCheck(id!)
  const { data: timeline } = useCampaignTimeline(id!)
  const { data: conflicts } = useCampaignConflicts(id!)
  const openPreDr = useOpenPreDr(id!)
  const approve = useApproveCampaign(id!)
  const addApp = useAddApplicationToCampaign(id!)
  const scanConflicts = useScanConflicts(id!)
  const { data: allApps } = useApplications({ size: 100 })
  const [showAddForm, setShowAddForm] = useState(false)
  const [addForm, setAddForm] = useState({ applicationId: '', drDate: '', warRoomLocation: '' })

  if (isLoading) {
    return <div className="flex items-center justify-center h-64"><div className="w-8 h-8 border-4 border-equity-red border-t-transparent rounded-full animate-spin" /></div>
  }
  if (!campaign) return <div className="card py-12 text-center text-gray-400">Campaign not found</div>

  const canOpenPreDr = campaign.status === 'DRAFT'
  const canApprove = campaign.status === 'PRE_DR_OPEN'
  const unresolvedCount = conflicts?.filter(c => !c.resolution).length ?? 0

  const handleAddApp = async (e: React.FormEvent) => {
    e.preventDefault()
    await addApp.mutateAsync({ ...addForm, applicationId: addForm.applicationId })
    setShowAddForm(false)
    setAddForm({ applicationId: '', drDate: '', warRoomLocation: '' })
  }

  return (
    <div className="max-w-6xl space-y-6">
      {/* Header */}
      <div className="flex items-start gap-3">
        <button onClick={() => navigate(-1)} className="btn-secondary p-2 mt-0.5">
          <ArrowLeft size={16} />
        </button>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-3 flex-wrap">
            <h1 className="text-2xl font-bold text-gray-900">{campaign.name}</h1>
            <StatusBadge status={campaign.status} size="md" />
            {unresolvedCount > 0 && (
              <span className="flex items-center gap-1 text-xs px-2 py-1 bg-amber-50 text-amber-700 rounded-full font-semibold">
                <AlertTriangle size={11} /> {unresolvedCount} conflict{unresolvedCount !== 1 ? 's' : ''}
              </span>
            )}
          </div>
          <p className="text-gray-500 text-sm mt-0.5">
            {campaign.quarter} {campaign.year} · {campaign.subsidiaryId}
            {campaign.plannedDrDate ? ` · DR: ${format(parseISO(campaign.plannedDrDate), 'dd MMM yyyy')}` : ''}
          </p>
        </div>
        <div className="flex gap-2 shrink-0">
          {canOpenPreDr && (
            <button onClick={() => openPreDr.mutate()} disabled={openPreDr.isPending} className="btn-secondary">
              Open Pre-DR
            </button>
          )}
          {canApprove && (
            <button onClick={() => approve.mutate()} disabled={approve.isPending} className="btn-primary">
              {approve.isPending ? 'Approving…' : 'Approve Campaign'}
            </button>
          )}
        </div>
      </div>

      <div className="grid lg:grid-cols-3 gap-6">
        {/* ── Applications ──────────────────────────────────────────────── */}
        <div className="lg:col-span-2 space-y-4">
          <div className="flex items-center justify-between">
            <h2 className="font-semibold text-gray-800">Applications ({campaign.applications?.length ?? 0})</h2>
            {(campaign.status === 'DRAFT' || campaign.status === 'PRE_DR_OPEN') && (
              <button onClick={() => setShowAddForm(v => !v)} className="btn-secondary text-xs py-1.5">
                <Plus size={14} /> Add Application
              </button>
            )}
          </div>

          {showAddForm && (
            <form onSubmit={handleAddApp} className="card space-y-3 border-equity-red/20">
              <div>
                <label className="label">Application</label>
                <select className="input" required value={addForm.applicationId}
                  onChange={e => setAddForm(f => ({ ...f, applicationId: e.target.value }))}>
                  <option value="">Select application…</option>
                  {allApps?.content.map(a => (
                    <option key={a.id} value={a.id}>{a.code} — {a.name}</option>
                  ))}
                </select>
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="label">DR Date (optional)</label>
                  <input type="date" className="input" value={addForm.drDate}
                    onChange={e => setAddForm(f => ({ ...f, drDate: e.target.value }))} />
                </div>
                <div>
                  <label className="label">War Room Location</label>
                  <input className="input" placeholder="e.g. Bridge 3, Floor 2"
                    value={addForm.warRoomLocation}
                    onChange={e => setAddForm(f => ({ ...f, warRoomLocation: e.target.value }))} />
                </div>
              </div>
              <div className="flex gap-2 justify-end">
                <button type="button" onClick={() => setShowAddForm(false)} className="btn-secondary text-xs">Cancel</button>
                <button type="submit" disabled={addApp.isPending} className="btn-primary text-xs">
                  {addApp.isPending ? 'Adding…' : 'Add'}
                </button>
              </div>
            </form>
          )}

          {(campaign.applications?.length ?? 0) === 0 ? (
            <div className="card py-8 text-center text-gray-400 text-sm">
              No applications added yet
            </div>
          ) : (
            <div className="space-y-2">
              {campaign.applications?.map(ca => (
                <div key={ca.id} className="card p-4 hover:shadow-md transition-shadow">
                  <div className="flex items-start justify-between mb-2">
                    <div>
                      <div className="flex items-center gap-2">
                        <span className="font-mono text-xs font-semibold text-equity-red">{ca.applicationCode}</span>
                        <span className="font-medium text-gray-800 text-sm">{ca.applicationName}</span>
                        {ca.applicationTier && <StatusBadge status={ca.applicationTier} />}
                      </div>
                      {ca.drDate && (
                        <p className="text-xs text-gray-400 mt-0.5">
                          DR: {format(parseISO(ca.drDate), 'dd MMM yyyy')}
                          {ca.warRoomLocation ? ` · ${ca.warRoomLocation}` : ''}
                        </p>
                      )}
                    </div>
                    <div className="flex items-center gap-2">
                      <StatusBadge status={ca.status} />
                      <Link
                        to={`/campaigns/${campaign.id}/applications/${ca.id}/checklist`}
                        className="p-1 text-gray-400 hover:text-equity-red transition-colors"
                        title="View checklist"
                      >
                        <ChevronRight size={16} />
                      </Link>
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-x-4 gap-y-1 mt-3">
                    {[
                      ['Runbook Due', ca.runbookDeadline],
                      ['Peer Review', ca.peerReviewDeadline],
                      ['ITSCM Approval', ca.itscmApprovalDeadline],
                      ['Checklist Due', ca.checklistDeadline],
                    ].map(([lbl, date]) => date ? (
                      <div key={lbl as string} className="flex justify-between text-xs">
                        <span className="text-gray-400">{lbl}</span>
                        <span className={`font-medium ${new Date(date as string) < new Date() ? 'text-red-600' : 'text-gray-700'}`}>
                          {format(parseISO(date as string), 'dd MMM')}
                        </span>
                      </div>
                    ) : null)}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* ── Right panel ───────────────────────────────────────────────── */}
        <div className="space-y-4">
          {/* Gate check */}
          {gate && (
            <div className={`card ${gate.passed ? 'border-green-200 bg-green-50/40' : 'border-amber-200 bg-amber-50/40'}`}>
              <div className="flex items-center gap-2 mb-3">
                {gate.passed
                  ? <CheckCircle2 size={16} className="text-green-600" />
                  : <AlertTriangle size={16} className="text-amber-600" />}
                <h3 className="text-sm font-semibold text-gray-800">
                  Approval Gate {gate.passed ? '— Ready' : '— Not Ready'}
                </h3>
              </div>
              {!gate.passed && (
                <ul className="space-y-1.5">
                  {gate.failureReasons.map((r, i) => (
                    <li key={i} className="flex items-start gap-1.5 text-xs text-amber-700">
                      <XCircle size={11} className="mt-0.5 shrink-0" /> {r}
                    </li>
                  ))}
                </ul>
              )}
            </div>
          )}

          {/* Conflicts panel */}
          <ConflictsPanel campaignId={id!} conflicts={conflicts ?? []} onScan={() => scanConflicts.mutate()} scanning={scanConflicts.isPending} />

          {/* Timeline */}
          {timeline && timeline.length > 0 && (
            <div className="card">
              <h3 className="text-sm font-semibold text-gray-800 mb-3 flex items-center gap-2">
                <Calendar size={14} className="text-equity-red" /> Timeline
              </h3>
              <div className="space-y-2">
                {timeline.slice(0, 10).map((ev, i) => (
                  <div key={i} className="flex items-start gap-2.5">
                    <div className={`w-1.5 h-1.5 rounded-full mt-1.5 shrink-0 ${ev.overdue ? 'bg-red-500' : 'bg-equity-red/40'}`} />
                    <div className="flex-1 min-w-0">
                      <p className={`text-xs font-medium ${ev.overdue ? 'text-red-600' : 'text-gray-700'}`}>
                        {ev.eventType.replace(/_/g, ' ')}
                      </p>
                      <p className="text-xs text-gray-400">
                        {ev.applicationCode} · {format(parseISO(ev.date), 'dd MMM yyyy')}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

// ─── Conflicts Panel ───────────────────────────────────────────────────────────
function ConflictsPanel({
  campaignId, conflicts, onScan, scanning
}: {
  campaignId: string
  conflicts: ConflictDto[]
  onScan: () => void
  scanning: boolean
}) {
  const resolve = useResolveConflict(campaignId)
  const [resolving, setResolving] = useState<string | null>(null)
  const [form, setForm] = useState({ resolution: 'ACCEPTED', reason: '' })

  const unresolved = conflicts.filter(c => !c.resolution)
  const resolved = conflicts.filter(c => !!c.resolution)

  const CONFLICT_COLOUR: Record<string, string> = {
    SHARED_DEPENDENCY_CONFLICT: 'text-amber-700 bg-amber-50',
    SEQUENCING_ADVISORY:        'text-blue-700 bg-blue-50',
    INFORMATIONAL:              'text-gray-600 bg-gray-100',
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center gap-2">
          <GitMerge size={14} className="text-equity-red" />
          <h3 className="text-sm font-semibold text-gray-800">
            Conflicts
            {unresolved.length > 0 && (
              <span className="ml-2 text-xs px-1.5 py-0.5 bg-amber-100 text-amber-700 rounded-full font-bold">
                {unresolved.length}
              </span>
            )}
          </h3>
        </div>
        <button
          onClick={onScan}
          disabled={scanning}
          className="text-xs text-gray-400 hover:text-equity-red flex items-center gap-1 transition-colors"
          title="Scan for new conflicts"
        >
          <RefreshCw size={12} className={scanning ? 'animate-spin' : ''} />
          {scanning ? 'Scanning…' : 'Scan'}
        </button>
      </div>

      {conflicts.length === 0 ? (
        <div className="text-center py-4">
          <p className="text-xs text-gray-400">No conflicts detected.</p>
          <p className="text-xs text-gray-300 mt-0.5">Click Scan after adding applications.</p>
        </div>
      ) : (
        <div className="space-y-3">
          {/* Unresolved first */}
          {unresolved.map(c => (
            <div key={c.id} className="space-y-2">
              <div className="p-2.5 rounded-lg bg-amber-50 border border-amber-100">
                <div className="flex items-start justify-between gap-2">
                  <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-bold ${CONFLICT_COLOUR[c.conflictType] ?? CONFLICT_COLOUR.INFORMATIONAL}`}>
                    {c.conflictType.replace(/_/g, ' ')}
                  </span>
                  <button
                    onClick={() => setResolving(resolving === c.id ? null : c.id)}
                    className="text-xs text-equity-red hover:underline shrink-0"
                  >
                    Resolve
                  </button>
                </div>
                <p className="text-xs text-gray-700 mt-1.5 leading-relaxed">{c.description}</p>
                {c.recommendation && (
                  <p className="text-xs text-gray-500 mt-1 italic">{c.recommendation}</p>
                )}
              </div>

              {/* Inline resolve form */}
              {resolving === c.id && (
                <div className="p-3 bg-gray-50 rounded-lg border border-gray-100 space-y-2">
                  <div>
                    <label className="label text-[11px]">Resolution</label>
                    <select
                      className="input text-xs"
                      value={form.resolution}
                      onChange={e => setForm(f => ({ ...f, resolution: e.target.value }))}
                    >
                      <option value="ACCEPTED">Accepted — proceed with awareness</option>
                      <option value="MITIGATED">Mitigated — controls applied</option>
                      <option value="DEFERRED">Deferred — move app to next campaign</option>
                      <option value="REJECTED">Rejected — will not proceed</option>
                    </select>
                  </div>
                  <div>
                    <label className="label text-[11px]">Reason / Notes *</label>
                    <input
                      className="input text-xs"
                      placeholder="Describe the resolution approach…"
                      value={form.reason}
                      onChange={e => setForm(f => ({ ...f, reason: e.target.value }))}
                    />
                  </div>
                  <div className="flex gap-2 justify-end">
                    <button type="button" onClick={() => setResolving(null)} className="btn-secondary text-xs py-1">Cancel</button>
                    <button
                      type="button"
                      disabled={!form.reason.trim() || resolve.isPending}
                      onClick={async () => {
                        await resolve.mutateAsync({ conflictId: c.id, body: { resolution: form.resolution, reason: form.reason } })
                        setResolving(null)
                        setForm({ resolution: 'ACCEPTED', reason: '' })
                      }}
                      className="btn-primary text-xs py-1"
                    >
                      {resolve.isPending ? 'Saving…' : 'Save Resolution'}
                    </button>
                  </div>
                </div>
              )}
            </div>
          ))}

          {/* Resolved */}
          {resolved.length > 0 && (
            <div className="border-t border-gray-100 pt-2 space-y-1.5">
              <p className="text-[11px] text-gray-400 uppercase tracking-wide font-semibold">Resolved ({resolved.length})</p>
              {resolved.map(c => (
                <div key={c.id} className="flex items-center gap-2 text-xs text-gray-500">
                  <CheckCircle2 size={12} className="text-green-500 shrink-0" />
                  <span className="truncate">{c.conflictType.replace(/_/g, ' ')}</span>
                  <span className="text-gray-300 shrink-0">·</span>
                  <span className="font-medium text-gray-600 shrink-0">{c.resolution}</span>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
