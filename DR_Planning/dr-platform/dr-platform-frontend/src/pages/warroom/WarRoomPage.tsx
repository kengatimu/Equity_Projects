import { Radio } from 'lucide-react'

export default function WarRoomPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">War Room</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Live DR execution command centre — real-time step tracking, RTO timer, and instant issue logging.
        </p>
      </div>
      <ComingSoon
        icon={<Radio size={40} className="text-gray-300" />}
        title="War Room — Week 8"
        bullets={[
          'Launches from an approved campaign — loads an immutable snapshot of the approved runbook',
          'RTO countdown timer starts at War Room open; visible to all participants in real-time',
          'Each runbook step can be marked: Not Started → In Progress → Done / Blocked',
          'Blocked steps fire an immediate alert to the coordinator and escalation contact',
          'Issues are logged inline with severity, description, and assigned owner',
          'Real-time updates via WebSocket (Spring WebSocket + STOMP) — all participants see changes instantly',
          'Rollback can be triggered at any phase — locks further progression and starts rollback procedure',
          'Full audit trail: every status change timestamped and attributed to the acting user',
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
