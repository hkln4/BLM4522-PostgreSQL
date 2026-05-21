-- Index OLMADAN sorgu performansı ölçümü

-- 1. Tarihe göre sipariş sorgulama
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31';

-- 2. Müşteriye göre sipariş sorgulama
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE customer_id = 500;

-- 3. Ürün kategorisine göre satış toplamı
EXPLAIN ANALYZE
SELECT p.category, SUM(o.total_price) AS toplam_satis
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- 4. Duruma göre sipariş sayısı
EXPLAIN ANALYZE
SELECT status, COUNT(*) FROM orders
GROUP BY status;