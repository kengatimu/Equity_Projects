import { useNavigate } from 'react-router-dom'
import { ArrowLeft, Archive } from 'lucide-react'
import { useSharedResourceHistory } from '../../hooks/useDependencies'
import { TYPE_ICON, TYPE_COLOUR } from './DependencyPage'

export default function ResourceHistoryPage() {
  const navigate = useNavigate()
  const { data: history, isLoading } = useSharedResourceHistory()

  return (
    <div className="space-y-5 max-w-7xl">
      {/* Header */}
      <div className="flex items-center gap-3">
        <button onClick={() => navigate(-1)} className="btn-secondary p-2">
          <ArrowLeft size={16} />
        </button>
        <div className="flex-1">
          <div className="flex items-center gap-2">
            <Archive size={18} className="text-equity-red" />
            <h1 className="text-2xl font-bold text-gray-900">Resource Archive</h1>
          </div>
          <p className="text-gray-500 text-sm mt-0.5">
            {history?.length ?? 0} archived resource{history?.length !== 1 ? 's' : ''} — permanently removed from the infrastructure registry.
          </p>
        </div>
      </div>

      <div className="card p-0 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-100">
                <th className="table-header">Type</th>
                <th className="table-header">Code</th>
                <th className="table-header">Name</th>
                <th className="table-header">Host / Endpoint</th>
                <th className="table-header">Environment</th>
                <th className="table-header">Archived By</th>
                <th className="table-header">Archived At</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {isLoading
                ? Array.from({ length: 5 }).map((_, i) => (
                    <tr key={i}>
                      {Array.from({ length: 7 }).map((_, j) => (
                        <td key={j} className="table-cell">
                          <div className="h-4 bg-gray-100 rounded animate-pulse" />
                        </td>
                      ))}
                    </tr>
                  ))
                : !history || history.length === 0
                ? (
                  <tr>
                    <td colSpan={7} className="table-cell text-center py-12 text-gray-400">
                      No resources have been archived yet.
                    </td>
                  </tr>
                )
                : history.map(res => (
                    <tr key={res.id} className="hover:bg-gray-50 transition-colors opacity-80 hover:opacity-100">
                      <td className="table-cell">
                        <span className={`inline-flex items-center gap-1 text-xs px-2 py-0.5 rounded-full font-medium ${TYPE_COLOUR[res.resourceType] ?? TYPE_COLOUR.OTHER}`}>
                          {TYPE_ICON[res.resourceType]}
                          {res.resourceType}
                        </span>
                      </td>
                      <td className="table-cell font-mono text-xs font-semibold text-gray-400">{res.code}</td>
                      <td className="table-cell text-sm font-medium text-gray-600">{res.name}</td>
                      <td className="table-cell text-xs text-gray-400">
                        {res.host ?? <span className="text-gray-300">—</span>}
                      </td>
                      <td className="table-cell">
                        <span className="text-xs px-2 py-0.5 rounded-full font-medium bg-gray-100 text-gray-500">
                          {res.environment}
                        </span>
                      </td>
                      <td className="table-cell text-xs text-gray-500">{res.archivedByEmail ?? '—'}</td>
                      <td className="table-cell text-xs text-gray-500">
                        {res.archivedAt
                          ? new Date(res.archivedAt).toLocaleString('en-GB', {
                              day: '2-digit', month: 'short', year: 'numeric',
                              hour: '2-digit', minute: '2-digit',
                            })
                          : '—'}
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
