DROP ROLE IF EXISTS admin_user;
DROP ROLE IF EXISTS readonly_user;

CREATE USER admin_user WITH PASSWORD 'admin_password' SUPERUSER;
CREATE USER readonly_user WITH PASSWORD 'readonly_password';

GRANT CONNECT ON DATABASE tp_multilang_db TO readonly_user;

GRANT SELECT ON notes TO readonly_user;
