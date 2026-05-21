-- Silmeden önce kayıt sayısını kontrol et
SELECT COUNT(*) AS silinmeden_once FROM orders;

-- Kaza ile tüm orders verisini sil
DELETE FROM orders;

-- Silindikten sonra kontrol et
SELECT COUNT(*) AS silindikten_sonra FROM orders;


-- Geri yükleme sonrası kontrol
SELECT COUNT(*) AS geri_yukleme_sonrasi FROM orders;