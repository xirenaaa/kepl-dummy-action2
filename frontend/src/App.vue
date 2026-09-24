<template>
  <div class="min-h-screen flex flex-col bg-slate-50">
    <header class="bg-indigo-600 text-white shadow-md">
      <div class="max-w-4xl mx-auto px-4 py-4 flex justify-between items-center">
        <h1 class="text-xl font-bold tracking-wide">
          KEPL Task Hub
        </h1>
        <nav class="space-x-4">
          <router-link
            to="/"
            class="hover:underline font-medium"
            active-class="underline font-bold"
          >
            Home
          </router-link>
          <router-link
            to="/tasks"
            class="hover:underline font-medium"
            active-class="underline font-bold"
          >
            Daftar Tugas (API)
          </router-link>
        </nav>
      </div>
    </header>

    <main class="max-w-4xl mx-auto px-4 py-8 flex-1 w-full">
      <router-view />
    </main>

    <footer class="bg-white border-t border-slate-200 py-4 text-center text-sm text-slate-500">
      Praktikum Kualitas & Evolusi Perangkat Lunak 2026 &bull; NIM: 24/541475/SV/24912
    </footer>
  </div>
</template>

<script setup>
</script>
