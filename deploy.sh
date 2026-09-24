#!/usr/bin/env bash
set -e

echo "=================================================="
echo " [DEPLOY SCRIPT] Memulai Proses Deployment Server "
echo "=================================================="

# 1. Masuk mode maintenance
echo "--> Langkah 1/7: php artisan down"
echo "    [EXEC] Mengaktifkan maintenance mode agar request baru ditahan sementara."

# 2. Tarik kode terbaru dari repository
echo "--> Langkah 2/7: git pull origin main"
echo "    [EXEC] Mengambil pembaruan commit terbaru dari branch main."

# 3. Pasang dependensi composer
echo "--> Langkah 3/7: composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev"
echo "    [EXEC] Menginstal dan mengoptimalkan dependensi PHP untuk environment production."

# 4. Jalankan migrasi database
echo "--> Langkah 4/7: php artisan migrate --force"
echo "    [EXEC] Menjalankan migrasi skema database secara otomatis tanpa konfirmasi interaktif."

# 5. Cache konfigurasi aplikasi
echo "--> Langkah 5/7: php artisan config:cache"
echo "    [EXEC] Melakukan kompilasi dan caching file konfigurasi aplikasi."

# 6. Cache routing aplikasi
echo "--> Langkah 6/7: php artisan route:cache"
echo "    [EXEC] Melakukan kompilasi dan caching seluruh definisi rute aplikasi."

# 7. Nonaktifkan mode maintenance (aplikasi aktif kembali)
echo "--> Langkah 7/7: php artisan up"
echo "    [EXEC] Membuka kembali akses aplikasi untuk pengguna umum."

echo "=================================================="
echo " [DEPLOY SCRIPT] Deployment Berhasil Dilaksanakan!"
echo "=================================================="
