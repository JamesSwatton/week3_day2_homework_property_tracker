DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker (
  id SERIAL4 PRIMARY KEY,
  value INT4,
  number_bedrooms INT4,
  year_built INT4,
  buy_let_status VARCHAR(255)
);
