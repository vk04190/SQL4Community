-- Droping a View
DROP VIEW OR_DB_SCHEMA.any_random_view;

-- CREATE a View
CREATE OR REPLACE VIEW OR_DB_SCHEMA.any_random_view
AS
    SELECT -- FIXED PARAMETER
          src.date_code date_code
         , src.code code
              FROM OR_DB_SCHEMA.dwh_any_random_table
     WHERE     src.code = 'XT153';