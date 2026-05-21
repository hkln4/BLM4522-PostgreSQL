-- Mevcut tabloları ve boyutlarını görüntüle
SELECT 
    relname AS tablo_adi,
    pg_size_pretty(pg_total_relation_size(relid)) AS toplam_boyut,
    pg_size_pretty(pg_relation_size(relid)) AS veri_boyutu,
    n_live_tup AS kayit_sayisi
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- Veritabanı toplam boyutu
SELECT pg_size_pretty(pg_database_size('performans_proje')) AS veritabani_boyutu;

-- Tablo kayıt sayılarını doğrula
SELECT 'orders' AS tablo, COUNT(*) AS kayit FROM orders
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products;