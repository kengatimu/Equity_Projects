import { useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useImportApplications } from '../../hooks/useApplications'
import {
  ArrowLeft, CheckCircle2, FileSpreadsheet, Upload,
  XCircle, AlertCircle, RefreshCw, Download,
  Zap, Clock, ShieldCheck,
} from 'lucide-react'
import type { ImportResult } from '../../types'
import { generateApplicationTemplate } from '../../utils/generateApplicationTemplate'

// ─────────────────────────────────────────────────────────────────────────────

const STEPS = [
  { n: '1', label: 'Download the template', sub: 'Pre-built with dropdowns for Tier, Subsidiary, DR Capability, and more' },
  { n: '2', label: 'Fill in your data',     sub: 'A–D always required · Tech Owner required · DR fields required when Has DR = Y' },
  { n: '3', label: 'Upload & import',       sub: 'Existing apps matched by Code are updated, not duplicated' },
]

const WHY_IMPORT = [
  {
    icon: Zap,
    title: 'Onboard 50+ apps in seconds',
    body:  'Adding applications one-by-one through the form takes minutes each. A spreadsheet lets your team fill in all details offline and import everything at once.',
  },
  {
    icon: Clock,
    title: 'Migrate from legacy trackers',
    body:  'If your DR register already lives in Excel or a shared sheet, this import is the fastest path to getting it into the platform without manual re-entry.',
  },
  {
    icon: ShieldCheck,
    title: 'Template prevents errors',
    body:  'The hardened template enforces dropdowns for all enum fields — Tier, Subsidiary, DR Capability — so invalid values are blocked before the file even reaches the system.',
  },
]

interface ColDef {
  col: string
  field: string
  hint?: string          // short descriptive text
  values?: string[]      // enum — rendered as pills
  desc?: string          // shown below pills for enum meaning
}

const REQUIRED_COLS: ColDef[] = [
  { col: 'A', field: 'Code',
    hint: 'UPPERCASE_SNAKE · unique per app',
    desc: 'e.g. FINACLE_CORE_KE' },
  { col: 'B', field: 'Name',
    hint: 'Full display name of the application',
    desc: 'e.g. Finacle Core Kenya' },
  { col: 'C', field: 'Tier',
    values: ['T1', 'T2', 'T3'],
    desc: 'T1 = Critical · T2 = Important · T3 = Standard' },
  { col: 'D', field: 'Subsidiary',
    values: ['KE', 'UG', 'TZ', 'RW', 'DRC', 'SS', 'GROUP'],
    desc: 'KE=Kenya · UG=Uganda · TZ=Tanzania · RW=Rwanda · DRC=Congo · SS=S.Sudan · GROUP=Shared' },
]

// Columns H & J — required only when Has DR = Y
const CONDITIONAL_COLS: ColDef[] = [
  { col: 'H', field: 'DR Capability',
    values: ['FULL_FAILOVER','APP_ONLY','DB_ONLY','APP_REPOINT','PARTIAL',
             'ACTIVE_ACTIVE','ROLLBACK_DRILL','COLD_STANDBY','TABLETOP','EXTENDED_OPS'] },
  { col: 'J', field: 'DR Endpoint',
    hint: 'Primary DR-site URL. Required when Has DR = Y.' },
]

// Columns M & N — required for all apps regardless of DR status
const RECOMMENDED_COLS: ColDef[] = [
  { col: 'M', field: 'Tech Owner Name',
    hint: 'Full name of tech owner responsible for the runbook.' },
  { col: 'N', field: 'Tech Owner Email',
    hint: 'Work email · Must match a registered platform user.' },
]

