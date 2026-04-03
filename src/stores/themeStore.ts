import { create } from 'zustand'

type Theme = 'light' | 'dark' | 'blue' | 'purple' | 'green'

interface ThemeStore {
  theme: Theme
  setTheme: (theme: Theme) => void
}

export const useThemeStore = create<ThemeStore>((set) => ({
  theme: localStorage.getItem('theme') as Theme || 'light',
  setTheme: (theme: Theme) => {
    localStorage.setItem('theme', theme)
    set({ theme })
  },
}))
