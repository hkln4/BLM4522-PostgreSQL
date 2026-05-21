-- 1. Genel kayıt sayısı
SELECT COUNT(*) AS toplam_kayit FROM clean_hr;

-- 2. NULL değer sayıları (her sütun için)
SELECT
    COUNT(*) - COUNT(name) AS bos_name,
    COUNT(*) - COUNT(age) AS bos_age,
    COUNT(*) - COUNT(salary) AS bos_salary,
    COUNT(*) - COUNT(email) AS bos_email,
    COUNT(*) - COUNT(phone_number) AS bos_phone,
    COUNT(*) - COUNT(joining_date) AS bos_joining_date
FROM clean_hr;

-- 3. Yaş dağılımı
SELECT MIN(age), MAX(age), ROUND(AVG(age),1) AS ort_yas
FROM clean_hr;

-- 4. Maaş dağılımı
SELECT MIN(salary), MAX(salary), ROUND(AVG(salary),2) AS ort_maas
FROM clean_hr WHERE salary IS NOT NULL;

-- 5. Departmana göre çalışan sayısı
SELECT department, COUNT(*) AS calisan_sayisi
FROM clean_hr
GROUP BY department
ORDER BY calisan_sayisi DESC;

-- 6. Performance score dağılımı
SELECT performance_score, COUNT(*) AS adet
FROM clean_hr
GROUP BY performance_score
ORDER BY performance_score;

-- 7. Joining date yıllara göre dağılım
SELECT EXTRACT(YEAR FROM joining_date) AS yil, COUNT(*) AS adet
FROM clean_hr
WHERE joining_date IS NOT NULL
GROUP BY yil
ORDER BY yil;