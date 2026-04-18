import { useRef, useState, useEffect, useCallback } from 'react'
import { useNavigate, useLocation } from 'react-router-dom'
import { useAuth } from '../../context/AuthContext'
import toast from 'react-hot-toast'
import { Loader2, Mail, RefreshCw } from 'lucide-react'

const RESEND_COOLDOWN = 60

export default function MfaPage() {
  const { verifyOtp, requestOtp } = useAuth()
  const navigate = useNavigate()
  const location = useLocation()
  const email = (location.state as { email?: string })?.email

  const [digits, setDigits] = useState(Array(6).fill(''))
  const [loading, setLoading] = useState(false)
  const [resending, setResending] = useState(false)
  const [cooldown, setCooldown] = useState(RESEND_COOLDOWN)

  const ref0 = useRef<HTMLInputElement>(null)
  const ref1 = useRef<HTMLInputElement>(null)
  const ref2 = useRef<HTMLInputElement>(null)
  const ref3 = useRef<HTMLInputElement>(null)
  const ref4 = useRef<HTMLInputElement>(null)
  const ref5 = useRef<HTMLInputElement>(null)
  const refs = [ref0, ref1, ref2, ref3, ref4, ref5]

  useEffect(() => {
    if (cooldown <= 0) return
    const t = setInterval(() => setCooldown(c => c - 1), 1000)
    return () => clearInterval(t)
  }, [cooldown])

  const handleResend = useCallback(async () => {
    if (!email || cooldown > 0 || resending) return
    setResending(true)
    try {
      const delivered = await requestOtp(email)
      if (delivered) {
        toast.success('New code sent — check your email')
      } else {
        toast('We could not deliver the email. Please try again or contact IT support.', {
          icon: '⚠️',
          style: { background: '#fef3c7', color: '#92400e' },
          duration: 6000,
        })
      }
      setCooldown(RESEND_COOLDOWN)
      setDigits(Array(6).fill(''))
      refs[0].current?.focus()
    } catch (err: unknown) {
      const msg =
        (err as { response?: { data?: { message?: string } } })?.response?.data?.message ??
        'Could not resend code. Try again.'
      toast.error(msg)
    } finally {
      setResending(false)
    }
  }, [email, cooldown, resending, requestOtp])

  if (!email) {
    navigate('/login')
    return null
  }

  const handleChange = (idx: number, val: string) => {
    if (!/^\d?$/.test(val)) return
    const next = [...digits]
    next[idx] = val
    setDigits(next)
    if (val && idx < 5) refs[idx + 1].current?.focus()
    if (next.every(d => d)) handleSubmit(next.join(''))
  }

  const handleKeyDown = (idx: number, e: React.KeyboardEvent) => {
    if (e.key === 'Backspace' && !digits[idx] && idx > 0) {
      refs[idx - 1].current?.focus()
    }
  }

  const handlePaste = (e: React.ClipboardEvent) => {
    e.preventDefault()
    const pasted = e.clipboardData.getData('text').replace(/\D/g, '').slice(0, 6)
    if (!pasted) return
    const next = [...digits]
    for (let i = 0; i < pasted.length; i++) next[i] = pasted[i]
    setDigits(next)
    // Focus the box after the last pasted digit, or last box
    const focusIdx = Math.min(pasted.length, 5)
    refs[focusIdx].current?.focus()
    if (pasted.length === 6) handleSubmit(pasted)
  }

  const handleSubmit = async (code?: string) => {
    const otp = code ?? digits.join('')
    if (otp.length !== 6) return
    setLoading(true)
    try {
      await verifyOtp(email, otp)
      navigate('/dashboard', { replace: true })
    } catch (err: unknown) {
      const msg =
        (err as { response?: { data?: { message?: string } } })?.response?.data?.message ??
        'Invalid or expired code. Try again.'
      toast.error(msg)
      setDigits(Array(6).fill(''))
      refs[0].current?.focus()
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center px-6">
      <div className="w-full max-w-sm">
        <div className="flex justify-center mb-6">
          <div className="w-14 h-14 bg-equity-red/10 rounded-2xl flex items-center justify-center">
            <Mail size={28} className="text-equity-red" />
          </div>
        </div>

        <div className="text-center mb-8">
          <h2 className="text-2xl font-bold text-gray-900">Check your email</h2>
          <p className="text-gray-500 mt-2 text-sm">
            We sent a 6-digit code to
          </p>
          <p className="text-equity-red font-medium text-sm mt-0.5">{email}</p>
        </div>

        <div className="flex gap-2 justify-center mb-8">
          {digits.map((d, i) => (
            <input
              key={i}
              ref={refs[i]}
              type="text"
              inputMode="numeric"
              maxLength={1}
              value={d}
              onChange={e => handleChange(i, e.target.value)}
              onKeyDown={e => handleKeyDown(i, e)}
              onPaste={handlePaste}
              className="w-11 h-14 text-center text-xl font-bold border border-gray-300 rounded-lg
                         focus:outline-none focus:ring-2 focus:ring-equity-red/30 focus:border-equity-red transition-colors"
            />
          ))}
        </div>

        <button
          onClick={() => handleSubmit()}
          disabled={loading || digits.some(d => !d)}
          className="btn-primary w-full justify-center py-2.5"
        >
          {loading ? <Loader2 size={18} className="animate-spin mr-2" /> : null}
          {loading ? 'Verifying…' : 'Verify code'}
        </button>

        <div className="mt-5 text-center space-y-2">
          <p className="text-sm text-gray-500">Didn't receive a code?</p>

          <button
            onClick={handleResend}
            disabled={cooldown > 0 || resending}
            className="inline-flex items-center gap-1.5 text-sm font-medium text-equity-red
                       hover:underline disabled:opacity-40 disabled:cursor-not-allowed disabled:no-underline"
          >
            {resending
              ? <Loader2 size={14} className="animate-spin" />
              : <RefreshCw size={14} />}
            {resending
              ? 'Sending…'
              : cooldown > 0
                ? `Resend code (${cooldown}s)`
                : 'Resend code'}
          </button>

          <p className="text-xs text-gray-400">or</p>

          <button
            onClick={() => navigate('/login')}
            className="text-sm text-gray-500 hover:underline"
          >
            Try a different email
          </button>
        </div>

        <p className="mt-4 text-center text-xs text-gray-400">
          Code expires in 10 minutes
        </p>
      </div>
    </div>
  )
}
