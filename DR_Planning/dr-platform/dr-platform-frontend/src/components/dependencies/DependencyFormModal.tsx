import { useEffect, useState } from 'react'
import { Link2, X } from 'lucide-react'
import { useApplications } from '../../hooks/useApplications'
import { useAddDependency } from '../../hooks/useDependencies'
import type { CreateDependencyRequest, DependencyType, SharedResourceDto } from '../../types'
import {
  DEP_TYPES,
  ResourcePicker,
  SelectedResourceChip,
  depMeta,
} from './ResourcePicker'

// ─── Main modal ────────────────────────────────────────────────────────────────

const EMPTY: CreateDependencyRequest = {
  dependencyType: 'DATABASE',
  isShared: false,
  resourceName: '',
  description: '',
}

interface Props {
  applicationId: string
  isOpen: boolean
  onClose: () => void
}

export default function DependencyFormModal({ applicationId, isOpen, onClose }: Props) {
  const [form, setForm]                         = useState<CreateDependencyRequest>(EMPTY)
  const [selectedResource, setSelectedResource] = useState<SharedResourceDto | null>(null)
  const { data: apps }                          = useApplications({ size: 200 })
  const add                                     = useAddDependency(applicationId)

  useEffect(() => {
    if (isOpen) { setForm(EMPTY); setSelectedResource(null) }
  }, [isOpen])

  if (!isOpen) return null

  const set = <K extends keyof CreateDependencyRequest>(k: K, v: CreateDependencyRequest[K]) =>
    setForm(f => ({ ...f, [k]: v }))

  const handleSelectResource = (r: SharedResourceDto) => {
    setSelectedResource(r)
    set('resourceName', r.code)
    set('dependencyType', r.resourceType)
  }

  const handleClearResource = () => {
    setSelectedResource(null)
    set('resourceName', '')
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    const payload: CreateDependencyRequest = {
      ...form,
      resourceName: form.resourceName?.trim() || undefined,
      description:  form.description?.trim()  || undefined,
      dependsOnId:  form.dependsOnId          || undefined,
    }
    await add.mutateAsync(payload)
    onClose()
  }

  const currentDepMeta = depMeta(form.dependencyType)
  const DepIcon        = currentDepMeta.icon

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 backdrop-blur-sm p-4"
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md flex flex-col max-h-[92vh]">

        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-100">
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 rounded-lg bg-equity-red/10 flex items-center justify-center">
              <Link2 size={15} className="text-equity-red" />
            </div>
            <div>
              <h2 className="text-sm font-semibold text-gray-900">Register Dependency</h2>
              <p className="text-[11px] text-gray-400">What does this application depend on?</p>
            </div>
          </div>
          <button onClick={onClose} className="p-1.5 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100 transition-colors">
            <X size={16} />
          </button>
        </div>

        {/* Body */}
        <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto px-6 py-5 space-y-5">

          {/* ── Dependency Type ──────────────────────────────────────────────── */}
          <div>
            <label className="label">Dependency Type *</label>
            <div className="grid grid-cols-4 gap-1.5">
              {DEP_TYPES.map(t => {
                const Icon     = t.icon
                const selected = form.dependencyType === t.value
                return (
                  <button
                    key={t.value}
                    type="button"
                    onClick={() => set('dependencyType', t.value as DependencyType)}
                    className={`flex flex-col items-center gap-1 p-2 rounded-xl border-2 text-center transition-all ${
                      selected
                        ? `border-current ${t.colour} shadow-sm`
                        : 'border-gray-100 hover:border-gray-200 text-gray-500 hover:bg-gray-50'
                    }`}
                  >
                    <Icon size={14} />
                    <span className="text-[10px] font-medium leading-tight">{t.label}</span>
                  </button>
                )
              })}
            </div>
          </div>

          {/* ── Shared Resource toggle ───────────────────────────────────────── */}
          <button
            type="button"
            onClick={() => {
              const next = !form.isShared
              set('isShared', next)
              if (!next) { setSelectedResource(null); set('resourceName', '') }
            }}
            className={`w-full p-3.5 rounded-xl border-2 text-left transition-all ${
              form.isShared ? 'border-equity-red bg-equity-red/5' : 'border-gray-200 hover:border-gray-300'
            }`}
          >
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <div className={`p-1.5 rounded-lg ${form.isShared ? 'bg-equity-red/10' : 'bg-gray-100'}`}>
                  <DepIcon size={13} className={form.isShared ? 'text-equity-red' : 'text-gray-400'} />
                </div>
                <div>
                  <p className="text-xs font-semibold text-gray-800">Shared Infrastructure Resource</p>
                  <p className="text-[11px] text-gray-400 mt-0.5">
                    {form.isShared
                      ? 'Linked to a shared resource — conflicts detected automatically across campaigns'
                      : 'Enable if other applications also depend on the same resource'}
                  </p>
                </div>
              </div>
              <div className={`w-9 h-5 rounded-full flex-shrink-0 relative transition-colors ${form.isShared ? 'bg-equity-red' : 'bg-gray-300'}`}>
                <span className={`absolute top-0.5 w-4 h-4 bg-white rounded-full shadow transition-transform ${form.isShared ? 'translate-x-4' : 'translate-x-0.5'}`} />
              </div>
            </div>
          </button>

          {/* ── Resource name (always visible) / Shared picker ───────────────── */}
          {form.isShared ? (
            <div className="space-y-2">
              <label className="label">
                Shared Resource *
                <span className="ml-1 text-gray-400 font-normal text-[11px]">
                  search the registry, or register a new entry
                </span>
              </label>
              {selectedResource ? (
                <SelectedResourceChip resource={selectedResource} onClear={handleClearResource} />
              ) : (
                <ResourcePicker depType={form.dependencyType} onSelect={handleSelectResource} />
              )}
            </div>
          ) : (
            <div>
              <label className="label">
                Resource Name
                <span className="text-gray-400 font-normal ml-1 text-[11px]">(optional)</span>
              </label>
              <input
                className="input"
                type="text"
                placeholder={`e.g. Oracle DB, Redis Cache, SWIFT Gateway…`}
                value={form.resourceName ?? ''}
                onChange={e => set('resourceName', e.target.value)}
              />
              <p className="text-[11px] text-gray-400 mt-1">
                Name of the specific resource this application depends on.
              </p>
            </div>
          )}

          {/* ── Depends-on application ───────────────────────────────────────── */}
          <div>
            <label className="label">
              Depends On Application
              <span className="text-gray-400 font-normal ml-1 text-[11px]">(optional)</span>
            </label>
            <select
              className="input"
              value={form.dependsOnId ?? ''}
              onChange={e => set('dependsOnId', e.target.value || undefined)}
            >
              <option value="">— None / infrastructure resource —</option>
              {apps?.content
                .filter(a => a.id !== applicationId)
                .map(a => <option key={a.id} value={a.id}>{a.code} — {a.name}</option>)}
            </select>
            <p className="text-[11px] text-gray-400 mt-1">
              Only set this for a direct application-to-application dependency.
            </p>
          </div>

          {/* ── Description ──────────────────────────────────────────────────── */}
          <div>
            <label className="label">
              Description
              <span className="text-gray-400 font-normal ml-1 text-[11px]">(optional)</span>
            </label>
            <textarea
              className="input resize-none"
              rows={2}
              placeholder="What does this application use it for? Any failover behaviour notes?"
              value={form.description ?? ''}
              onChange={e => set('description', e.target.value)}
            />
          </div>

          {form.isShared && !selectedResource && (
            <p className="text-[11px] text-amber-600 bg-amber-50 border border-amber-200 rounded-lg px-3 py-2">
              Please select or register a shared resource above before saving.
            </p>
          )}

          {/* ── Actions ──────────────────────────────────────────────────────── */}
          <div className="flex gap-3 pt-1">
            <button type="button" onClick={onClose} className="btn-secondary flex-1">Cancel</button>
            <button
              type="submit"
              disabled={add.isPending || (form.isShared && !selectedResource)}
              className="btn-primary flex-1"
            >
              {add.isPending ? 'Saving…' : 'Register Dependency'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
