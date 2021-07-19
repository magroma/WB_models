
-- 2. verbundene Tabellen + Inserts

-- Vorbereitung
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

/* cats */
-- cats: CREATE

CREATE TABLE IF NOT EXISTS `mydb`.`cats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cat_name` VARCHAR(45) NOT NULL,
  `fur_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- cats: Struktur
#DESCRIBE cats;

-- cats: inserts
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Grizabella", "white");
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Mausi", "striped");

-- cats: Inhalte
SELECT * FROM cats;

/* Servants */
-- Servants: CREATE
CREATE TABLE IF NOT EXISTS `mydb`.`servants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servant_name` VARCHAR(45) NOT NULL,
  `yrs_served` INT NOT NULL,
  `cats_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servants_cats1_idx` (`cats_id` ASC) VISIBLE,
  UNIQUE INDEX `cats_id_UNIQUE` (`cats_id` ASC) VISIBLE,
  CONSTRAINT `fk_servants_cats1`
    FOREIGN KEY (`cats_id`)
    REFERENCES `mydb`.`cats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Servants: Struktur
#DESCRIBE servants;

-- servants inserts
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Peter", 4, 1);
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Georg", 2, 2);

-- Servants: Inhalte
SELECT * FROM servants;

/* Products */
-- Products: CREATE
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Products: Struktur
#DESCRIBE products;

-- Products: inserts
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (DEFAULT, "Whiskas mit Lachs", 2.75);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (DEFAULT, "Whiskas mit Huhn", 2.95);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (DEFAULT, "Felix mit Jelly", 3.55);
INSERT INTO `mydb`.`products` (`id`, `product_name`, `product_price`) VALUES (DEFAULT, "Felix mit Soße", 3.49);

-- Products: Inhalte
SELECT * FROM products;

/* Purchases (Kaufprozesse) */

-- Purchases: CREATE
CREATE TABLE IF NOT EXISTS `mydb`.`purchases` (
  `servants_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`servants_id`, `products_id`),
  INDEX `fk_servants_has_products_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_servants_has_products_servants_idx` (`servants_id` ASC) VISIBLE,
  CONSTRAINT `fk_servants_has_products_servants`
    FOREIGN KEY (`servants_id`)
    REFERENCES `mydb`.`servants` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servants_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mydb`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Purchases: Struktur
#DESCRIBE purchases;

-- Purchases inserts
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (1, 2);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (1, 3);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2, 1);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2, 2);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2, 3);
INSERT INTO `mydb`.`purchases` (`servants_id`, `products_id`) VALUES (2, 4);

-- Purchases: Inhalte
SELECT * FROM purchases;
