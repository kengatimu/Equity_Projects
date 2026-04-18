import { BookOpen } from 'lucide-react'

export default function RunbookPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Runbook Builder</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Structured, versioned, peer-reviewed DR runbooks — enforced before every campaign execution.
        </p>
      </div>
      <ComingSoon
        icon={<BookOpen size={40} className="text-gray-300" />}
        title="Runbook Builder — Week 7"
        bullets={[
          'Runbooks are structured by phase: Pre-Cutover → Cutover → DR Validation → Rollback',
          'Each step has: description, exact commands, owner role, estimated duration, verification criteria',
          'Quality gate enforced before submission — all phases must be present with scored completeness ≥ 70/100',
          'Peer review workflow: App Owner submits → Peer reviews → ITSCM approves → Locked',
          'Once approved and locked, War Room loads an immutable snapshot — no last-minute edits',
          'Pre-populated from the last approved runbook version (35-min review instead of 3-hr write)',
          'T-21 / T-14 / T-10 / T-7 enforcement timeline with manager escalation at T-7 if not approved',
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
