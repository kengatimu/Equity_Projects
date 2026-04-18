import { FileBarChart } from 'lucide-react'

export default function ReportGeneratorPage() {
  return (
    <div className="space-y-5 max-w-7xl">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Report Generator</h1>
        <p className="text-gray-500 text-sm mt-0.5">
          Auto-generate regulatory-grade DR reports in Word and PDF format directly from campaign data.
        </p>
      </div>
      <ComingSoon
        icon={<FileBarChart size={40} className="text-gray-300" />}
        title="Report Generator — Week 12"
        bullets={[
          'One-click generation of the full post-DR report — no manual assembly from scattered notes',
          'Report includes: campaign summary, per-application outcomes, RTO achieved vs target, issues raised, action items, attendance record',
          'Word (.docx) format via Apache POI — editable for coordinator sign-off and comments',
          'PDF format via iText 7 — ready for regulatory submission or board reporting',
          'Management view report: cross-subsidiary DR coverage %, success rates, recurring issues, trend analysis',
          'All reports are archived in the platform — downloadable at any time from the campaign record',
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
