-- Yedekleme loglarını tutacak tablo
CREATE TABLE yedekleme_log (
    id SERIAL PRIMARY KEY,
    yedek_turu VARCHAR(50),
    veritabani VARCHAR(100),
    dosya_adi VARCHAR(200),
    dosya_boyutu VARCHAR(20),
    baslangic_zamani TIMESTAMP,
    bitis_zamani TIMESTAMP,
    durum VARCHAR(20),
    aciklama TEXT
);

-- Gerçekleştirdiğimiz yedekleme işlemlerini loga ekle
INSERT INTO yedekleme_log 
    (yedek_turu, veritabani, dosya_adi, dosya_boyutu, baslangic_zamani, bitis_zamani, durum, aciklama)
VALUES
    ('TAM', 'performans_proje', 'tam_yedek_20260521.backup', '14 MB', 
     '2026-05-21 18:38:00', '2026-05-21 18:38:45', 'BAŞARILI', 'Şema + tüm veriler'),
    ('ŞEMA', 'performans_proje', 'sema_yedek.backup', '9.4 KB',
     '2026-05-21 18:39:00', '2026-05-21 18:39:01', 'BAŞARILI', 'Sadece tablo yapıları'),
    ('VERİ', 'performans_proje', 'veri_yedek.backup', '14 MB',
     '2026-05-21 18:39:10', '2026-05-21 18:39:55', 'BAŞARILI', 'Sadece veri'),
    ('TABLO', 'performans_proje', 'orders_yedek.backup', '14 MB',
     '2026-05-21 18:40:00', '2026-05-21 18:40:40', 'BAŞARILI', 'Sadece orders tablosu');

-- Logu görüntüle
SELECT * FROM yedekleme_log ORDER BY baslangic_zamani;