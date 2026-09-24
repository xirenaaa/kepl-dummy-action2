import { describe, it, expect } from 'vitest'
import { calculateStats, formatTaskStatus, validateTaskInput } from '../src/utils/taskHelper'

describe('taskHelper Unit Tests (Vitest without backend)', () => {
  describe('calculateStats', () => {
    it('returns all zeros for empty array', () => {
      const stats = calculateStats([])
      expect(stats).toEqual({
        total: 0,
        completed: 0,
        pending: 0,
        completionRate: 0
      })
    })

    it('correctly calculates total, completed, pending, and rate', () => {
      const mockTasks = [
        { id: 1, title: 'Tugas 1', is_completed: true },
        { id: 2, title: 'Tugas 2', is_completed: false },
        { id: 3, title: 'Tugas 3', is_completed: true },
        { id: 4, title: 'Tugas 4', is_completed: false }
      ]
      const stats = calculateStats(mockTasks)
      expect(stats.total).toBe(4)
      expect(stats.completed).toBe(2)
      expect(stats.pending).toBe(2)
      expect(stats.completionRate).toBe(50)
    })
  })

  describe('formatTaskStatus', () => {
    it('returns "Selesai" for true and "Tertunda" for false', () => {
      expect(formatTaskStatus(true)).toBe('Selesai')
      expect(formatTaskStatus(false)).toBe('Tertunda')
    })
  })

  describe('validateTaskInput', () => {
    it('rejects empty input', () => {
      expect(validateTaskInput('').valid).toBe(false)
      expect(validateTaskInput('  ').valid).toBe(false)
    })

    it('rejects input shorter than 3 characters', () => {
      expect(validateTaskInput('ab').valid).toBe(false)
    })

    it('accepts valid title', () => {
      const res = validateTaskInput('Tugas CI/CD Vue 3')
      expect(res.valid).toBe(true)
      expect(res.message).toBe('')
    })
  })
})
