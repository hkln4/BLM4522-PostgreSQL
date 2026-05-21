-- Rolleri oluştur
CREATE ROLE readonly_user LOGIN PASSWORD 'readonly123';
CREATE ROLE analyst_user LOGIN PASSWORD 'analyst123';
CREATE ROLE manager_user LOGIN PASSWORD 'manager123';

-- readonly_user: sadece okuma yetkisi
GRANT CONNECT ON DATABASE performans_proje TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- analyst_user: okuma + sorgulama yetkisi
GRANT CONNECT ON DATABASE performans_proje TO analyst_user;
GRANT USAGE ON SCHEMA public TO analyst_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analyst_user;
GRANT SELECT ON orders, customers, products TO analyst_user;

-- manager_user: tam yetki
GRANT CONNECT ON DATABASE performans_proje TO manager_user;
GRANT USAGE ON SCHEMA public TO manager_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO manager_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO manager_user;

-- Rolleri doğrula
SELECT rolname, rolcanlogin, rolsuper 
FROM pg_roles 
WHERE rolname IN ('readonly_user', 'analyst_user', 'manager_user');


-- Yetkileri doğrula
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('readonly_user', 'analyst_user', 'manager_user')
ORDER BY grantee, table_name;