-- Önce mevcut boş salary sayısını kontrol et
SELECT COUNT(*) AS bos_salary FROM clean_hr WHERE salary IS NULL;

-- Departman + pozisyon ortalamasıyla doldur
UPDATE clean_hr c
SET salary = (
    SELECT ROUND(AVG(c2.salary), 2)
    FROM clean_hr c2
    WHERE c2.department = c.department
      AND c2.position = c.position
      AND c2.salary IS NOT NULL
)
WHERE c.salary IS NULL;

-- Güncelleme sonrası boş salary sayısını kontrol et
SELECT COUNT(*) AS bos_salary FROM clean_hr WHERE salary IS NULL;