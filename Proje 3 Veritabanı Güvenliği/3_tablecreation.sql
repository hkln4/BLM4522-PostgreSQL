-- clean_hr tablosunu bu veritabanında oluştur
CREATE TABLE hr_data (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    salary NUMERIC(10,2),
    gender VARCHAR(20),
    department VARCHAR(50),
    position VARCHAR(50),
    joining_date DATE,
    performance_score VARCHAR(5),
    email TEXT,
    phone_number VARCHAR(20),
    loaded_at TIMESTAMP DEFAULT NOW()
);