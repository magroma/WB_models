-- Anlegen der Tabelle
CREATE TABLE IF NOT EXISTS `mydb`.`cats` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Inserts
INSERT INTO `mydb`.`cats` (`name`, `age`) VALUES ("Alonzo", 35);
INSERT INTO `mydb`.`cats` (`name`, `age`) VALUES ("Grizabella", 29);

SELECT * FROM cats;