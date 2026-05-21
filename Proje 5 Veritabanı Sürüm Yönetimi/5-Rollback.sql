-- 1. Migration öncesi kayıt sayılarını kontrol et
SELECT * FROM migration_test_v1;

-- 2. v2'de eklenen indexleri kaldır
DROP INDEX idx_orders_status;
DROP INDEX idx_customers_country;
DROP INDEX idx_products_category;

-- 3. v2'de eklenen sütunları kaldır
ALTER TABLE customers
    DROP COLUMN phone,
    DROP COLUMN updated_at,
    DROP COLUMN segment;

ALTER TABLE orders
    DROP COLUMN discount,
    DROP COLUMN shipping_cost,
    DROP COLUMN updated_at;

ALTER TABLE products
    DROP COLUMN stock_quantity,
    DROP COLUMN updated_at;

-- 4. Rollback'i versiyon tablosuna kaydet
INSERT INTO schema_versiyon (versiyon, aciklama, durum)
VALUES ('v1.0.0', 'v2.0.0 geri alındı — eklenen sütunlar ve indexler kaldırıldı', 'ROLLBACK');

-- 5. Rollback sonrası sütunları doğrula
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('customers', 'orders', 'products')
ORDER BY table_name, ordinal_position;

-- 6. Versiyon geçmişini görüntüle
SELECT * FROM schema_versiyon ORDER BY uygulama_zamani;