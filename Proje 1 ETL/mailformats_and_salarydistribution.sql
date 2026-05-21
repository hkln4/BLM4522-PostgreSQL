-- 1. Geçersiz email formatları
SELECT "Email", COUNT(*) AS adet
FROM staging_hr
WHERE "Email" IS NOT NULL
  AND TRIM("Email") != ''
  AND TRIM("Email") != 'nan'
  AND (
    "Email" NOT LIKE '%@%'
    OR "Email" NOT LIKE '%.%'
  )
GROUP BY "Email"
ORDER BY adet DESC;

-- 2. Geçerli / geçersiz / boş email özeti
SELECT
    SUM(CASE WHEN TRIM("Email") ~ '^[^@]+@[^@]+\.[^@]+$' THEN 1 ELSE 0 END) AS gecerli_email,
    SUM(CASE WHEN TRIM("Email") = 'nan' OR TRIM("Email") = '' OR "Email" IS NULL THEN 1 ELSE 0 END) AS bos_email,
    SUM(CASE WHEN TRIM("Email") !~ '^[^@]+@[^@]+\.[^@]+$'
        AND TRIM("Email") != 'nan' AND TRIM("Email") != '' AND "Email" IS NOT NULL THEN 1 ELSE 0 END) AS gecersiz_email
FROM staging_hr;

-- 3. Salary aralık kontrolü
SELECT
    SUM(CASE WHEN "Salary" ~ '^\d+$' AND "Salary"::NUMERIC < 0 THEN 1 ELSE 0 END