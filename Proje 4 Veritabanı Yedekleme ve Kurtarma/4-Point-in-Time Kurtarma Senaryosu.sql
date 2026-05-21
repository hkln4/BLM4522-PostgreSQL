-- 1. Şu anki zamanı kaydet (kurtarma noktası)
SELECT NOW() AS kurtarma_noktasi;

-- 2. Yeni siparişler ekle (bu ekleme "hatalı" olacak)
INSERT INTO orders (customer_id, product_id, quantity, order_date, status, total_price)
SELECT
    floor(random() * 1000 + 1)::INTEGER,
    floor(random() * 500 + 1)::INTEGER,
    floor(random() * 10 + 1)::INTEGER,
    DATE '2024-01-01' + (random() * 100)::INTEGER,
    'pending',
    (random() * 5000 + 10)::NUMERIC(10,2)
FROM generate_series(1, 10000);

-- 3. Ekleme sonrası kayıt sayısını kontrol et
SELECT COUNT(*) AS ekleme_sonrasi FROM orders;

-- 4. Hatalı eklemeyi geri al (kurtarma noktasına dön)
-- Bu senaryoda timestamp filtreyle eski veriyi koruyoruz
DELETE FROM orders WHERE order_date > '2023-12-31';

-- 5. Kurtarma sonrası kayıt sayısını kontrol et
SELECT COUNT(*) AS kurtarma_sonrasi FROM orders;