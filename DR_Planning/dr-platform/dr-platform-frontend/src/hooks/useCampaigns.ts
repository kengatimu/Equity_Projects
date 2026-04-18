import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import axiosClient from '../api/axiosClient'
import type {
  ApiResponse, CampaignApplicationDto, CampaignDto,
  GateCheckResult, PagedResponse, TimelineEventDto
} from '../types'
import toast from 'react-hot-toast'

const KEYS = {
  all:      ['campaigns'] as const,
  list:     (p: object) => ['campaigns', 'list', p] as const,
  detail:   (id: string) => ['campaigns', id] as const,
  gate:     (id: string) => ['campaigns', id, 'gate'] as const,
  timeline: (id: string) => ['campaigns', id, 'timeline'] as const,
}

export function useCampaigns(params?: { page?: number; size?: number; subsidiaryId?: string }) {
  return useQuery({
    queryKey: KEYS.list(params ?? {}),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<PagedResponse<CampaignDto>>>('/campaigns', { params })
      return data.data
    },
  })
}

export function useCampaign(id: string) {
  return useQuery({
    queryKey: KEYS.detail(id),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<CampaignDto>>(`/campaigns/${id}`)
      return data.data
    },
    enabled: !!id,
  })
}

export function useCampaignGateCheck(id: string) {
  return useQuery({
    queryKey: KEYS.gate(id),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<GateCheckResult>>(`/campaigns/${id}/gate-check`)
      return data.data
    },
    enabled: !!id,
  })
}

export function useCampaignTimeline(id: string) {
  return useQuery({
    queryKey: KEYS.timeline(id),
    queryFn: async () => {
      const { data } = await axiosClient.get<ApiResponse<TimelineEventDto[]>>(`/campaigns/${id}/timeline`)
      return data.data
    },
    enabled: !!id,
  })
}

export function useCreateCampaign() {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: object) => {
      const { data } = await axiosClient.post<ApiResponse<CampaignDto>>('/campaigns', body)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.all })
      toast.success('Campaign created')
    },
    onError: () => toast.error('Failed to create campaign'),
  })
}

export function useAddApplicationToCampaign(campaignId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async (body: object) => {
      const { data } = await axiosClient.post<ApiResponse<CampaignApplicationDto>>(
        `/campaigns/${campaignId}/applications`, body
      )
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.detail(campaignId) })
      toast.success('Application added to campaign')
    },
    onError: () => toast.error('Failed to add application'),
  })
}

export function useOpenPreDr(campaignId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async () => {
      const { data } = await axiosClient.post<ApiResponse<CampaignDto>>(`/campaigns/${campaignId}/open-pre-dr`)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.detail(campaignId) })
      toast.success('Pre-DR window opened')
    },
  })
}

export function useApproveCampaign(campaignId: string) {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: async () => {
      const { data } = await axiosClient.post<ApiResponse<CampaignDto>>(`/campaigns/${campaignId}/approve`)
      return data.data
    },
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: KEYS.detail(campaignId) })
      qc.invalidateQueries({ queryKey: KEYS.gate(campaignId) })
      toast.success('Campaign approved')
    },
    onError: (err: unknown) => {
      const msg = (err as { response?: { data?: { message?: string } } })?.response?.data?.message
      toast.error(msg ?? 'Approval failed — check gate status')
    },
  })
}
