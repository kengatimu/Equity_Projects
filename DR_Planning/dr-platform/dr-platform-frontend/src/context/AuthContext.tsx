import React, { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import axiosClient from '../api/axiosClient'
import type { AuthResponse, UserDto } from '../types'

interface AuthContextValue {
  user: UserDto | null
  isAuthenticated: boolean
  isLoading: boolean
  requestOtp: (email: string) => Promise<boolean>
  verifyOtp: (email: string, code: string) => Promise<void>
  logout: () => void
  hasRole: (...roles: string[]) => boolean
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<UserDto | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const stored = localStorage.getItem('user')
    const token = localStorage.getItem('accessToken')
    if (stored && token) {
      try {
        setUser(JSON.parse(stored))
      } catch {
        localStorage.clear()
      }
    }
    setIsLoading(false)
  }, [])

  const requestOtp = useCallback(async (email: string): Promise<boolean> => {
    const { data } = await axiosClient.post<{ data: { emailDelivered: boolean } }>(
      '/auth/request-otp', { email }
    )
    return data.data.emailDelivered
  }, [])

  const verifyOtp = useCallback(async (email: string, code: string): Promise<void> => {
    const { data } = await axiosClient.post<{ data: AuthResponse }>('/auth/verify-otp', { email, code })
    const result = data.data
    localStorage.setItem('accessToken', result.accessToken)
    localStorage.setItem('refreshToken', result.refreshToken)
    localStorage.setItem('user', JSON.stringify(result.user))
    setUser(result.user)
  }, [])

  const logout = useCallback(() => {
    const refreshToken = localStorage.getItem('refreshToken')
    if (refreshToken) {
      axiosClient.post('/auth/logout', null, { headers: { 'X-Refresh-Token': refreshToken } }).catch(() => {})
    }
    localStorage.clear()
    setUser(null)
    window.location.href = '/login'
  }, [])

  const hasRole = useCallback(
    (...roles: string[]) => (user ? roles.includes(user.role) : false),
    [user],
  )

  const value = useMemo(
    () => ({ user, isAuthenticated: !!user, isLoading, requestOtp, verifyOtp, logout, hasRole }),
    [user, isLoading, requestOtp, verifyOtp, logout, hasRole],
  )

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
