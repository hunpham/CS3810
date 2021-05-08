-- occupations database
-- created at: April 8 2021
-- author: Hung Pham

DROP DATABASE products;
CREATE DATABASE products;

USE occupations;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descr VARCHAR(30) NOT NULL,
    price FLOAT NOT NULL,
    cond VARCHAR(30) NOT NULL DEFAULT 'new'
);

DELIMITER |
CREATE TRIGGER product_cond_else
  BEFORE INSERT
  ON Products
  FOR EACH ROW
  BEGIN
    IF NEW.cond NOT LIKE 'new' AND NEW.cond NOT LIKE 'used' THEN
      SET NEW.cond = 'new';
    END IF;
  END
|
DELIMITER ;

INSERT INTO Products (descr, price, cond) VALUES ('Ninja Sword', 250, 'new');
INSERT INTO Products (descr, price, cond) VALUES ('Dummy', 50, 'new');
INSERT INTO Products (descr, price, cond) VALUES ('Fake Blood', 5, 'used');
INSERT INTO Products (descr, price, cond) VALUES ('Rubber Ducky', 1, 'used');
INSERT INTO Products (descr, price, cond) VALUES ('Bathtub Soap', 3, 'used once');
INSERT INTO Products (descr, price, cond) VALUES ('Brazilian Coffee', 5, 'new');
INSERT INTO Products (descr, price, cond) VALUES ('Running Shoes', 50, 'fair');
-- INSERT INTO Products (descr, price, cond) VALUES ('Running Shoes', 56, '');
-- INSERT INTO Products (descr, price, cond) VALUES ('WAH', 56, 'USED');