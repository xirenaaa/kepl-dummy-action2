/**
 * Utility functions for Task calculation and formatting
 */

export function calculateStats(tasks = []) {
  const total = tasks.length
  const completed = tasks.filter((t) => Boolean(t.is_completed || t.completed)).length
  const pending = total - completed
  const completionRate = total > 0 ? Math.round((completed / total) * 100) : 0

  return {
    total,
    completed,
    pending,
    completionRate
  }
}

export function formatTaskStatus(isCompleted) {
  return isCompleted ? 'Selesai' : 'Tertunda'
}

export function validateTaskInput(title) {
  if (!title || typeof title !== 'string') {
    return { valid: false, message: 'Judul tugas tidak boleh kosong.' }
  }
  const trimmed = title.trim()
  if (trimmed.length < 3) {
    return { valid: false, message: 'Judul tugas minimal 3 karakter.' }
  }
  if (trimmed.length > 100) {
    return { valid: false, message: 'Judul tugas maksimal 100 karakter.' }
  }
  return { valid: true, message: '' }
}
