-- Sadece grace'leri getirir, beklenen davranış
SELECT id, name, department, salary 
FROM hr_data 
WHERE TRIM(name) = 'grace';


-- Saldırgan 'grace' yerine bunu gönderdi
-- OR '1'='1' her zaman TRUE olduğu için WHERE koşulu devre dışı kalır
-- Tüm çalışanların salary bilgisi sızdı!
SELECT id, name, department, salary 
FROM hr_data 
WHERE TRIM(name) = 'grace' OR '1'='1';


-- KORUNMA YÖNTEMİ 1: Tek tırnak escape etme
-- Saldırganın girdisi artık SQL kodu değil, string olarak işlenir
SELECT id, name, department, salary 
FROM hr_data 
WHERE TRIM(name) = 'grace'' OR ''1''=''1';
-- Sonuç: 0 satır — injection etkisiz kaldı

-- KORUNMA YÖNTEMİ 2: Kullanıcı yetkilerini kısıtlama
-- hr_readonly sadece belirli sütunları görebilir
-- Injection başarılı olsa bile salary, email, phone göremez
SELECT grantee, column_name, privilege_type
FROM information_schema.column_privileges
WHERE table_name = 'hr_data'
  AND grantee = 'hr_readonly'
ORDER BY column_name;

-- KORUNMA YÖNTEMİ 3: Girdi doğrulama
-- Sadece harf içeren name değerlerini kabul et
SELECT id, name, department, salary
FROM hr_data
WHERE TRIM(name) ~ '^[a-zA-Z ]+$'
  AND TRIM(name) = 'grace';