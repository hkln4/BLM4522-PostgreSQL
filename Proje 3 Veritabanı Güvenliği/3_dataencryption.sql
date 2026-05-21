-- Script 2: Veri Şifreleme (pgcrypto)

-- pgcrypto extension'ını yükle
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Şifrelenmiş sütunlar için yeni tablo oluştur
ALTER TABLE hr_data 
    ADD COLUMN email_encrypted BYTEA,
    ADD COLUMN phone_encrypted BYTEA,
    ADD COLUMN salary_encrypted BYTEA;

-- Mevcut verileri şifrele (AES-256 ile)
UPDATE hr_data
SET 
    email_encrypted = pgp_sym_encrypt(COALESCE(email, ''), 'gizli_anahtar_2024'),
    phone_encrypted = pgp_sym_encrypt(COALESCE(phone_number, ''), 'gizli_anahtar_2024'),
    salary_encrypted = pgp_sym_encrypt(COALESCE(salary::TEXT, ''), 'gizli_anahtar_2024');

-- Şifrelemeyi doğrula: şifreli ve çözülmüş halini karşılaştır
SELECT 
    name,
    email AS orijinal_email,
    pgp_sym_decrypt(email_encrypted, 'gizli_anahtar_2024') AS cozulmus_email,
    salary AS orijinal_salary,
    pgp_sym_decrypt(salary_encrypted, 'gizli_anahtar_2024') AS cozulmus_salary
FROM hr_data
LIMIT 5;