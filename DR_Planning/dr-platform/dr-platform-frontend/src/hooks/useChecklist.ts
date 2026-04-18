import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import axiosClient from '../api/axiosClient'
import type { ApiResponse, ChecklistItemDto, ChecklistSummaryDto } from '../types'
import toast from 'react-hot-toast'

const BASE = (caId: string) => `/campaign-applications/${caId}/checklist`

const KEYS = {
  items:   (caId: string) => ['checklist', caId, 'items'] as const,
  summary: (caId: string) => ['checklist', caId, 'summary'] as const,
}

export function useChecklist(campaignApplicationId: string) {
  return useQuery({
    queryKey: KEYS.items(campaignApplicationId),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<ChecklistItemDto[]>>(BASE(campaignApplicationId))
      return data.data
    },
    enabled: !!campaignApplicationId,
  })
}

export function useChecklistSummary(campaignApplicationId: string) {
  return useQuery({
    queryKey: KEYS.summary(campaignApplicationId),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<ChecklistSummaryDto>>(
        `${BASE(campaignApplicationId)}/summary`
      )
      return data.data
    },
    enabled: !!campaignApplicationId,
  })
}

export function useUpdateChecklistItem(campaignApplicationId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async ({ itemId, status, notes }: { itemId: string; status: string; notes?: string }) => {
      const { data } = await axiosClient.patch<ApiResponse<ChecklistItemDto>>(
        `${BASE(campaignApplicationId)}/items/${itemId}/status`,
        { status, notes }
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.items(campaignApplicationId) })
      qc.invalidateQueries({ queryKey: KEYS.summary(campaignApplicationId) })
    },
    onError: () => toast.error('Failed to update item status'),
  })
}

export function useBlockItem(campaignApplicationId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async ({ itemId, description, severity }: { itemId: string; description: string; severity?: string }) => {
      const { data } = await axiosClient.post<ApiResponse<ChecklistItemDto>>(
        `${BASE(campaignApplicationId)}/items/${itemId}/block`,
        { description, severity }
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.items(campaignApplicationId) })
      qc.invalidateQueries({ queryKey: KEYS.summary(campaignApplicationId) })
      toast.success('Blocker raised')
    },
    onError: () => toast.error('Failed to raise blocker'),
  })
}

export function useSubmitSignOff(campaignApplicationId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async () => {
      await axiosClient.post(`${BASE(campaignApplicationId)}/sign-off`)
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.summary(campaignApplicationId) })
      toast.success('Pre-DR sign-off submitted successfully')
    },
    onError: (err: unknown) => {
      const msg = (err as { response?: { data?: { message?: string } } })?.response?.data?.message
      toast.error(msg ?? 'Failed to submit sign-off')
    },
  })
}
