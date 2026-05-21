-- 1. Mevcut tabloları listele
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 2. Her tablonun sütun yapısını görüntüle
SELECT table_name, column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

-- 3. Mevcut indexleri listele
SELECT indexname, tablename, indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;

-- 4. Tablo boyutları
SELECT
    relname AS tablo_adi,
    pg_size_pretty(pg_total_relation_size(relid)) AS toplam_boyut,
    n_live_tup AS kayit_sayisi
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;