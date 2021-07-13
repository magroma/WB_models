-- DB löschen / neu anlegen / aktivieren
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS `mydb`.`testuser` (
  `username` VARCHAR(16) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
ENGINE = InnoDB;

INSERT INTO `mydb`.`testuser` (`username`) VALUES ("Peter");
INSERT INTO `mydb`.`testuser` (`username`) VALUES ("Stephan");
INSERT INTO `mydb`.`testuser` (`username`) VALUES ("Stephan");
INSERT INTO `mydb`.`testuser` (`username`) VALUES ("Jennifer");

-- Inhalt der Tab. anzeigen
SELECT * FROM testuser;
