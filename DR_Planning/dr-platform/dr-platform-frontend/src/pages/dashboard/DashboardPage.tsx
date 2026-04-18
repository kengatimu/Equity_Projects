import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import axiosClient from '../../api/axiosClient'
import type { ApiResponse, DashboardDto } from '../../types'
import ProgressBar from '../../components/common/ProgressBar'
import StatusBadge from '../../components/common/StatusBadge'
import { AlertTriangle, Calendar, CheckCircle2, ShieldAlert, TrendingUp } from 'lucide-react'
import { format, parseISO } from 'date-fns'

function useDashboard() {
  return useQuery({
    queryKey: ['dashboard'],
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<DashboardDto>>('/dashboard')
      return data.data
    },
  })
}

export default function DashboardPage() {
  const { user } = useAuth()
  const { data, isLoading } = useDashboard()

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-8 h-8 border-4 border-equity-red border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  return (
    <div className="space-y-6 max-w-7xl">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold text-gray-900">
          Welcome back, {user?.displayName?.split(' ')[0]}
        </h1>
        <p className="text-gray-500 mt-0.5">DR Management Platform · {format(new Date(), 'EEEE, dd MMMM yyyy')}</p>
      </div>

      {/* KPI row */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <KpiCard
          label="Active Campaigns"
          value={data?.activeCampaignCount ?? 0}
          icon={<ShieldAlert size={20} className="text-equity-red" />}
          color="bg-equity-red/10"
        />
        <KpiCard
          label="Upcoming DR Events"
          value={data?.upcomingEvents?.length ?? 0}
          icon={<Calendar size={20} className="text-blue-600" />}
          color="bg-blue-50"
        />
        <KpiCard
          label="Open Blockers"
          value={data?.blockerSummary?.openBlockers ?? 0}
          icon={<AlertTriangle size={20} className="text-amber-600" />}
          color="bg-amber-50"
          danger={(data?.blockerSummary?.openBlockers ?? 0) > 0}
        />
        <KpiCard
          label="Unresolved Conflicts"
          value={data?.unresolvedConflicts ?? 0}
          icon={<TrendingUp size={20} className="text-purple-600" />}
          color="bg-purple-50"
          danger={(data?.unresolvedConflicts ?? 0) > 0}
        />
      </div>

      <div className="grid lg:grid-cols-2 gap-6">
        {/* Active campaigns */}
        <div className="card">
          <h2 className="text-base font-semibold text-gray-800 mb-4">Active Campaigns</h2>
          {(data?.activeCampaigns?.length ?? 0) === 0 ? (
            <EmptyState message="No active campaigns" />
          ) : (
            <div className="space-y-4">
              {data?.activeCampaigns?.map(c => (
                <Link
                  key={c.campaignId}
                  to={`/campaigns/${c.campaignId}`}
                  className="block p-3 rounded-lg border border-gray-100 hover:border-equity-red/30 hover:bg-equity-red/5 transition-colors"
                >
                  <div className="flex items-start justify-between mb-2">
                    <div>
                      <p className="font-medium text-gray-800 text-sm">{c.campaignName}</p>
                      <p className="text-xs text-gray-400 mt-0.5">
                        {c.plannedDrDate ? format(parseISO(c.plannedDrDate), 'dd MMM yyyy') : 'No date set'}
                      </p>
                    </div>
                    <StatusBadge status={c.status} />
                  </div>
                  <ProgressBar value={c.readinessPercent} label={`${c.completedApps}/${c.totalApps} apps`} />
                  {c.unresolvedConflicts > 0 && (
                    <p className="mt-2 text-xs text-amber-600 flex items-center gap-1">
                      <AlertTriangle size={11} />
                      {c.unresolvedConflicts} unresolved conflict{c.unresolvedConflicts > 1 ? 's' : ''}
                    </p>
                  )}
                </Link>
              ))}
            </div>
          )}
        </div>

        {/* Upcoming DR events */}
        <div className="card">
          <h2 className="text-base font-semibold text-gray-800 mb-4">Upcoming DR Events (30 days)</h2>
          {(data?.upcomingEvents?.length ?? 0) === 0 ? (
            <EmptyState message="No upcoming DR events" />
          ) : (
            <div className="space-y-2">
              {data?.upcomingEvents?.map(ev => (
                <div
                  key={ev.campaignApplicationId}
                  className="flex items-center gap-3 px-3 py-2.5 rounded-lg border border-gray-100 hover:bg-gray-50 transition-colors"
                >
                  <div className="w-10 h-10 rounded-lg bg-equity-red/10 flex items-center justify-center shrink-0">
                    <Calendar size={16} className="text-equity-red" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-gray-800 truncate">
                      {ev.applicationCode} — {ev.applicationName}
                    </p>
                    <p className="text-xs text-gray-400">
                      {format(parseISO(ev.drDate), 'EEE dd MMM yyyy')}
                      {ev.warRoomLocation ? ` · ${ev.warRoomLocation}` : ''}
                    </p>
                  </div>
                  <StatusBadge status={ev.status} />
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Runbook status */}
      <div className="card">
        <h2 className="text-base font-semibold text-gray-800 mb-4">Runbook Readiness</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          <RunbookStat label="Total Apps" value={data?.runbookStatusSummary?.totalApps ?? 0} color="text-gray-700" />
          <RunbookStat label="Approved" value={data?.runbookStatusSummary?.runbookApproved ?? 0} color="text-green-600" icon={<CheckCircle2 size={14} />} />
          <RunbookStat label="Pending Review" value={data?.runbookStatusSummary?.pendingReview ?? 0} color="text-blue-600" />
          <RunbookStat label="Overdue" value={data?.runbookStatusSummary?.overdue ?? 0} color="text-red-600" icon={<AlertTriangle size={14} />} />
        </div>
      </div>
    </div>
  )
}

function KpiCard({ label, value, icon, color, danger }: {
  label: string; value: number; icon: React.ReactNode; color: string; danger?: boolean
}) {
  return (
    <div className={`card flex items-center gap-4 ${danger && value > 0 ? 'ring-1 ring-red-200 bg-red-50/30' : ''}`}>
      <div className={`w-10 h-10 rounded-xl flex items-center justify-center shrink-0 ${color}`}>
        {icon}
      </div>
      <div>
        <p className="text-2xl font-bold text-gray-900">{value}</p>
        <p className="text-xs text-gray-500">{label}</p>
      </div>
    </div>
  )
}

function RunbookStat({ label, value, color, icon }: { label: string; value: number; color: string; icon?: React.ReactNode }) {
  return (
    <div>
      <p className={`text-2xl font-bold ${color} flex items-center gap-1`}>
        {icon}{value}
      </p>
      <p className="text-xs text-gray-500 mt-0.5">{label}</p>
    </div>
  )
}

function EmptyState({ message }: { message: string }) {
  return (
    <div className="py-8 text-center">
      <p className="text-sm text-gray-400">{message}</p>
    </div>
  )
}
