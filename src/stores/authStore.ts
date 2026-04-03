import { create } from 'zustand'
import { supabase } from '../lib/supabase'

interface User {
  id: string
  email: string
}

interface AuthStore {
  user: User | null
  loading: boolean
  login: (email: string, password: string) => Promise<void>
  signup: (email: string, password: string) => Promise<void>
  logout: () => Promise<void>
  setUser: (user: User | null) => void
}

export const useAuthStore = create<AuthStore>((set) => ({
  user: null,
  loading: false,

  login: async (email: string, password: string) => {
    set({ loading: true })
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      })
      if (error) throw error
      if (data.user) {
        set({ user: { id: data.user.id, email: data.user.email || '' } })
      }
    } catch (error) {
      console.error('Login error:', error)
      throw error
    } finally {
      set({ loading: false })
    }
  },

  signup: async (email: string, password: string) => {
    set({ loading: true })
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      })
      if (error) throw error
      if (data.user) {
        set({ user: { id: data.user.id, email: data.user.email || '' } })
      }
    } catch (error) {
      console.error('Signup error:', error)
      throw error
    } finally {
      set({ loading: false })
    }
  },

  logout: async () => {
    try {
      await supabase.auth.signOut()
      set({ user: null })
    } catch (error) {
      console.error('Logout error:', error)
      throw error
    }
  },

  setUser: (user) => set({ user }),
}))
