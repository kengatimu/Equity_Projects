import { useEffect, useRef, useState } from 'react'
import { NavLink, Outlet } from 'react-router-dom'
import {
  LayoutDashboard, Server, GitMerge, ShieldCheck, ClipboardList,
  BookOpen, Radio, FileCheck, FileBarChart, ScrollText,
  LogOut, Menu, X, ChevronRight, Bell, User, Mail, Shield
} from 'lucide-react'
import { useAuth } from '../../context/AuthContext'
import clsx from 'clsx'

// ─── Nav structure ────────────────────────────────────────────────────────────

const NAV_SECTIONS = [
  {
    label: 'Overview',
    items: [
      { to: '/dashboard',    label: 'Dashboard',         icon: LayoutDashboard },
    ],
  },
  {
    label: 'Registry',
    items: [
      { to: '/applications', label: 'Applications',      icon: Server },
      { to: '/dependencies', label: 'Dependencies',      icon: GitMerge },
    ],
  },
  {
    label: 'Planning',
    items: [
      { to: '/campaigns',    label: 'DR Campaigns',      icon: ShieldCheck },
      { to: '/readiness',    label: 'Pre-DR Readiness',  icon: ClipboardList },
    ],
  },
  {
    label: 'Execution',
    items: [
      { to: '/runbooks',     label: 'Runbook Builder',   icon: BookOpen },
      { to: '/war-room',     label: 'War Room',          icon: Radio },
    ],
  },
  {
    label: 'Review',
    items: [
      { to: '/post-dr',      label: 'Post-DR Review',    icon: FileCheck },
      { to: '/reports',      label: 'Reports',           icon: FileBarChart },
    ],
  },
  {
    label: 'Admin',
    items: [
      { to: '/audit-log',    label: 'Audit Log',         icon: ScrollText },
    ],
  },
]

// ─── Component ────────────────────────────────────────────────────────────────

