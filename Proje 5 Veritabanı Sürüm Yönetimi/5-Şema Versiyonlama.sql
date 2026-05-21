-- Migration geçmişini tutacak tablo
CREATE TABLE schema_versiyon (
    id SERIAL PRIMARY KEY,
    versiyon VARCHAR(20),
    aciklama TEXT,
    uygulayan TEXT DEFAULT CURRENT_USER,
    uygulama_zamani TIMESTAMP DEFAULT NOW(),
    durum VARCHAR(20) DEFAULT 'BAŞARILI'
);

-- v1 başlangıç durumunu kaydet
INSERT INTO schema_versiyon (versiyon, aciklama)
VALUES ('v1.0.0', 'Başlangıç şeması: customers, orders, products tabloları');

SELECT * FROM schema_versiyon;