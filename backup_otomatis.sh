#!/bin/bash
# Script Backup Otomatis Kledo Assessment - Ulul Azmi A. Latala

TANGGAL=$(date +%Y%m%d_%H%M)
DIR_BACKUP="/backup"

# Pastikan folder backup ada
mkdir -p $DIR_BACKUP

# Backup Database
mysqldump -u root wp_db > $DIR_BACKUP/wp_db_$TANGGAL.sql
mysqldump -u root laravel_db > $DIR_BACKUP/laravel_db_$TANGGAL.sql

# Backup File Web
tar -czf $DIR_BACKUP/wp_files_$TANGGAL.tar.gz -C /var/www/ wp.ulul.efs.my.id
tar -czf $DIR_BACKUP/laravel_files_$TANGGAL.tar.gz -C /var/www/ laravel.ulul.efs.my.id

# Hapus backup yang umurnya lebih dari 7 hari agar disk tidak penuh
find $DIR_BACKUP -type f -name "*.gz" -mtime +7 -delete
find $DIR_BACKUP -type f -name "*.sql" -mtime +7 -delete

echo "Backup Selesai pada $TANGGAL"
