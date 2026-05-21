-- 1. Geri yüklenen verinin bütünlüğünü kontrol et
SELECT 
    COUNT(*) AS toplam_kayit,
    MIN(order_date) AS en_eski_siparis,
    MAX(order_date) AS en_yeni_siparis,
    ROUND(AVG(total_price), 2) AS ortalama_fiyat,
    SUM(total_price) AS toplam_ciro
FROM orders;

-- 2. Status dağılımı
SELECT status, COUNT(*) AS adet
FROM orders
GROUP BY status
ORDER BY adet DESC;

-- 3. Müşteri başına sipariş sayısı (ilk 5)
SELECT customer_id, COUNT(*) AS siparis_sayisi
FROM orders
GROUP BY customer_id
ORDER BY siparis_sayisi DESC
LIMIT 5;

-- 4. Ürün başına satış toplamı (ilk 5)
SELECT product_id, SUM(total_price) AS toplam_satis
FROM orders
GROUP BY product_id
ORDER BY toplam_satis DESC
LIMIT 5;