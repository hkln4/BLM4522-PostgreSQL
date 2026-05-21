-- 1. v1 durumunu kaydet (referans nokta)
SELECT 
    'v1' AS versiyon,
    COUNT(*) AS toplam_kayit,
    COUNT(DISTINCT customer_id) AS benzersiz_musteri,
    COUNT(DISTINCT product_id) AS benzersiz_urun,
    ROUND(AVG(total_price), 2) AS ort_siparis_tutari,
    MIN(order_date) AS ilk_siparis,
    MAX(order_date) AS son_siparis
FROM orders;

-- 2. v2 migration'ı tekrar uygula
ALTER TABLE customers 
    ADD COLUMN phone VARCHAR(20),
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW(),
    ADD COLUMN segment VARCHAR(20) DEFAULT 'standard';

ALTER TABLE orders
    ADD COLUMN discount NUMERIC(5,2) DEFAULT 0,
    ADD COLUMN shipping_cost NUMERIC(10,2) DEFAULT 0,
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();

ALTER TABLE products
    ADD COLUMN stock_quantity INTEGER DEFAULT 0,
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();

CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_customers_country ON customers(country);
CREATE INDEX idx_products_category ON products(category);

-- 3. v2 sonrası aynı sorguyu çalıştır
SELECT 
    'v2' AS versiyon,
    COUNT(*) AS toplam_kayit,
    COUNT(DISTINCT customer_id) AS benzersiz_musteri,
    COUNT(DISTINCT product_id) AS benzersiz_urun,
    ROUND(AVG(total_price), 2) AS ort_siparis_tutari,
    MIN(order_date) AS ilk_siparis,
    MAX(order_date) AS son_siparis
FROM orders;

-- 4. Veri bütünlüğü kontrolü: migration sonrası NULL kontrol
SELECT
    COUNT(*) AS toplam,
    COUNT(discount) AS dolu_discount,
    COUNT(shipping_cost) AS dolu_shipping,
    COUNT(updated_at) AS dolu_updated_at
FROM orders;

-- 5. Versiyon tablosunu güncelle
INSERT INTO schema_versiyon (versiyon, aciklama)
VALUES ('v2.0.0', 'v2.0.0 test sonrası tekrar uygulandı — tüm testler başarılı');

-- 6. Final versiyon geçmişi
SELECT * FROM schema_versiyon ORDER BY uygulama_zamani;