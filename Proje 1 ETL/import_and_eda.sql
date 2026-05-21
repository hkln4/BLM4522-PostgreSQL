DROP TABLE staging_hr;

CREATE TABLE staging_hr (
    "Name" TEXT,
    "Age" TEXT,
    "Salary" TEXT,
    "Gender" TEXT,
    "Department" TEXT,
    "Position" TEXT,
    "Joining Date" TEXT,
    "Performance Score" TEXT,
    "Email" TEXT,
    "Phone Number" TEXT
);

SELECT * FROM staging_hr LIMIT 10;

-- total kayıt
SELECT COUNT(*) FROM staging_hr;

-- Age'deki kirli veriler
SELECT DISTINCT "Age" FROM staging_hr;

-- Salary'daki kirli veriler
SELECT DISTINCT "Salary" FROM staging_hr;

-- Joining Date formatları
SELECT DISTINCT "Joining Date" FROM staging_hr;

-- Boş email'ler
SELECT COUNT(*) FROM staging_hr WHERE "Email" IS NULL OR TRIM("Email") = '' OR "Email" = 'nan';