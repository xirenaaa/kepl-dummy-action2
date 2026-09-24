<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm border border-slate-200">
      <div>
        <h2 class="text-2xl font-bold text-slate-800">
          Daftar Tugas (Laravel API)
        </h2>
        <p class="text-sm text-slate-500 mt-1">
          Endpoint: <code class="bg-slate-100 px-2 py-1 rounded font-mono text-xs text-indigo-600">{{ apiUrl }}/api/tugas</code>
        </p>
      </div>
      <button
        :disabled="loading"
        class="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-medium rounded-lg text-sm transition"
        @click="fetchTasks"
      >
        {{ loading ? 'Memuat...' : 'Refresh Data' }}
      </button>
    </div>

    <!-- Error Alert -->
    <div
      v-if="error"
      class="p-4 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm"
    >
      <strong>Gagal terhubung ke API:</strong> {{ error }}
    </div>

    <!-- Stats Summary -->
    <div class="grid grid-cols-3 gap-4">
      <div class="bg-white p-4 rounded-lg shadow-sm border border-slate-200 text-center">
        <div class="text-2xl font-bold text-slate-800">
          {{ stats.total }}
        </div>
        <div class="text-xs text-slate-500 mt-1">
          Total Tugas
        </div>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm border border-slate-200 text-center">
        <div class="text-2xl font-bold text-emerald-600">
          {{ stats.completed }}
        </div>
        <div class="text-xs text-slate-500 mt-1">
          Selesai
        </div>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm border border-slate-200 text-center">
        <div class="text-2xl font-bold text-amber-600">
          {{ stats.pending }}
        </div>
        <div class="text-xs text-slate-500 mt-1">
          Tertunda
        </div>
      </div>
    </div>

    <!-- Task List -->
    <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
      <div
        v-if="loading && tasks.length === 0"
        class="text-center py-8 text-slate-400"
      >
        Memuat daftar tugas dari server Laravel...
      </div>

      <div
        v-else-if="tasks.length === 0"
        class="text-center py-8 text-slate-400"
      >
        Belum ada data tugas.
      </div>

      <ul
        v-else
        class="divide-y divide-slate-100"
      >
        <li
          v-for="task in tasks"
          :key="task.id"
          class="py-4 flex items-center justify-between hover:bg-slate-50 px-3 rounded-lg transition"
        >
          <div class="flex items-center space-x-3">
            <span
              :class="task.is_completed ? 'bg-emerald-100 text-emerald-800' : 'bg-amber-100 text-amber-800'"
              class="px-2.5 py-1 text-xs font-semibold rounded-full"
            >
              {{ task.is_completed ? 'Selesai' : 'Pending' }}
            </span>
            <div>
              <p
                :class="{ 'line-through text-slate-400': task.is_completed }"
                class="font-medium text-slate-800"
              >
                {{ task.title }}
              </p>
              <p
                v-if="task.description"
                class="text-xs text-slate-500 mt-0.5"
              >
                {{ task.description }}
              </p>
            </div>
          </div>
          <span class="text-xs text-slate-400 font-mono">ID: #{{ task.id }}</span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { calculateStats } from '../utils/taskHelper'

const apiUrl = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000'
const tasks = ref([])
const loading = ref(false)
const error = ref('')

const stats = computed(() => calculateStats(tasks.value))

async function fetchTasks() {
  loading.value = true
  error.value = ''
  try {
    const res = await fetch(`${apiUrl}/api/tugas`, {
      headers: {
        'Accept': 'application/json'
      }
    })
    if (!res.ok) {
      throw new Error(`HTTP Error status: ${res.status}`)
    }
    const data = await res.json()
    tasks.value = Array.isArray(data) ? data : []
  } catch (err) {
    error.value = err.message || 'Gagal memuat tugas.'
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchTasks()
})
</script>
