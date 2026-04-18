import { ClipboardList } from 'lucide-react'

export default function PreDrReadinessPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Pre-DR Readiness</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Per-application checklists, carried-forward blockers, and sign-off tracking for every campaign.
        </p>
      </div>
      <ComingSoon
        icon={<ClipboardList size={40} className="text-gray-300" />}
        title="Pre-DR Readiness — Week 5"
        bullets={[
          'Coordinator sees ALL applications in a campaign in a single readiness grid — owner, checklist %, blockers',
          'Application owners see only their own tasks and any unresolved blockers carried forward from the last DR cycle',
          'Blockers that were never resolved in a previous cycle are surfaced prominently with their age in days',
          'T-7 / T-3 / T-1 automated email and SMS reminders fire to owners with incomplete items',
          'Owner submits a formal Pre-DR sign-off; coordinator acknowledges — both recorded in the audit log',
          'Campaign cannot move to APPROVED until all application sign-offs are received',
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
