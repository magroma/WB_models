CREATE TABLE IF NOT EXISTS `mydb`.`cats` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

#INSERT INTO `mydb`.`cats` (`id`, `name`, `age`) VALUES (NULL, NULL, NULL);

