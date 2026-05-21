-- 1. Tüm şema değişikliklerini görüntüle
SELECT * FROM schema_log ORDER BY islem_zamani;

-- 2. İşlem türüne göre özet
SELECT islem_turu, nesne_turu, COUNT(*) AS adet
FROM schema_log
GROUP BY islem_turu, nesne_turu
ORDER BY adet DESC;

-- 3. v2 sonrası yeni sütunları doğrula
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('customers', 'orders', 'products')
  AND column_name IN ('phone', 'updated_at', 'segment', 'discount', 
                      'shipping_cost', 'stock_quantity')
ORDER BY table_name, column_name;

-- 4. Yeni indexleri doğrula
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname IN ('idx_orders_status', 'idx_customers_country', 'idx_products_category');