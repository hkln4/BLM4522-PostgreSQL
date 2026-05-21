-- 1. Aynı isim + email kombinasyonundan kaç tane var
SELECT "Name", "Email", COUNT(*) AS adet
FROM staging_hr
GROUP BY "Name", "Email"
HAVING COUNT(*) > 1
ORDER BY adet DESC;

-- 2. Toplam duplicate kayıt sayısı
SELECT COUNT(*) AS toplam_duplicate
FROM (
    SELECT "Name", "Email"
    FROM staging_hr
    GROUP BY "Name", "Email"
    HAVING COUNT(*) > 1
) t;