export default function AppLayout() {
  const { user, logout } = useAuth()
  const [sidebarOpen,  setSidebarOpen]  = useState(true)
  const [profileOpen,  setProfileOpen]  = useState(false)
  const profileRef = useRef<HTMLDivElement>(null)

  // Close dropdown when clicking outside
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (profileRef.current && !profileRef.current.contains(e.target as Node)) {
        setProfileOpen(false)
      }
    }
    if (profileOpen) document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [profileOpen])

  return (
    <div className="flex h-screen overflow-hidden bg-gray-50">
      {/* ── Sidebar ───────────────────────────────────────────────────── */}
      <aside
        className={clsx(
          'flex flex-col bg-white border-r border-gray-100 transition-all duration-300 shrink-0',
          sidebarOpen ? 'w-60' : 'w-16',
        )}
      >
        {/* Logo */}
        <div className="flex items-center h-16 px-4 border-b border-gray-100 gap-2">
          {sidebarOpen ? (
            <div className="flex items-center gap-2 min-w-0">
              <img
                src="/equity-bank-logo.png"
                alt="Equity Bank"
                className="h-8 w-auto shrink-0 object-contain"
              />
              <div className="leading-none border-l border-gray-200 pl-2 min-w-0">
                <p className="text-[10px] text-gray-400 uppercase tracking-widest whitespace-nowrap">DR Platform</p>
              </div>
            </div>
          ) : (
            <div className="flex items-center justify-center w-full">
              <img
                src="/equity-bank-logo.png"
                alt="Equity"
                className="h-8 w-auto object-contain"
              />
            </div>
          )}
        </div>

        {/* Navigation */}
        <nav className="flex-1 px-2 py-3 overflow-y-auto space-y-3">
          {NAV_SECTIONS.map(section => (
            <div key={section.label}>
              {/* Section label — only visible when expanded */}
              {sidebarOpen && (
                <p className="px-3 pb-1 text-[10px] font-semibold uppercase tracking-widest text-gray-400">
                  {section.label}
                </p>
              )}
              <div className="space-y-0.5">
                {section.items.map(({ to, label, icon: Icon }) => (
                  <NavLink
                    key={to}
                    to={to}
                    className={({ isActive }) =>
                      clsx(
                        'flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors',
                        isActive
                          ? 'bg-equity-red/10 text-equity-red'
                          : 'text-gray-600 hover:bg-gray-100 hover:text-gray-900',
                      )
                    }
                  >
                    <Icon size={17} className="shrink-0" />
                    {sidebarOpen && (
                      <>
                        <span className="flex-1">{label}</span>
                        <ChevronRight size={13} className="text-gray-300" />
                      </>
                    )}
                  </NavLink>
                ))}
              </div>
            </div>
          ))}
        </nav>

        {/* User footer */}
        <div className="border-t border-gray-100 p-3">
          {sidebarOpen ? (
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 rounded-full bg-equity-red/10 flex items-center justify-center shrink-0">
                <User size={15} className="text-equity-red" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-semibold text-gray-800 truncate">{user?.displayName}</p>
                <p className="text-[10px] text-gray-400 truncate">{user?.role?.replace(/_/g, ' ')}</p>
              </div>
              <button
                onClick={logout}
                className="p-1.5 text-gray-400 hover:text-equity-red rounded-lg hover:bg-equity-red/10 transition-colors"
                title="Sign out"
              >
                <LogOut size={14} />
              </button>
            </div>
          ) : (
            <button
              onClick={logout}
              className="flex items-center justify-center w-full p-2 text-gray-400 hover:text-equity-red rounded-lg hover:bg-equity-red/10 transition-colors"
            >
              <LogOut size={16} />
            </button>
          )}
        </div>
      </aside>

      {/* ── Main content ──────────────────────────────────────────────── */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {/* Top bar */}
        <header className="h-16 bg-white border-b border-gray-100 flex items-center justify-between px-6 shrink-0">
          <button
            onClick={() => setSidebarOpen(o => !o)}
            className="p-1.5 text-gray-500 hover:text-equity-red rounded-lg hover:bg-equity-red/10 transition-colors"
          >
            {sidebarOpen ? <X size={18} /> : <Menu size={18} />}
          </button>

          <div className="flex items-center gap-2">
            <button className="p-2 text-gray-500 hover:text-equity-red rounded-lg hover:bg-equity-red/10 transition-colors relative">
              <Bell size={18} />
            </button>

            {/* ── User profile chip + dropdown ── */}
            <div className="relative" ref={profileRef}>
              <button
                onClick={() => setProfileOpen(o => !o)}
                className={clsx(
                  'flex items-center gap-2 px-3 py-1.5 text-sm font-medium rounded-lg transition-colors',
                  profileOpen
                    ? 'bg-equity-red/10 text-equity-red'
                    : 'text-gray-700 hover:bg-gray-100',
                )}
              >
                <div className="w-6 h-6 rounded-full bg-equity-red/10 flex items-center justify-center">
                  <User size={12} className="text-equity-red" />
                </div>
                <span className="hidden sm:block">{user?.displayName}</span>
                <ChevronRight
                  size={13}
                  className={clsx(
                    'text-gray-400 transition-transform duration-200 hidden sm:block',
                    profileOpen && 'rotate-90',
                  )}
                />
              </button>

              {/* Dropdown panel */}
              {profileOpen && (
                <div className="absolute right-0 top-full mt-2 w-72 bg-white rounded-2xl shadow-lg border border-gray-100 z-50 overflow-hidden">
                  {/* Avatar + name block */}
                  <div className="flex items-center gap-3 px-4 py-4 bg-equity-red/5 border-b border-gray-100">
                    <div className="w-10 h-10 rounded-full bg-equity-red/15 flex items-center justify-center shrink-0">
                      <User size={18} className="text-equity-red" />
                    </div>
                    <div className="min-w-0">
                      <p className="text-sm font-bold text-gray-900 truncate">{user?.displayName}</p>
                      <p className="text-[11px] text-gray-400 truncate">{user?.email}</p>
                    </div>
                  </div>

                  {/* Details */}
                  <div className="px-4 py-3 space-y-2.5">
                    <div className="flex items-center gap-2.5 text-xs text-gray-600">
                      <Mail size={13} className="text-gray-400 shrink-0" />
                      <span className="truncate">{user?.email ?? '—'}</span>
                    </div>
                    <div className="flex items-center gap-2.5 text-xs text-gray-600">
                      <Shield size={13} className="text-gray-400 shrink-0" />
                      <span>{user?.role?.replace(/_/g, ' ') ?? '—'}</span>
                    </div>
                    {user?.subsidiaryId && (
                      <div className="flex items-center gap-2.5 text-xs text-gray-600">
                        <Server size={13} className="text-gray-400 shrink-0" />
                        <span>Subsidiary: {user.subsidiaryId}</span>
                      </div>
                    )}
                  </div>

                  {/* Sign out */}
                  <div className="border-t border-gray-100 px-3 py-2.5">
                    <button
                      onClick={() => { setProfileOpen(false); logout() }}
                      className="w-full flex items-center gap-2.5 px-3 py-2 rounded-lg text-sm font-medium text-equity-red hover:bg-equity-red/10 transition-colors"
                    >
                      <LogOut size={14} />
                      Sign out
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="flex-1 overflow-y-auto p-6">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
