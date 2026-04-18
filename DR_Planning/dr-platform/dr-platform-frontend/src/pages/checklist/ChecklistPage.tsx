import { useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import {
  useBlockItem, useChecklist, useChecklistSummary,
  useSubmitSignOff, useUpdateChecklistItem
} from '../../hooks/useChecklist'
import StatusBadge from '../../components/common/StatusBadge'
import ProgressBar from '../../components/common/ProgressBar'
import { AlertTriangle, ArrowLeft, CheckCircle2, Lock, SendHorizonal } from 'lucide-react'
import type { ChecklistItemDto, ChecklistItemStatus } from '../../types'
import clsx from 'clsx'

const STATUS_OPTIONS: ChecklistItemStatus[] = ['PENDING', 'IN_PROGRESS', 'DONE', 'VERIFIED']

export default function ChecklistPage() {
  const { campaignId, caId } = useParams<{ campaignId: string; caId: string }>()
  const navigate = useNavigate()
  const { data: items, isLoading } = useChecklist(caId!)
  const { data: summary } = useChecklistSummary(caId!)
  const updateItem = useUpdateChecklistItem(caId!)
  const blockItem = useBlockItem(caId!)
  const submitSignOff = useSubmitSignOff(caId!)

  const [blockingId, setBlockingId] = useState<string | null>(null)
  const [blockerDesc, setBlockerDesc] = useState('')
  const [blockerSeverity, setBlockerSeverity] = useState('MEDIUM')

  const handleStatusChange = (item: ChecklistItemDto, status: ChecklistItemStatus) => {
    updateItem.mutate({ itemId: item.id, status })
  }

  const handleRaiseBlocker = async (itemId: string) => {
    await blockItem.mutateAsync({ itemId, description: blockerDesc, severity: blockerSeverity })
    setBlockingId(null)
    setBlockerDesc('')
  }

  return (
    <div className="max-w-4xl space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button onClick={() => navigate(`/campaigns/${campaignId}`)} className="btn-secondary p-2">
          <ArrowLeft size={16} />
        </button>
        <div className="flex-1">
          <h1 className="text-xl font-bold text-gray-900">Pre-DR Checklist</h1>
          <p className="text-gray-500 text-sm">Complete all items before submitting sign-off</p>
        </div>
        <button
          onClick={() => submitSignOff.mutate()}
          disabled={submitSignOff.isPending || summary?.signedOff}
          className={clsx(
            'btn-primary',
            summary?.signedOff ? 'opacity-60 cursor-not-allowed' : ''
          )}
        >
          {summary?.signedOff
            ? <><CheckCircle2 size={16} /> Signed Off</>
            : <><SendHorizonal size={16} /> Submit Sign-Off</>}
        </button>
      </div>

      {/* Progress summary */}
      {summary && (
        <div className="card">
          <div className="flex items-center justify-between mb-3">
            <div>
              <p className="text-sm font-semibold text-gray-800">Readiness</p>
              <p className="text-xs text-gray-400">{summary.done} / {summary.total} items completed</p>
            </div>
            <div className="text-right">
              {summary.blocked > 0 && (
                <p className="text-xs text-red-600 flex items-center gap-1 justify-end">
                  <AlertTriangle size={11} /> {summary.blocked} blocked
                </p>
              )}
              {summary.signedOff && (
                <p className="text-xs text-green-600 flex items-center gap-1 justify-end">
                  <CheckCircle2 size={11} /> Sign-off submitted
                </p>
              )}
            </div>
          </div>
          <ProgressBar value={summary.readinessPercent} size="md" />
        </div>
      )}

      {/* Checklist items */}
      {isLoading ? (
        <div className="space-y-2">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="card h-14 animate-pulse bg-gray-100" />
          ))}
        </div>
      ) : (
        <div className="space-y-1.5">
          {items?.map((item, idx) => (
            <div
              key={item.id}
              className={clsx(
                'card p-4 transition-all',
                item.status === 'DONE' || item.status === 'VERIFIED' ? 'bg-green-50/50 border-green-100' :
                item.status === 'BLOCKED' ? 'bg-red-50/50 border-red-100' :
                item.status === 'CARRIED_FORWARD' ? 'bg-amber-50/40 border-amber-100' :
                'border-gray-100'
              )}
            >
              <div className="flex items-start gap-3">
                <span className="text-xs text-gray-300 font-mono pt-0.5 w-5 shrink-0">{idx + 1}</span>

                <div className="flex-1 min-w-0">
                  <p className={clsx(
                    'text-sm font-medium',
                    item.status === 'DONE' || item.status === 'VERIFIED' ? 'text-gray-400 line-through' : 'text-gray-800'
                  )}>
                    {item.title}
                  </p>
                  {item.notes && <p className="text-xs text-gray-400 mt-0.5">{item.notes}</p>}
                  {item.status === 'CARRIED_FORWARD' && (
                    <p className="text-xs text-amber-600 mt-1">Carried forward · {item.carriedForwardAgeDays} days ago</p>
                  )}
                </div>

                <div className="flex items-center gap-2 shrink-0">
                  {item.status !== 'BLOCKED' && item.status !== 'VERIFIED' && !summary?.signedOff && (
                    <select
                      value={item.status}
                      onChange={e => handleStatusChange(item, e.target.value as ChecklistItemStatus)}
                      className="text-xs border border-gray-200 rounded-lg px-2 py-1 focus:outline-none focus:ring-1 focus:ring-equity-red/40 bg-white"
                    >
                      {STATUS_OPTIONS.map(s => <option key={s} value={s}>{s.replace('_', ' ')}</option>)}
                    </select>
                  )}

                  <StatusBadge status={item.status} />

                  {item.status !== 'BLOCKED' && item.status !== 'DONE' && item.status !== 'VERIFIED' && !summary?.signedOff && (
                    <button
                      onClick={() => setBlockingId(blockingId === item.id ? null : item.id)}
                      className="p-1.5 text-gray-300 hover:text-red-500 transition-colors rounded"
                      title="Raise blocker"
                    >
                      <Lock size={13} />
                    </button>
                  )}
                </div>
              </div>

              {/* Raise blocker inline form */}
              {blockingId === item.id && (
                <div className="mt-3 ml-8 p-3 bg-red-50 rounded-lg border border-red-100 space-y-2">
                  <p className="text-xs font-semibold text-red-700">Raise a blocker</p>
                  <textarea
                    rows={2}
                    value={blockerDesc}
                    onChange={e => setBlockerDesc(e.target.value)}
                    placeholder="Describe the blocker…"
                    className="w-full text-xs border border-red-200 rounded px-2 py-1.5 focus:outline-none focus:ring-1 focus:ring-red-300"
                  />
                  <div className="flex items-center gap-2">
                    <select
                      value={blockerSeverity}
                      onChange={e => setBlockerSeverity(e.target.value)}
                      className="text-xs border border-red-200 rounded px-2 py-1 bg-white"
                    >
                      {['LOW','MEDIUM','HIGH','CRITICAL'].map(s => <option key={s}>{s}</option>)}
                    </select>
                    <div className="flex-1" />
                    <button onClick={() => setBlockingId(null)} className="text-xs text-gray-400 hover:text-gray-600">Cancel</button>
                    <button
                      onClick={() => handleRaiseBlocker(item.id)}
                      disabled={!blockerDesc.trim() || blockItem.isPending}
                      className="btn-danger text-xs py-1"
                    >
                      Raise Blocker
                    </button>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
