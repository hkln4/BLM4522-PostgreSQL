-- Rolleri oluştur
CREATE ROLE hr_readonly LOGIN PASSWORD 'readonly123';
CREATE ROLE hr_analyst LOGIN PASSWORD 'analyst123';
CREATE ROLE hr_manager LOGIN PASSWORD 'manager123';
CREATE ROLE hr_admin LOGIN PASSWORD 'admin123';

-- hr_readonly: sadece genel bilgilere erişim (hassas sütunlar hariç)
GRANT CONNECT ON DATABASE dbguvenligi_erisimkontrolu TO hr_readonly;
GRANT USAGE ON SCHEMA public TO hr_readonly;
GRANT SELECT (id, name, department, position, performance_score, joining_date) 
    ON hr_data TO hr_readonly;

-- hr_analyst: salary görebilir ama email/phone göremez
GRANT CONNECT ON DATABASE dbguvenligi_erisimkontrolu TO hr_analyst;
GRANT USAGE ON SCHEMA public TO hr_analyst;
GRANT SELECT (id, name, age, salary, department, position, performance_score, joining_date) 
    ON hr_data TO hr_analyst;

-- hr_manager: tüm sütunları görebilir, veri ekleyebilir/güncelleyebilir
GRANT CONNECT ON DATABASE dbguvenligi_erisimkontrolu TO hr_manager;
GRANT USAGE ON SCHEMA public TO hr_manager;
GRANT SELECT, INSERT, UPDATE ON hr_data TO hr_manager;

-- hr_admin: tam yetki
GRANT CONNECT ON DATABASE dbguvenligi_erisimkontrolu TO hr_admin;
GRANT USAGE ON SCHEMA public TO hr_admin;
GRANT ALL PRIVILEGES ON hr_data TO hr_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO hr_admin;

-- Rolleri doğrula
SELECT rolname, rolcanlogin, rolsuper
FROM pg_roles
WHERE rolname IN ('hr_readonly', 'hr_analyst', 'hr_manager', 'hr_admin');


-- Sütun bazlı yetkileri doğrula
SELECT grantee, column_name, privilege_type
FROM information_schema.column_privileges
WHERE table_name = 'hr_data'
  AND grantee IN ('hr_readonly', 'hr_analyst', 'hr_manager', 'hr_admin')
ORDER BY grantee, column_name;