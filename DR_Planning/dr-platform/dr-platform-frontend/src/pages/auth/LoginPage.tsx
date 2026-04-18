import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import toast from 'react-hot-toast'
import { Loader2, ShieldCheck, Mail } from 'lucide-react'

export default function LoginPage() {
  const { requestOtp } = useAuth()
  const navigate = useNavigate()

  const [email, setEmail] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    const trimmed = email.trim().toLowerCase()
    if (!trimmed) return
    setLoading(true)
    try {
      const delivered = await requestOtp(trimmed)
      if (delivered) {
        toast.success('Verification code sent — check your email')
      } else {
        toast('We could not deliver the email. Please try again or contact IT support.', {
          icon: '⚠️',
          style: { background: '#fef3c7', color: '#92400e' },
          duration: 6000,
        })
      }
      navigate('/mfa', { state: { email: trimmed } })
    } catch (err: unknown) {
      const msg =
        (err as { response?: { data?: { message?: string } } })?.response?.data?.message ??
        'Could not send verification code. Check your email address.'
      toast.error(msg)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Left branding panel */}
      <div className="hidden lg:flex lg:w-1/2 bg-equity-red flex-col justify-between p-12">
        {/* Real Equity Bank logo — white filter so it shows on the red background */}
        <div>
          <img
            src="/equity-bank-logo.png"
            alt="Equity Bank Group"
            className="h-12 w-auto object-contain"
            style={{ filter: 'brightness(0) invert(1)' }}
          />
        </div>

        <div>
          <ShieldCheck size={56} className="text-white/30 mb-6" />
          <h1 className="text-4xl font-bold text-white leading-tight mb-4">
            Disaster Recovery<br />Management Platform
          </h1>
          <p className="text-white/70 text-lg leading-relaxed max-w-md">
            Centralised DR campaign management, runbook enforcement,
            and real-time war-room coordination across all Equity Bank subsidiaries.
          </p>
        </div>

        <p className="text-white/40 text-sm">
          © {new Date().getFullYear()} Equity Group Holdings PLC. Internal use only.
        </p>
      </div>

      {/* Right login panel */}
      <div className="flex-1 flex items-center justify-center px-6 py-12">
        <div className="w-full max-w-md">
          {/* Mobile logo — shown only on small screens (lg panel is hidden) */}
          <div className="flex items-center gap-3 mb-8 lg:hidden">
            <img
              src="/equity-bank-logo.png"
              alt="Equity Bank Group"
              className="h-9 w-auto object-contain"
            />
          </div>

          <div className="mb-8">
            <h2 className="text-2xl font-bold text-gray-900">Sign in</h2>
            <p className="text-gray-500 mt-1 text-sm">
              Enter your Equity Bank email and we'll send you a verification code.
            </p>
          </div>

          <form onSubmit={handleSubmit} className="space-y-5">
            <div>
              <label className="label" htmlFor="email">Email address</label>
              <div className="relative">
                <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  id="email"
                  type="email"
                  autoComplete="email"
                  autoFocus
                  value={email}
                  onChange={e => setEmail(e.target.value)}
                  placeholder="john.doe@equitybank.co.ke"
                  className="input pl-9"
                  required
                />
              </div>
              <p className="mt-1.5 text-xs text-gray-400">
                Authorised domains: @equitybank.co.ke · @gmail.com (dev)
              </p>
            </div>

            <button
              type="submit"
              disabled={loading || !email.trim()}
              className="btn-primary w-full justify-center py-2.5 text-base"
            >
              {loading ? <Loader2 size={18} className="animate-spin mr-2" /> : null}
              {loading ? 'Sending code…' : 'Send verification code'}
            </button>
          </form>

          <p className="mt-8 text-center text-xs text-gray-400">
            Secure access · Confidential · For authorised personnel only
          </p>
        </div>
      </div>
    </div>
  )
}
