-- 1. Şema değişikliklerini loglayacak tablo
CREATE TABLE schema_log (
    id SERIAL PRIMARY KEY,
    islem_zamani TIMESTAMP DEFAULT NOW(),
    kullanici TEXT DEFAULT CURRENT_USER,
    islem_turu TEXT,
    nesne_turu TEXT,
    nesne_adi TEXT,
    sorgu TEXT
);

-- 2. DDL trigger fonksiyonu
CREATE OR REPLACE FUNCTION schema_degisiklik_log()
RETURNS EVENT_TRIGGER AS $$
DECLARE
    obj RECORD;
BEGIN
    FOR obj IN SELECT * FROM pg_event_trigger_ddl_commands()
    LOOP
        INSERT INTO schema_log (islem_turu, nesne_turu, nesne_adi, sorgu)
        VALUES (
            TG_EVENT,
            obj.object_type,
            obj.object_identity,
            current_query()
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- 3. Event trigger'ı oluştur
CREATE EVENT TRIGGER schema_degisiklik_trigger
ON ddl_command_end
EXECUTE FUNCTION schema_degisiklik_log();

-- 4. Trigger'ı doğrula
SELECT evtname, evtevent, evtenabled
FROM pg_event_trigger
WHERE evtname = 'schema_degisiklik_trigger';