-- 1. Audit için log tablosu oluştur
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    islem_zamani TIMESTAMP DEFAULT NOW(),
    kullanici TEXT DEFAULT CURRENT_USER,
    islem_turu TEXT,
    tablo_adi TEXT,
    etkilenen_id INTEGER,
    eski_deger TEXT,
    yeni_deger TEXT
);

-- 2. hr_data tablosuna trigger fonksiyonu oluştur
CREATE OR REPLACE FUNCTION audit_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (islem_turu, tablo_adi, etkilenen_id, yeni_deger)
        VALUES ('INSERT', TG_TABLE_NAME, NEW.id, 
                'name: ' || NEW.name || ', department: ' || NEW.department);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (islem_turu, tablo_adi, etkilenen_id, eski_deger, yeni_deger)
        VALUES ('UPDATE', TG_TABLE_NAME, NEW.id,
                'salary: ' || OLD.salary,
                'salary: ' || NEW.salary);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log (islem_turu, tablo_adi, etkilenen_id, eski_deger)
        VALUES ('DELETE', TG_TABLE_NAME, OLD.id,
                'name: ' || OLD.name || ', department: ' || OLD.department);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- 3. Trigger'ı hr_data tablosuna bağla
CREATE TRIGGER hr_data_audit
AFTER INSERT OR UPDATE OR DELETE ON hr_data
FOR EACH ROW EXECUTE FUNCTION audit_trigger_func();
-- 4. Trigger'ı doğrula
SELECT trigger_name, event_manipulation, event_object_table
FROM information_schema.triggers
WHERE event_object_table = 'hr_data';

SELECT setval('hr_data_id_seq', (SELECT MAX(id) FROM hr_data));
-- 5. Trigger'ı test et

-- INSERT testi
INSERT INTO hr_data (name, age, salary, gender, department, position, joining_date, performance_score, email, phone_number)
VALUES ('Test User', 30, 55000, 'Male', 'IT', 'Engineer', '2023-01-01', 'A', 'test@test.com', '1234567890');

-- UPDATE testi
UPDATE hr_data SET salary = 60000 WHERE name = 'Test User';

-- DELETE testi
DELETE FROM hr_data WHERE name = 'Test User';

-- Audit log'u görüntüle
SELECT * FROM audit_log ORDER BY islem_zamani DESC LIMIT 10;