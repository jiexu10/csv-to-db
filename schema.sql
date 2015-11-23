-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

DROP TABLE IF EXISTS csvdata;

-- Define your schema here:

CREATE TABLE csvdata (
  id SERIAL PRIMARY KEY,
  ingredient VARCHAR(255)
);
