import { useNavigate } from 'react-router-dom'
import { useApplicationHistory, useRestoreApplication } from '../../hooks/useApplications'
import StatusBadge from '../../components/common/StatusBadge'
import { ArrowLeft, Archive, RotateCcw } from 'lucide-react'
import { useState } from 'react'

export default function ApplicationHistoryPage() {
  const navigate  = useNavigate()
  const { data: history, isLoading } = useApplicationHistory()
  const restore = useRestoreApplication()
  const [confirmId, setConfirmId] = useState<string | null>(null)

  return (
    <div className="space-y-5 max-w-7xl">
      <div className="flex items-center gap-3">
        <button onClick={() => navigate(-1)} className="btn-secondary p-2">
          <ArrowLeft size={16} />
        </button>
        <div className="flex-1">
          <div className="flex items-center gap-2">
            <Archive size={18} className="text-equity-red" />
            <h1 className="text-2xl font-bold text-gray-900">Application Archive</h1>
          </div>
          <p className="text-gray-500 text-sm mt-0.5">
            {history?.length ?? 0} archived application{history?.length !== 1 ? 's' : ''} — restore any to bring it back to the live registry.
          </p>
        </div>
      </div>

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
                <th className="table-header">Archived By</th>
                <th className="table-header">Archived At</th>
                <th className="table-header w-36">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {isLoading
                ? Array.from({ length: 6 }).map((_, i) => (
                    <tr key={i}>
                      {Array.from({ length: 8 }).map((_, j) => (
                        <td key={j} className="table-cell">
                          <div className="h-4 bg-gray-100 rounded animate-pulse" />
                        </td>
                      ))}
                    </tr>
                  ))
                : !history || history.length === 0
                ? (
                  <tr>
                    <td colSpan={8} className="table-cell text-center py-10 text-gray-400">
                      No archived applications yet.
                    </td>
                  </tr>
                )
                : history.map(h => (
                    <tr key={h.id} className="hover:bg-gray-50 transition-colors">
                      <td className="table-cell font-mono text-xs font-medium text-equity-red">{h.code}</td>
                      <td className="table-cell font-medium text-gray-800">{h.name}</td>
                      <td className="table-cell">
                        <StatusBadge status={h.tier} />
                      </td>
                      <td className="table-cell text-gray-500">{h.subsidiaryId}</td>
                      <td className="table-cell">
                        <span className={`text-xs font-medium ${h.hasDr ? 'text-green-600' : 'text-gray-400'}`}>
                          {h.hasDr ? 'Yes' : 'No'}
                        </span>
                      </td>
                      <td className="table-cell text-gray-500 text-xs">
                        {h.archivedByEmail ?? '—'}
                      </td>
                      <td className="table-cell text-gray-500 text-xs">
                        {h.archivedAt
                          ? new Date(h.archivedAt).toLocaleString('en-GB', {
                              day: '2-digit', month: 'short', year: 'numeric',
                              hour: '2-digit', minute: '2-digit',
                            })
                          : '—'}
                      </td>
                      <td className="table-cell">
                        {confirmId === h.id ? (
                          <div className="flex items-center gap-1">
                            <span className="text-[10px] text-gray-600 font-medium">Restore?</span>
                            <button
                              onClick={() => restore.mutate(h.id, { onSuccess: () => setConfirmId(null) })}
                              disabled={restore.isPending}
                              className="text-[10px] px-2 py-0.5 rounded bg-green-600 text-white font-semibold hover:bg-green-700 disabled:opacity-50"
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
                            onClick={() => setConfirmId(h.id)}
                            className="inline-flex items-center gap-1 text-xs px-2.5 py-1 rounded-lg border border-green-200 text-green-700 hover:bg-green-50 font-medium transition-colors"
                          >
                            <RotateCcw size={11} /> Restore
                          </button>
                        )}
                      </td>
                    </tr>
                  ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
