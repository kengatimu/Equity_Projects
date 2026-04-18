import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import axiosClient from '../api/axiosClient'
import type { ApiResponse, ApplicationDto, ApplicationHistoryDto, CreateApplicationRequest, ImportResult, PagedResponse } from '../types'
import toast from 'react-hot-toast'

const KEYS = {
  all:    ['applications'] as const,
  list:   (p: object) => ['applications', 'list', p] as const,
  detail: (id: string) => ['applications', id] as const,
}

export function useApplications(params?: { name?: string; tier?: string; subsidiaryId?: string; page?: number; size?: number }) {
  return useQuery({
    queryKey: KEYS.list(params ?? {}),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<PagedResponse<ApplicationDto>>>(
        '/applications', { params }
      )
      return data.data
    },
    staleTime: 60_000,   // 1 min — prevents refetch on every nav / window-focus
  })
}

export function useApplication(id: string) {
  return useQuery({
    queryKey: KEYS.detail(id),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<ApplicationDto>>(`/applications/${id}`)
      return data.data
    },
    enabled: !!id,
    staleTime: 60_000,
  })
}

export function useCreateApplication() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: CreateApplicationRequest) => {
      const { data } = await axiosClient.post<ApiResponse<ApplicationDto>>('/applications', body)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      toast.success('Application created')
    },
    onError: (err: any) => {
      const msg = err?.response?.data?.message ?? 'Failed to create application'
      toast.error(msg)
    },
  })
}

export function useUpdateApplication(id: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: CreateApplicationRequest) => {
      const { data } = await axiosClient.put<ApiResponse<ApplicationDto>>(`/applications/${id}`, body)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      qc.invalidateQueries({ queryKey: KEYS.detail(id) })
      toast.success('Application updated')
    },
    onError: (err: any) => {
      const msg = err?.response?.data?.message ?? 'Failed to update application'
      toast.error(msg)
    },
  })
}

/** Archive (hard-delete from main table → written to application_history). Visible to all roles. */
export function useArchiveApplication() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (id: string) => {
      await axiosClient.delete(`/applications/${id}`)
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      toast.success('Application archived and removed from registry')
    },
    onError: (err: any) => {
      const msg = err?.response?.data?.error ?? 'Failed to archive application'
      toast.error(msg)
    },
  })
}

/** Soft-deactivate — sets isActive=false on the application record. */
export function useDeactivateApplication() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (id: string) => {
      await axiosClient.patch(`/applications/${id}/deactivate`)
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      toast.success('Application deactivated')
    },
    onError: (err: any) => {
      const msg = err?.response?.data?.error ?? 'Failed to deactivate application'
      toast.error(msg)
    },
  })
}

/** Fetch archived applications (COORDINATOR+ only). */
export function useApplicationHistory() {
  return useQuery({
    queryKey: ['applications', 'history'],
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<ApplicationHistoryDto[]>>('/applications/history')
      return data.data
    },
  })
}

/** Restore an archived application back to the live registry (SUPER_ADMIN / COORDINATOR). */
export function useRestoreApplication() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (historyId: string) => {
      const { data } = await axiosClient.post<ApiResponse<ApplicationDto>>(`/applications/history/${historyId}/restore`)
      return data.data
    },
    onSuccess: (restored) => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      qc.invalidateQueries({ queryKey: ['applications', 'history'] })
      toast.success(`${restored.name} restored to Application Registry`)
    },
    onError: (err: any) => {
      toast.error(err?.response?.data?.message ?? 'Failed to restore application')
    },
  })
}

// Keep backward-compat alias so existing callers compile without changes
export const useDeleteApplication = useArchiveApplication

export function useExportApplications() {
  return useMutation({
    mutationFn: async () => {
      const response = await axiosClient.get('/applications/export', { responseType: 'blob' })
      const url = URL.createObjectURL(new Blob([response.data]))
      const a = document.createElement('a')
      a.href = url
      const date = new Date().toISOString().slice(0, 10)
      a.download = `applications_${date}.xlsx`
      a.click()
      URL.revokeObjectURL(url)
    },
    onSuccess: () => toast.success('Export downloaded'),
    onError: () => toast.error('Export failed'),
  })
}

export function useImportApplications() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (file: File) => {
      const form = new FormData()
      form.append('file', file)
      const { data } = await axiosClient.post<ApiResponse<ImportResult>>('/applications/import', form, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })
      return data.data
    },
    onSuccess: (result) => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      toast.success(`Imported ${result.imported}, updated ${result.updated}, skipped ${result.skipped}`)
    },
    onError: () => toast.error('Import failed'),
  })
}
