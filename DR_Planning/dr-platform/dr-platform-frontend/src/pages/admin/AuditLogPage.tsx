import { ScrollText } from 'lucide-react'

export default function AuditLogPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Audit Log</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Full immutable audit trail — every action, every actor, every session. Available to SUPER_ADMIN only.
        </p>
      </div>
      <ComingSoon
        icon={<ScrollText size={40} className="text-gray-300" />}
        title="Audit Log Viewer — Coming Soon"
        bullets={[
          'Every mutating action in the platform is recorded: who, what, when, from which IP, in which session',
          'Filter by actor, action type, resource type, date range, subsidiary',
          'Session timeline view: trace a full user session from OTP request → login → all actions → logout',
          'Before/after state captured for all updates — full diff visible',
          'Backed by the audit_log table with session_id, actor_email, and jti correlation — records survive user deletion',
          'Export to CSV for regulatory submission',
        ]}
      />
    </div>
  )
}

function ComingSoon({ icon, title, bullets }: { icon: React.ReactNode; title: string; bullets: string[] }) {
  return (
    <div className="card flex flex-col items-center py-16 gap-6 text-center max-w-2xl mx-auto">
      {icon}
      <div>
        <h2 className="text-lg font-semibold text-gray-700">{title}</h2>
        <p className="text-sm text-gray-400 mt-1">This module is scheduled for the next build sprint.</p>
      </div>
      <ul className="text-left space-y-2 w-full max-w-lg">
        {bullets.map((b, i) => (
          <li key={i} className="flex items-start gap-2 text-sm text-gray-500">
            <span className="mt-1 w-1.5 h-1.5 rounded-full bg-equity-red/50 shrink-0" />
            {b}
          </li>
        ))}
      </ul>
    </div>
  )
}
