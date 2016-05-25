CREATE TABLE affiliates (
  id INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(255) NOT NULL,
  link VARCHAR(255),
  instructions TEXT,
  price_tax TINYINT(2) DEFAULT 0,
  price_discount_tax TINYINT(2) DEFAULT 0,
  status TINYINT(2) DEFAULT 0,
  create_time DATETIME NOT NULL,
  update_time DATETIME NOT NULL,
  delete_flag TINYINT(2) DEFAULT 0,
  PRIMARY KEY (id)
);
