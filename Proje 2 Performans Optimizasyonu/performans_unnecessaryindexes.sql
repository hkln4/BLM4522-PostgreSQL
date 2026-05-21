-- Tüm indexlerin kullanım istatistiklerini görüntüle
SELECT
    schemaname,
    relname AS tablename,
    indexrelname AS indexname,
    idx_scan AS kac_kez_kullanildi,
    idx_tup_read AS okunan_satir,
    idx_tup_fetch AS getirilen_satir
FROM pg_stat_user_indexes
WHERE relname = 'orders'
ORDER BY idx_scan ASC;

-- Index boyutlarını görüntüle
SELECT
    indexrelname AS indexname,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_boyutu
FROM pg_stat_user_indexes
WHERE relname = 'orders';


-- Gereksiz index'i kaldır
DROP INDEX idx_orders_status;

-- Kaldırma sonrası doğrula
SELECT indexrelname AS indexname
FROM pg_stat_user_indexes
WHERE relname = 'orders';