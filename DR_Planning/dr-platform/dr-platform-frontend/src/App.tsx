import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import ProtectedRoute from './components/layout/ProtectedRoute'
import AppLayout from './components/layout/AppLayout'

// Auth
import LoginPage from './pages/auth/LoginPage'
import MfaPage from './pages/auth/MfaPage'
import UnauthorizedPage from './pages/auth/UnauthorizedPage'

// 1. Dashboard
import DashboardPage from './pages/dashboard/DashboardPage'

// 2. Application Registry
import ApplicationListPage from './pages/applications/ApplicationListPage'
import ApplicationDetailPage from './pages/applications/ApplicationDetailPage'
import ApplicationImportPage from './pages/applications/ApplicationImportPage'
import ApplicationHistoryPage from './pages/applications/ApplicationHistoryPage'

// 3. Dependency Engine
import DependencyPage from './pages/dependencies/DependencyPage'
import ResourceHistoryPage from './pages/dependencies/ResourceHistoryPage'

// 4. Campaign Manager
import CampaignListPage from './pages/campaigns/CampaignListPage'
import CampaignDetailPage from './pages/campaigns/CampaignDetailPage'

// 5. Pre-DR Readiness + Checklist
import PreDrReadinessPage from './pages/readiness/PreDrReadinessPage'
import ChecklistPage from './pages/checklist/ChecklistPage'

// 6. Runbook Builder
import RunbookPage from './pages/runbooks/RunbookPage'

// 7. War Room
import WarRoomPage from './pages/warroom/WarRoomPage'

// 8. Post-DR Review
import PostDrReviewPage from './pages/review/PostDrReviewPage'

// 9. Report Generator
import ReportGeneratorPage from './pages/reports/ReportGeneratorPage'

// Admin — Audit Log
import AuditLogPage from './pages/admin/AuditLogPage'

export default function App() {
  return (
    <AuthProvider>
      <BrowserRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
        <Routes>
          {/* Public */}
          <Route path="/login"        element={<LoginPage />} />
          <Route path="/mfa"          element={<MfaPage />} />
          <Route path="/unauthorized" element={<UnauthorizedPage />} />

          {/* Protected — inside AppLayout */}
          <Route element={<ProtectedRoute />}>
            <Route element={<AppLayout />}>
              <Route path="/" element={<Navigate to="/dashboard" replace />} />

              {/* 9. Dashboard & Analytics */}
              <Route path="/dashboard" element={<DashboardPage />} />

              {/* 1. Application Registry */}
              <Route path="/applications"          element={<ApplicationListPage />} />
              <Route path="/applications/history"  element={<ApplicationHistoryPage />} />
              <Route path="/applications/import"   element={<ApplicationImportPage />} />
              <Route path="/applications/:id"      element={<ApplicationDetailPage />} />

              {/* 2. Dependency Engine */}
              <Route path="/dependencies"         element={<DependencyPage />} />
              <Route path="/dependencies/history" element={<ResourceHistoryPage />} />

              {/* 3. Campaign Manager */}
              <Route path="/campaigns"     element={<CampaignListPage />} />
              <Route path="/campaigns/:id" element={<CampaignDetailPage />} />

              {/* 4. Pre-DR Readiness */}
              <Route path="/readiness" element={<PreDrReadinessPage />} />
              <Route
                path="/campaigns/:campaignId/applications/:caId/checklist"
                element={<ChecklistPage />}
              />

              {/* 5. Runbook Builder */}
              <Route path="/runbooks" element={<RunbookPage />} />

              {/* 6. War Room */}
              <Route path="/war-room" element={<WarRoomPage />} />

              {/* 7. Post-DR Review */}
              <Route path="/post-dr" element={<PostDrReviewPage />} />

              {/* 8. Report Generator */}
              <Route path="/reports" element={<ReportGeneratorPage />} />

              {/* Admin */}
              <Route path="/audit-log" element={<AuditLogPage />} />
            </Route>
          </Route>

          <Route path="*" element={<Navigate to="/dashboard" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  )
}
