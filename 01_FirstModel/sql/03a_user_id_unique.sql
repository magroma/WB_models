-- DB löschen / neu anlegen / aktivieren
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS `mydb`.`testuser_w_id_unique` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;

-- Struktur anzeigen
DESCRIBE mydb.testuser_w_id_unique;

INSERT INTO `mydb`.`testuser_w_id_unique` (`username`) VALUES ("Peter");
INSERT INTO `mydb`.`testuser_w_id_unique` (`username`) VALUES ("Stephan");
INSERT INTO `mydb`.`testuser_w_id_unique` (`username`) VALUES ("Stephan1");
INSERT INTO `mydb`.`testuser_w_id_unique` (`username`) VALUES ("Jennifer");

-- Inhalt der Tab. anzeigen
SELECT * FROM testuser_w_id_unique;