SELECT
    'staging_hr' AS tablo,
    COUNT(*) AS toplam_kayit,
    SUM(CASE WHEN "Age" IS NULL OR TRIM("Age") = 'nan' OR TRIM("Age") = 'thirty' THEN 1 ELSE 0 END) AS bos_age,
    SUM(CASE WHEN "Salary" IS NULL OR TRIM("Salary") = 'NAN' OR TRIM("Salary") = 'SIXTY THOUSAND' THEN 1 ELSE 0 END) AS bos_salary,
    SUM(CASE WHEN "Email" IS NULL OR TRIM("Email") = '' OR TRIM("Email") = 'nan' THEN 1 ELSE 0 END) AS bos_email,
    SUM(CASE WHEN "Phone Number" IS NULL OR TRIM("Phone Number") = '' OR TRIM("Phone Number") = 'nan' THEN 1 ELSE 0 END) AS bos_phone
FROM staging_hr

UNION ALL

SELECT
    'clean_hr' AS tablo,
    COUNT(*) AS toplam_kayit,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS bos_age,
    SUM(CASE WHEN salary IS NULL THEN 1 ELSE 0 END) AS bos_salary,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS bos_email,
    SUM(CASE WHEN phone_number IS NULL THEN 1 ELSE 0 END) AS bos_phone
FROM clean_hr;