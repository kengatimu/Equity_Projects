/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        // Equity Bank brand colours
        equity: {
          red:        '#8B1A10',   // Primary brand red (dark crimson)
          'red-dark': '#6B1209',   // Hover / pressed state
          'red-light':'#C0392B',   // Accent / button highlight
          nav:        '#FFFFFF',   // Top-nav background
          footer:     '#1A1A1A',   // Footer
        },
        dr: {
          success: '#16A34A',
          warning: '#D97706',
          danger:  '#DC2626',
          info:    '#2563EB',
          muted:   '#6B7280',
        },
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      boxShadow: {
        card: '0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)',
      },
    },
  },
  plugins: [],
}