const OPTIONAL_GROUPS: { label: string; cols: ColDef[] }[] = [
  {
    label: 'App Details',
    cols: [
      { col: 'E', field: 'Vendor',
        hint: 'Software vendor. Use "In-house" for internally built systems.' },
      { col: 'F', field: 'Description',
        hint: 'Brief description of what this application does.' },
    ],
  },
  {
    label: 'DR Configuration',
    cols: [
      { col: 'G', field: 'Has DR',
        values: ['Y', 'N'],
        desc: 'Y = has a documented DR failover procedure' },
      { col: 'I', field: 'DC Endpoint',
        hint: 'Primary DC-side URL. Separate multiple with semicolons (;).' },
    ],
  },
  {
    label: 'Ownership',
    cols: [
      { col: 'K', field: 'Biz Owner Name',
        hint: 'Full name of business owner accountable for DR sign-off.' },
      { col: 'L', field: 'Biz Owner Email',
        hint: 'Work email · e.g. jane.doe@equitybank.co.ke' },
    ],
  },
  {
    label: 'Risk & Notes',
    cols: [
      { col: 'O', field: 'Customer Facing',
        values: ['Y', 'N'],
        desc: 'Y = failure is directly visible to Equity Bank customers' },
      { col: 'P', field: 'Notes',
        hint: 'Any additional context about this application\'s DR setup or constraints.' },
    ],
  },
]

const IMPORT_BEHAVIOUR = [
  { label: 'New Code',           desc: 'Creates a new application in the platform.' },
  { label: 'Existing Code',      desc: 'Updates that application — no duplicates created.' },
  { label: 'Missing required',   desc: 'Row is skipped and reported as an error.' },
  { label: 'Incomplete profile', desc: 'Imported but flagged with a warning — update via the app detail page.' },
  { label: 'Dependencies',       desc: 'Cannot be imported — add them from the app detail page after import.' },
  { label: 'Multiple endpoints', desc: 'Separate URLs with a semicolon (;) in the same cell.' },
]

// ─────────────────────────────────────────────────────────────────────────────

