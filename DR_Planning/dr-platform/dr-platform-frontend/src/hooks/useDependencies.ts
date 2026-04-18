import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import toast from 'react-hot-toast'
import axiosClient from '../api/axiosClient'
import type {
  ApiResponse,
  ArchiveDependencyResult,
  ConflictDto,
  CreateDependencyRequest,
  CreateSharedResourceRequest,
  DeactivateDependencyResult,
  DependencyDto,
  DependencyHistoryDto,
  ResolveConflictRequest,
  SharedResourceDto,
  SharedResourceHistoryDto,
  SharedResourceSummaryDto,
} from '../types'

// ─── Query keys ───────────────────────────────────────────────────────────────
const KEYS = {
  appDeps:          (appId: string)      => ['dependencies', 'app', appId]          as const,
  sharedResources:                        () => ['dependencies', 'shared']           as const,
  resourceRegistry: (q?: string)         => ['shared-resources', 'registry', q ?? ''] as const,
  conflicts:        (campaignId: string) => ['conflicts', campaignId]                as const,
}

// ─── Per-application dependencies ─────────────────────────────────────────────

export function useAppDependencies(appId: string) {
  return useQuery({
    queryKey: KEYS.appDeps(appId),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<DependencyDto[]>>(
        `/applications/${appId}/dependencies`,
      )
      return data.data
    },
    enabled: !!appId,
    staleTime: 60_000,
  })
}

export function useAddDependency(appId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: CreateDependencyRequest) => {
      const { data } = await axiosClient.post<ApiResponse<DependencyDto>>(
        `/applications/${appId}/dependencies`,
        body,
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.appDeps(appId) })
      qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
      toast.success('Dependency registered')
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to register dependency')
    },
  })
}

/** Archive a dependency — copies to dependency_history, hard-deletes from dependencies. */
export function useArchiveDependency(appId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (dependencyId: string) => {
      const { data } = await axiosClient.delete<ApiResponse<ArchiveDependencyResult>>(
        `/dependencies/${dependencyId}`,
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.appDeps(appId) })
      qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
      qc.invalidateQueries({ queryKey: ['dep-history', appId] })
      toast.success('Dependency archived')
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to archive dependency')
    },
  })
}

// Keep backward-compat alias
export const useRemoveDependency = useArchiveDependency

/** Fetch archived dependency history for an application. */
export function useDependencyHistory(appId: string) {
  return useQuery({
    queryKey: ['dep-history', appId],
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<DependencyHistoryDto[]>>(
        `/applications/${appId}/dependencies/history`,
      )
      return data.data
    },
    enabled: !!appId,
    staleTime: 120_000, // history is immutable — 2 min cache
  })
}

/**
 * Soft-deactivate a dependency (sets isActive=false).
 * Returns DeactivateDependencyResult which includes a warning list when
 * other apps share the same resource.
 */
export function useDeactivateDependency(appId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (dependencyId: string) => {
      const { data } = await axiosClient.patch<ApiResponse<DeactivateDependencyResult>>(
        `/dependencies/${dependencyId}/deactivate`,
      )
      return data.data
    },
    onSuccess: (result) => {
      qc.invalidateQueries({ queryKey: KEYS.appDeps(appId) })
      qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
      if (!result.hasWarnings) {
        toast.success('Dependency deactivated')
      }
      // caller is responsible for showing the warning dialog when hasWarnings=true
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to deactivate dependency')
    },
  })
}

// ─── Shared resources (global view — grouped for Dependency Engine page) ──────

export function useSharedResources() {
  return useQuery({
    queryKey: KEYS.sharedResources(),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<SharedResourceSummaryDto[]>>(
        '/dependencies/shared',
      )
      return data.data
    },
    staleTime: 60_000,  // 1 min — this data rarely changes; avoids repeated polls
  })
}

// ─── Shared Resource Registry (CMDB-lite) — used by the dependency form ───────

/**
 * Search (or list all) resources from the registry.
 * Pass `q` to filter by name/code, omit for full list.
 */
export function useSharedResourceRegistry(q?: string) {
  return useQuery({
    queryKey: KEYS.resourceRegistry(q),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<SharedResourceDto[]>>(
        '/shared-resources',
        { params: q ? { q } : undefined },
      )
      return data.data
    },
    staleTime: 30_000,
  })
}

export function useCreateSharedResource() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: CreateSharedResourceRequest) => {
      const { data } = await axiosClient.post<ApiResponse<SharedResourceDto>>(
        '/shared-resources',
        body,
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ['shared-resources'] })
      qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
      toast.success('Shared resource registered in registry')
    },
    onError: (err: any) => {
      // 409 is handled gracefully at the call site (jumps to Step 2 "link to app")
      if (err?.response?.status === 409) return
      toast.error(err?.response?.data?.message ?? 'Failed to create shared resource')
    },
  })
}

export interface ArchiveSharedResourceResult {
  hasWarnings: boolean
  warningApps: string[]
  archived: boolean
}

export function useDeactivateSharedResource() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (id: string) => {
      const { data } = await axiosClient.patch<ApiResponse<SharedResourceDto>>(`/shared-resources/${id}/deactivate`)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ['shared-resources'] })
      qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
      toast.success('Resource deactivated')
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to deactivate resource')
    },
  })
}

/** Fetch archive history of shared resources (hard-deleted entries). */
export function useSharedResourceHistory() {
  return useQuery({
    queryKey: ['shared-resources', 'history'],
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<SharedResourceHistoryDto[]>>('/shared-resources/history')
      return data.data
    },
    staleTime: 120_000, // history is immutable — 2 min cache
  })
}

export function useArchiveSharedResource() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async ({ id, force }: { id: string; force: boolean }) => {
      const { data } = await axiosClient.delete<ApiResponse<ArchiveSharedResourceResult>>(
        `/shared-resources/${id}`,
        { params: { force } },
      )
      return data.data
    },
    onSuccess: (result) => {
      if (result.archived) {
        qc.invalidateQueries({ queryKey: ['shared-resources'] })
        qc.invalidateQueries({ queryKey: KEYS.sharedResources() })
        qc.invalidateQueries({ queryKey: ['shared-resources', 'history'] })
        toast.success('Resource archived')
      }
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to archive resource')
    },
  })
}

// ─── Campaign conflicts ────────────────────────────────────────────────────────

export function useCampaignConflicts(campaignId: string, unresolvedOnly = false) {
  return useQuery({
    queryKey: [...KEYS.conflicts(campaignId), unresolvedOnly],
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<ConflictDto[]>>(
        `/campaigns/${campaignId}/conflicts`,
        { params: { unresolvedOnly } },
      )
      return data.data
    },
    enabled: !!campaignId,
  })
}

export function useResolveConflict(campaignId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async ({ conflictId, body }: { conflictId: string; body: ResolveConflictRequest }) => {
      const { data } = await axiosClient.post<ApiResponse<ConflictDto>>(
        `/conflicts/${conflictId}/resolve`,
        body,
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.conflicts(campaignId) })
      toast.success('Conflict resolved')
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to resolve conflict')
    },
  })
}

export function useScanConflicts(campaignId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async () => {
      await axiosClient.post(`/campaigns/${campaignId}/conflicts/scan`)
    },
    onSuccess: () => {
      // Give the async scan a moment then refresh conflicts list
      setTimeout(() => {
        qc.invalidateQueries({ queryKey: KEYS.conflicts(campaignId) })
      }, 1500)
      toast.success('Conflict scan started — results will appear shortly')
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to start conflict scan')
    },
  })
}
