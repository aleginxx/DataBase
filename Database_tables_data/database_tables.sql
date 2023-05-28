SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
Drop schema if exists `mydb`;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Central_Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Central_Manager` (
  `username_cm` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username_cm`),
  UNIQUE INDEX `usernameCM_UNIQUE` (`username_cm` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Library_Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Library_Manager` (
  `username_libm` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`username_libm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`School_Unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`School_Unit` (
  `phone_number` VARCHAR(30) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `principal_name` VARCHAR(45) NOT NULL,
  `username_libm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phone_number`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC)  ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)  ,
  UNIQUE INDEX `username_libm_UNIQUE` (`username_libm` ASC)  ,
  CONSTRAINT `username_libm`
    FOREIGN KEY (`username_libm`)
    REFERENCES `mydb`.`Library_Manager` (`username_libm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (
  `isbn` VARCHAR(12) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `publisher` VARCHAR(45) NOT NULL,
  `no_of_pages` INT NOT NULL,
  `available_copies` INT NOT NULL,
  `image` VARCHAR(30),
  `language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`isbn`),
  UNIQUE INDEX `isbn_UNIQUE` (`isbn` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE INDEX `author_id_UNIQUE` (`author_id` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`key_word`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`key_word` (
  `kw_id` INT NOT NULL AUTO_INCREMENT,
  `phrase` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`kw_id`),
  UNIQUE INDEX `kw_id_UNIQUE` (`kw_id` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE INDEX `genre_id_UNIQUE` (`genre_id` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`School_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`School_User` (
  `username_su` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birth_date` date NOT NULL,
  `role` VARCHAR(1) NOT NULL CHECK (`role` IN ('T','S')),
  `phone_number` VARCHAR(30) NOT NULL,
  `is_lm` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`username_su`),
  UNIQUE INDEX `username_su_UNIQUE` (`username_su` ASC),
  CONSTRAINT `phone_number`
    FOREIGN KEY (`phone_number`)
    REFERENCES `mydb`.`School_Unit` (`phone_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_Demand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book_Demand` (
  `category` VARCHAR(45) NOT NULL CHECK (`category` IN ('R','B')),
  `username_su` VARCHAR(45) NOT NULL,
  `datetime` date NOT NULL,
  `isbn` VARCHAR(12) NOT NULL,
  `username_libm` VARCHAR(45) NOT NULL, 
  PRIMARY KEY (`username_su`, `isbn`),
  INDEX `isbn_idx` (`isbn` ASC)  ,
  INDEX `username_libm_UNIQUE_BD` (`username_libm` ASC)  ,
  CONSTRAINT `fk_username_su_BD` 
    FOREIGN KEY (`username_su`)
    REFERENCES `mydb`.`School_User` (`username_su`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_isbn_BD` 
    FOREIGN KEY (`isbn`)
    REFERENCES `mydb`.`Book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_username_libm_BD` 
    FOREIGN KEY (`username_libm`)
    REFERENCES `mydb`.`Library_Manager` (`username_libm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    
      
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `isbn` VARCHAR(12) NOT NULL,
  `username_su` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `rating` INT NOT NULL CHECK (`rating` IN (1, 2, 3, 4, 5)),
  `username_libm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`isbn`, `username_su`),
  INDEX `username_su_idx` (`username_su` ASC),
  INDEX `username_libm_UNIQUE_R` (`username_libm` ASC),
  CONSTRAINT `fk_isbn`
    FOREIGN KEY (`isbn`)
    REFERENCES `mydb`.`Book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_username_su`
    FOREIGN KEY (`username_su`)
    REFERENCES `mydb`.`School_User` (`username_su`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_username_libm_R`
    FOREIGN KEY (`username_libm`)
    REFERENCES `mydb`.`Library_Manager` (`username_libm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    
    
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_has_key_word`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book_has_key_word` (
  `Book_isbn` VARCHAR(12) NOT NULL,
  `key_word_kw_id` INT NOT NULL,
  PRIMARY KEY (`Book_isbn`, `key_word_kw_id`),
  INDEX `fk_Book_has_key_word_key_word1_idx` (`key_word_kw_id` ASC)  ,
  INDEX `fk_Book_has_key_word_Book1_idx` (`Book_isbn` ASC)  ,
  CONSTRAINT `fk_Book_has_key_word_Book1`
    FOREIGN KEY (`Book_isbn`)
    REFERENCES `mydb`.`Book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_key_word_key_word1`
    FOREIGN KEY (`key_word_kw_id`)
    REFERENCES `mydb`.`key_word` (`kw_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_has_Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book_has_Genre` (
  `Book_isbn` VARCHAR(12) NOT NULL,
  `Genre_genre_id` INT NOT NULL,
  INDEX `idx_Book_isbn` (`Book_isbn` ASC),
  CONSTRAINT `fk_Book_has_Genre_Book`
    FOREIGN KEY (`Book_isbn`)
    REFERENCES `mydb`.`Book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_Genre_Genre`
    FOREIGN KEY (`Genre_genre_id`)
    REFERENCES `mydb`.`Genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book_has_Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book_has_Author` (
  `Book_isbn` VARCHAR(12) NOT NULL,
  `Author_author_id` INT NOT NULL,
  PRIMARY KEY (`Book_isbn`, `Author_author_id`),
  INDEX `fk_Book_has_Author_Author1_idx` (`Author_author_id` ASC)  ,
  INDEX `fk_Book_has_Author_Book1_idx` (`Book_isbn` ASC)  ,
  CONSTRAINT `fk_Book_has_Author_Book1`
    FOREIGN KEY (`Book_isbn`)
    REFERENCES `mydb`.`Book` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_Author_Author1`
    FOREIGN KEY (`Author_author_id`)
    REFERENCES `mydb`.`Author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;