export default function ApplicationImportPage() {
  const navigate = useNavigate()
  const inputRef = useRef<HTMLInputElement>(null)
  const [dragging, setDragging]   = useState(false)
  const [file, setFile]           = useState<File | null>(null)
  const [result, setResult]       = useState<ImportResult | null>(null)
  const [downloading, setDownloading] = useState(false)
  const { mutateAsync: doImport, isPending } = useImportApplications()

  const handleFile = (f: File) => {
    if (!f.name.endsWith('.xlsx') && !f.name.endsWith('.xls')) return
    setFile(f)
    setResult(null)
  }

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault()
    setDragging(false)
    const f = e.dataTransfer.files[0]
    if (f) handleFile(f)
  }

  const handleImport = async () => {
    if (!file) return
    const res = await doImport(file)
    setResult(res)
  }

  const handleDownloadTemplate = async () => {
    setDownloading(true)
    try { await generateApplicationTemplate() } finally { setDownloading(false) }
  }

  const reset = () => { setFile(null); setResult(null) }

  return (
    <div className="space-y-5">

      {/* ── Page header ── */}
      <div className="flex items-center gap-3">
        <button onClick={() => navigate(-1)} className="btn-secondary p-2">
          <ArrowLeft size={16} />
        </button>
        <div>
          <h1 className="text-xl font-bold text-gray-900">Import Applications</h1>
          <p className="text-sm text-gray-500">Bulk-import or update applications from an Excel spreadsheet</p>
        </div>
      </div>

      {/* ── Two-column layout ── */}
      <div className="grid lg:grid-cols-2 gap-5 items-start">

        {/* ════ LEFT: two separate panels ════ */}
        <div className="space-y-4">

          {/* Panel 1 — How it works */}
          <div className="card px-6 py-5 space-y-4">
            <p className="text-[11px] font-bold text-gray-400 uppercase tracking-wide">How it works</p>
            <ol className="space-y-0">
              {STEPS.map((step, i) => (
                <li key={step.n} className="flex gap-3">
                  <div className="flex flex-col items-center">
                    <div className="w-6 h-6 rounded-full bg-equity-red/10 text-equity-red text-[11px] font-bold flex items-center justify-center shrink-0">
                      {step.n}
                    </div>
                    {i < STEPS.length - 1 && <div className="w-px h-5 bg-gray-100 my-1" />}
                  </div>
                  <div className="pb-1 pt-0.5">
                    <p className="text-sm font-semibold text-gray-800 leading-tight">{step.label}</p>
                    <p className="text-[11px] text-gray-400 mt-0.5 leading-relaxed">{step.sub}</p>
                  </div>
                </li>
              ))}
            </ol>

            <button
              onClick={handleDownloadTemplate}
              disabled={downloading}
              className="w-full justify-center py-2.5 text-sm font-semibold flex items-center gap-2 rounded-xl border-2 border-equity-red text-equity-red hover:bg-equity-red hover:text-white transition-colors disabled:opacity-50"
            >
              {downloading
                ? <><span className="w-4 h-4 border-2 border-equity-red/40 border-t-equity-red rounded-full animate-spin" /> Generating…</>
                : <><Download size={14} /> Download Template</>
              }
            </button>

            {/* Dependencies notice */}
            <div className="flex gap-2.5 rounded-xl border border-amber-200 bg-amber-50/60 px-3.5 py-3">
              <AlertCircle size={14} className="text-amber-500 shrink-0 mt-0.5" />
              <div>
                <p className="text-xs font-semibold text-amber-700">Dependencies not included</p>
                <p className="text-[11px] text-amber-600 mt-0.5 leading-relaxed">
                  App-to-app and infrastructure dependencies cannot be imported via Excel — they are relational and require referencing existing application IDs. Add them from the application detail page after import.
                </p>
              </div>
            </div>
          </div>

          {/* Panel 2 — Upload */}
          <div className="card px-6 py-5 space-y-3">
            <p className="text-[11px] font-bold text-gray-400 uppercase tracking-wide">Upload your file</p>

            <div
              onDragOver={e => { e.preventDefault(); setDragging(true) }}
              onDragLeave={() => setDragging(false)}
              onDrop={handleDrop}
              onClick={() => !file && inputRef.current?.click()}
              className={`rounded-xl border-2 border-dashed flex flex-col items-center gap-2.5 py-8 transition-all
                ${file
                  ? 'border-gray-200 bg-gray-50 cursor-default'
                  : dragging
                    ? 'border-equity-red bg-equity-red/5 cursor-copy'
                    : 'border-gray-200 hover:border-equity-red/40 hover:bg-gray-50 cursor-pointer'
                }`}
            >
              <div className={`w-10 h-10 rounded-xl flex items-center justify-center transition-colors ${
                file ? 'bg-green-50' : dragging ? 'bg-equity-red/10' : 'bg-gray-100'
              }`}>
                {file
                  ? <CheckCircle2 size={20} className="text-green-500" />
                  : <FileSpreadsheet size={20} className={dragging ? 'text-equity-red' : 'text-gray-400'} />
                }
              </div>

              {file ? (
                <div className="text-center space-y-0.5 px-4">
                  <p className="text-sm font-semibold text-gray-800 truncate max-w-xs">{file.name}</p>
                  <p className="text-xs text-gray-400">{(file.size / 1024).toFixed(1)} KB</p>
                  <button
                    type="button"
                    onClick={e => { e.stopPropagation(); inputRef.current?.click() }}
                    className="text-xs text-equity-red hover:underline font-medium"
                  >
                    Change file
                  </button>
                </div>
              ) : (
                <div className="text-center">
                  <p className="text-sm font-medium text-gray-700">
                    {dragging ? 'Drop to upload' : 'Drop your Excel file here'}
                  </p>
                  <p className="text-xs text-gray-400 mt-0.5">or click to browse · .xlsx · .xls</p>
                </div>
              )}

              <input
                ref={inputRef}
                type="file"
                accept=".xlsx,.xls"
                className="hidden"
                onChange={e => e.target.files?.[0] && handleFile(e.target.files[0])}
              />
            </div>

            <button
              onClick={handleImport}
              disabled={!file || isPending}
              className="btn-primary w-full justify-center py-3 text-sm font-semibold flex items-center gap-2"
            >
              {isPending ? (
                <><span className="w-4 h-4 border-2 border-white/40 border-t-white rounded-full animate-spin" /> Importing…</>
              ) : (
                <><Upload size={15} /> {file ? `Import "${file.name}"` : 'Select a file to import'}</>
              )}
            </button>

            {/* Result panel */}
            {result && (
              <div className={`rounded-xl border p-4 space-y-4 ${result.errors.length > 0 ? 'border-amber-200 bg-amber-50/40' : 'border-green-200 bg-green-50/40'}`}>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    {result.errors.length === 0
                      ? <CheckCircle2 size={16} className="text-green-600" />
                      : <AlertCircle size={16} className="text-amber-600" />
                    }
                    <span className="text-sm font-semibold text-gray-800">Import Complete</span>
                  </div>
                  <button onClick={reset} className="flex items-center gap-1 text-xs text-gray-400 hover:text-gray-600">
                    <RefreshCw size={11} /> Import another
                  </button>
                </div>

                <div className="grid grid-cols-4 gap-2">
                  <ResultStat label="Imported" value={result.imported}      variant="green" />
                  <ResultStat label="Updated"  value={result.updated}       variant="blue" />
                  <ResultStat label="Skipped"  value={result.skipped}       variant="gray" />
                  <ResultStat label="Errors"   value={result.errors.length} variant={result.errors.length > 0 ? 'red' : 'gray'} />
                </div>

                {result.errors.length > 0 && (
                  <div className="space-y-2">
                    <p className="text-[11px] font-bold text-red-700 uppercase tracking-wide">
                      {result.errors.length} row{result.errors.length > 1 ? 's' : ''} failed
                    </p>
                    <div className="rounded-xl border border-red-100 bg-white divide-y divide-red-50 max-h-44 overflow-y-auto">
                      {result.errors.map((err, i) => (
                        <div key={i} className="flex items-start gap-2 px-3 py-2">
                          <XCircle size={12} className="text-red-400 mt-0.5 shrink-0" />
                          <span className="text-xs text-red-600 leading-relaxed">{err}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>

        {/* ════ RIGHT: context ════ */}
        <div className="space-y-4">

          {/* Why bulk import */}
          <div className="card p-5 space-y-4">
            <div>
              <h3 className="text-sm font-bold text-gray-800">Why use bulk import?</h3>
              <p className="text-[11px] text-gray-400 mt-0.5">
                The form is great for single applications. For everything else, use the template.
              </p>
            </div>
            <div className="space-y-4">
              {WHY_IMPORT.map(({ icon: Icon, title, body }) => (
                <div key={title} className="flex gap-3">
                  <div className="w-8 h-8 rounded-lg bg-equity-red/8 border border-equity-red/15 flex items-center justify-center shrink-0 mt-0.5">
                    <Icon size={14} className="text-equity-red" />
                  </div>
                  <div>
                    <p className="text-sm font-semibold text-gray-800">{title}</p>
                    <p className="text-[11px] text-gray-500 mt-0.5 leading-relaxed">{body}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Column reference */}
          <div className="card p-0 overflow-hidden">
            <div className="px-5 py-3.5 border-b border-gray-100 flex items-center justify-between">
              <h3 className="text-sm font-bold text-gray-800">Spreadsheet Format</h3>
              <span className="text-[10px] font-bold text-gray-400 bg-gray-100 rounded-full px-2.5 py-0.5">16 columns · A – P</span>
            </div>

            {/* Required */}
            <div className="px-5 pt-4 pb-3">
              <p className="text-[10px] font-bold text-equity-red uppercase tracking-widest mb-3">Required — A to D</p>
              <div className="space-y-2.5">
                {REQUIRED_COLS.map(c => (
                  <ColRow key={c.col} col={c} required />
                ))}
              </div>
            </div>

            <div className="mx-5 border-t border-dashed border-gray-100" />

            {/* Conditional + Recommended + Optional + Import Behaviour — scrollable */}
            <div className="px-5 pt-3 pb-4 max-h-72 overflow-y-auto space-y-4">

              {/* Conditional required (H, J) */}
              <div className="pb-3 border-b border-dashed border-gray-100">
                <div className="flex items-center gap-2 mb-2.5">
                  <p className="text-[10px] font-bold text-amber-600 uppercase tracking-widest">Conditional — when Has DR = Y</p>
                </div>
                <div className="space-y-2.5">
                  {CONDITIONAL_COLS.map(c => <ColRow key={c.col} col={c} required={false} accent="amber" />)}
                </div>
              </div>

              {/* Always required — Tech Owner */}
              <div className="pb-3 border-b border-dashed border-gray-100">
                <p className="text-[10px] font-bold text-purple-600 uppercase tracking-widest mb-2.5">Required — all apps</p>
                <div className="space-y-2.5">
                  {RECOMMENDED_COLS.map(c => <ColRow key={c.col} col={c} required={false} accent="purple" />)}
                </div>
              </div>

              <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Optional — remaining</p>
              {OPTIONAL_GROUPS.map(group => (
                <div key={group.label}>
                  <p className="text-[10px] font-semibold text-gray-500 uppercase tracking-wider mb-2">{group.label}</p>
                  <div className="space-y-2.5">
                    {group.cols.map(c => (
                      <ColRow key={c.col} col={c} required={false} />
                    ))}
                  </div>
                </div>
              ))}

              {/* Import Behaviour */}
              <div className="pt-1 border-t border-dashed border-gray-100">
                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-widest mb-2.5">Import Behaviour</p>
                <div className="space-y-2">
                  {IMPORT_BEHAVIOUR.map(item => (
                    <div key={item.label} className="flex gap-2 items-start">
                      <span className="text-[9px] font-bold bg-gray-100 text-gray-500 rounded px-1.5 py-0.5 shrink-0 mt-0.5 whitespace-nowrap">{item.label}</span>
                      <p className="text-[10px] text-gray-400 leading-relaxed">{item.desc}</p>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────────────────────────────────────

const STAT_VARIANTS = {
  green: 'bg-green-50 border-green-100 text-green-700',
  blue:  'bg-blue-50  border-blue-100  text-blue-700',
  gray:  'bg-gray-50  border-gray-100  text-gray-500',
  red:   'bg-red-50   border-red-100   text-red-700',
}

function ColRow({ col, required, accent }: { col: ColDef; required: boolean; accent?: 'amber' | 'purple' }) {
  const pillCls = required
    ? 'bg-equity-red/8 border border-equity-red/20 text-equity-red'
    : accent === 'amber'
    ? 'bg-amber-50 border border-amber-200 text-amber-700'
    : accent === 'purple'
    ? 'bg-purple-50 border border-purple-200 text-purple-700'
    : 'bg-gray-100 text-gray-500'

  const colBadgeCls = required
    ? 'bg-equity-red/8 border border-equity-red/20 text-equity-red'
    : accent === 'amber'
    ? 'bg-amber-50 border border-amber-200 text-amber-600'
    : accent === 'purple'
    ? 'bg-purple-50 border border-purple-200 text-purple-600'
    : 'bg-gray-100 text-gray-500'

  return (
    <div className="flex items-start gap-2">
      <span className={`w-5 h-5 rounded text-[10px] font-bold flex items-center justify-center shrink-0 mt-0.5 ${colBadgeCls}`}>
        {col.col}
      </span>
      <div className="min-w-0 flex-1">
        <p className={`text-[11px] font-semibold leading-tight ${required ? 'text-gray-800' : 'text-gray-700'}`}>
          {col.field}
        </p>
        {col.values ? (
          <>
            <div className="flex flex-wrap gap-1 mt-1">
              {col.values.map(v => (
                <span key={v} className={`text-[9px] font-bold px-1.5 py-0.5 rounded ${pillCls}`}>{v}</span>
              ))}
            </div>
            {col.desc && (
              <p className="text-[9px] text-gray-400 mt-1 leading-relaxed">{col.desc}</p>
            )}
          </>
        ) : (
          <>
            {col.hint && <p className="text-[10px] text-gray-400 mt-0.5 leading-relaxed">{col.hint}</p>}
            {col.desc && <p className="text-[9px] text-gray-400 mt-0.5 italic">{col.desc}</p>}
          </>
        )}
      </div>
    </div>
  )
}

function ResultStat({ label, value, variant }: {
  label: string; value: number; variant: keyof typeof STAT_VARIANTS
}) {
  return (
    <div className={`rounded-xl border px-3 py-2.5 ${STAT_VARIANTS[variant]}`}>
      <p className="text-lg font-bold tabular-nums">{value}</p>
      <p className="text-[10px] font-semibold opacity-70 uppercase tracking-wide mt-px">{label}</p>
    </div>
  )
}
