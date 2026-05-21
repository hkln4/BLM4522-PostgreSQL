-- 1. Migration öncesi test: mevcut kayıt sayılarını kaydet
CREATE TABLE migration_test_v1 AS
SELECT 
    'orders' AS tablo, COUNT(*) AS kayit_sayisi FROM orders
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products;

-- 2. customers tablosuna yeni sütunlar ekle
ALTER TABLE customers 
    ADD COLUMN phone VARCHAR(20),
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(),
    ADD COLUMN segment VARCHAR(20) DEFAULT 'standard';

-- 3. orders tablosuna yeni sütunlar ekle
ALTER TABLE orders
    ADD COLUMN discount NUMERIC(5,2) DEFAULT 0,
    ADD COLUMN shipping_cost NUMERIC(10,2) DEFAULT 0,
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();

-- 4. products tablosuna yeni sütunlar ekle
ALTER TABLE products
    ADD COLUMN stock_quantity INTEGER DEFAULT 0,
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();

-- 5. Yeni index ekle
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_customers_country ON customers(country);
CREATE INDEX idx_products_category ON products(category);

-- 6. customers segment sütununu güncelle
UPDATE customers
SET segment = CASE
    WHEN country IN ('USA', 'Germany') THEN 'premium'
    WHEN country IN ('France', 'UK') THEN 'standard'
    ELSE 'basic'
END;

-- 7. Versiyon tablosunu güncelle
INSERT INTO schema_versiyon (versiyon, aciklama)
VALUES ('v2.0.0', 'customers/orders/products tablolarına yeni sütunlar eklendi, 3 yeni index oluşturuldu');

-- 8. Migration sonrası doğrulama
SELECT * FROM schema_versiyon ORDER BY uygulama_zamani;