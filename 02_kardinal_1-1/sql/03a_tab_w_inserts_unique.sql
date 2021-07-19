-- 3. verbundene Tabellen + Inserts

-- Vorbereitung
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;
USE mydb;

-- Mastertabelle: unverändert
CREATE TABLE IF NOT EXISTS `mydb`.`cats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cat_name` VARCHAR(45) NOT NULL,
  `fur_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Struktur
DESCRIBE cats;

-- Inserts: MT (Mastertabelle)
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Grizabella", "white");
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Alonzu", "grey");
INSERT INTO `mydb`.`cats` (`id`, `cat_name`, `fur_color`) VALUES (DEFAULT, "Mausi", "striped");

-- Inhalte: MT
SELECT * FROM cats;

-- Detailtabelle
CREATE TABLE IF NOT EXISTS `mydb`.`servants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servant_name` VARCHAR(45) NOT NULL,
  `yrs_served` INT NOT NULL,
  `cats_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servants_cats_idx` (`cats_id` ASC) VISIBLE,
  UNIQUE INDEX `cats_id_UNIQUE` (`cats_id` ASC) VISIBLE,
  CONSTRAINT `fk_servants_cats`
    FOREIGN KEY (`cats_id`)
    REFERENCES `mydb`.`cats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE servants;

-- Inserts: DT
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Peter", 5, 1);
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Hans", 2, 2);
INSERT INTO `mydb`.`servants` (`id`, `servant_name`, `yrs_served`, `cats_id`) VALUES (DEFAULT, "Kall", 3, 1);



SELECT * FROM servants;