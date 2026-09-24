<template>
  <div class="bg-white p-8 rounded-xl shadow-sm border border-slate-200 space-y-6">
    <div class="border-b border-slate-100 pb-4">
      <h2 class="text-2xl font-bold text-slate-800">
        Dashboard Sistem Manajemen Tugas
      </h2>
      <p class="text-slate-500 mt-1">
        Implementasi Frontend Vue 3 dengan 4-Stage CI/CD Pipeline
      </p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <div class="p-5 bg-indigo-50 rounded-lg border border-indigo-100">
        <h3 class="font-semibold text-indigo-900 text-lg">
          Integrasi REST API
        </h3>
        <p class="text-sm text-indigo-700 mt-2">
          Mengambil data secara asinkron dari backend Laravel via endpoint:
          <code class="bg-white px-2 py-0.5 rounded text-indigo-800 font-mono text-xs">{{ apiUrl }}/api/tugas</code>
        </p>
      </div>

      <div class="p-5 bg-emerald-50 rounded-lg border border-emerald-100">
        <h3 class="font-semibold text-emerald-900 text-lg">
          Otomasi Pipeline
        </h3>
        <p class="text-sm text-emerald-700 mt-2">
          4 Tahap CI/CD: <strong>Lint &rarr; Test (Vitest) &rarr; Build &rarr; Deploy</strong> dengan proteksi artefak build terisolasi.
        </p>
      </div>
    </div>

    <div class="pt-4 flex justify-center">
      <router-link
        to="/tasks"
        class="inline-flex items-center px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold rounded-lg shadow-sm transition"
      >
        Lihat Data Tugas dari Laravel &rarr;
      </router-link>
    </div>
  </div>
</template>

<script setup>
const apiUrl = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000'
</script>
