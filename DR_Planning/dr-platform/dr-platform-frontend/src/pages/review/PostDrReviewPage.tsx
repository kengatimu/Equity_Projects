import { FileCheck } from 'lucide-react'

export default function PostDrReviewPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Post-DR Review</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Capture DR outcomes, issues raised, action items, and carry-forward blockers for the next cycle.
        </p>
      </div>
      <ComingSoon
        icon={<FileCheck size={40} className="text-gray-300" />}
        title="Post-DR Review — Week 11"
        bullets={[
          'Each application owner submits outcomes: result (Success / Partial / Failed / Rolled Back), RTO achieved, comments',
          'Issues raised during the War Room are reviewed — marked Resolved or Carry Forward',
          'Carry-forward issues are automatically surfaced in the next campaign\'s Pre-DR Readiness checklist with age tracking',
          'Action items assigned with due dates and owners — tracked across cycles until resolved',
          'Coordinator reviews all application outcomes and adds overall campaign notes',
          'Once all outcomes are submitted, the Report Generator is unlocked for this campaign',
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
