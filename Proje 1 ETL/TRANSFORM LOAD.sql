INSERT INTO clean_hr (
    name, age, salary, gender, department, position,
    joining_date, performance_score, email, phone_number
)
SELECT
    -- Name: baştaki/sondaki boşlukları temizle
    TRIM("Name"),

    -- Age: 'nan' ve 'thirty' gibi metin değerleri NULL yap, geçerli sayıları integer'a çevir
    CASE
        WHEN TRIM("Age") ~ '^\d+$' THEN TRIM("Age")::INTEGER
        ELSE NULL
    END,

    -- Salary: 'NAN' → NULL, 'SIXTY THOUSAND' → 60000
    CASE
        WHEN TRIM("Salary") = 'NAN' THEN NULL
        WHEN TRIM("Salary") = 'SIXTY THOUSAND' THEN 60000
        WHEN TRIM("Salary") ~ '^\d+$' THEN TRIM("Salary")::NUMERIC
        ELSE NULL
    END,

    -- Gender: olduğu gibi
    TRIM("Gender"),
    -- Department
    TRIM("Department"),
    -- Position
    TRIM("Position"),

    -- Joining Date: 5 farklı formatı standart DATE'e çevir
    CASE
        WHEN "Joining Date" ~ '^\d{4}/\d{2}/\d{2}$' 
            THEN TO_DATE("Joining Date", 'YYYY/MM/DD')
        WHEN "Joining Date" ~ '^\d{2}/\d{2}/\d{4}$' 
            THEN TO_DATE("Joining Date", 'MM/DD/YYYY')
        WHEN "Joining Date" ~ '^\d{4}\.\d{2}\.\d{2}$' 
            THEN TO_DATE("Joining Date", 'YYYY.MM.DD')
        WHEN "Joining Date" ~ '^\d{2}-\d{2}-\d{4}$' 
            THEN TO_DATE("Joining Date", 'MM-DD-YYYY')
        WHEN "Joining Date" ~ '^[A-Za-z]+ \d+, \d{4}$' 
            THEN TO_DATE("Joining Date", 'Month DD, YYYY')
        ELSE NULL
    END,
    -- Performance Score
    TRIM("Performance Score"),

    -- Email: boş, 'nan', sadece boşluk → NULL
    CASE
        WHEN TRIM("Email") = '' OR TRIM("Email") = 'nan' OR "Email" IS NULL 
            THEN NULL
        ELSE TRIM("Email")
    END,

    -- Phone: boş, 'nan', sadece boşluk → NULL
    CASE
        WHEN TRIM("Phone Number") = '' OR TRIM("Phone Number") = 'nan' OR "Phone Number" IS NULL 
            THEN NULL
        ELSE TRIM("Phone Number")
    END

FROM staging_hr;


SELECT * FROM clean_hr LIMIT 20;