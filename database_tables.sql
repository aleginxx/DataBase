SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema demo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema demo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `demo` DEFAULT CHARACTER SET utf8 ;
USE `demo` ;

-- -----------------------------------------------------
-- Table `demo`.`central_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`central_manager` (
  `CentralMgrID` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CentralMgrID`),
  UNIQUE INDEX `CentralMgrID_UNIQUE` (`CentralMgrID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`school_unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`school_unit` (
  `Phone_Number` INT NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Principal` VARCHAR(45) NOT NULL,
  `LibMgr` VARCHAR(45) NOT NULL,
  `central_manager_CentralMgrID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Phone_Number`, `central_manager_CentralMgrID`),
  UNIQUE INDEX `Name_UNIQUE` (`Phone_Number` ASC),
  INDEX `fk_school_unit_central_manager1_idx` (`central_manager_CentralMgrID` ASC),
  CONSTRAINT `fk_school_unit_central_manager1`
    FOREIGN KEY (`central_manager_CentralMgrID`)
    REFERENCES `demo`.`central_manager` (`CentralMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_manager` (
  `LibMgrID` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `central_manager_CentralMgrID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LibMgrID`, `central_manager_CentralMgrID`),
  UNIQUE INDEX `LibMgrID_UNIQUE` (`LibMgrID` ASC) ,
  INDEX `fk_library_manager_central_manager1_idx` (`central_manager_CentralMgrID` ASC) ,
  CONSTRAINT `fk_library_manager_central_manager1`
    FOREIGN KEY (`central_manager_CentralMgrID`)
    REFERENCES `demo`.`central_manager` (`CentralMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`author` (
  `AuthorID` INT NOT NULL,
  `AuthorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorID`),
  UNIQUE INDEX `AuthorID_UNIQUE` (`AuthorID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`keyword` (
  `KeywordID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`KeywordID`),
  UNIQUE INDEX `KeywordID_UNIQUE` (`KeywordID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`genre` (
  `GenreID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`GenreID`),
  UNIQUE INDEX `GenreID_UNIQUE` (`GenreID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`books` (
  `ISBN` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Publisher` VARCHAR(45) NOT NULL,
  `No_pages` INT NOT NULL,
  `No_copies` INT NOT NULL,
  `Image` INT NOT NULL,
  `Language` VARCHAR(45) NOT NULL,
  `author_book` INT NULL,
  `keyword_book` VARCHAR(45) NULL,
  `genre_book` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC),
  INDEX `fk_books_author1_idx` (`author_book` ASC) ,
  INDEX `fk_books_keyword1_idx` (`keyword_book` ASC) ,
  INDEX `fk_books_genre1_idx` (`genre_book` ASC) ,
  CONSTRAINT `fk_books_author1`
    FOREIGN KEY (`author_book`)
    REFERENCES `mydb`.`author` (`AuthorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_keyword1`
    FOREIGN KEY (`keyword_book`)
    REFERENCES `mydb`.`keyword` (`KeywordID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_genre1`
    FOREIGN KEY (`genre_book`)
    REFERENCES `mydb`.`genre` (`GenreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`reviews` (
  `ReviewID` INT NOT NULL,
  `Text` MEDIUMTEXT NOT NULL,
  `Rating` INT NOT NULL,
  PRIMARY KEY (`ReviewID`),
  UNIQUE INDEX `ReviewID_UNIQUE` (`ReviewID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`teacher` (
  `TeacherID` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `BooksT` INT NOT NULL,
  PRIMARY KEY (`TeacherID`),
  UNIQUE INDEX `TeacherID_UNIQUE` (`TeacherID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`student` (
  `StudentID` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `BooksS` INT NOT NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE INDEX `StudentID_UNIQUE` (`StudentID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`reservations` (
  `ReservationID` INT NOT NULL,
  PRIMARY KEY (`ReservationID`),
  UNIQUE INDEX `ReservationID_UNIQUE` (`ReservationID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`borrowings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`borrowings` (
  `BorrowingID` INT NOT NULL,
  PRIMARY KEY (`BorrowingID`),
  UNIQUE INDEX `BorrowingID_UNIQUE` (`BorrowingID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`books_have_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`books_have_reviews` (
  `books_ISBN` INT NULL,
  `reviews_ReviewID` INT NOT NULL,
  PRIMARY KEY (`books_ISBN`, `reviews_ReviewID`),
  INDEX `fk_books_has_reviews_reviews1_idx` (`reviews_ReviewID` ASC) ,
  INDEX `fk_books_has_reviews_books1_idx` (`books_ISBN` ASC) ,
  CONSTRAINT `fk_books_has_reviews_books1`
    FOREIGN KEY (`books_ISBN`)
    REFERENCES `demo`.`books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_has_reviews_reviews1`
    FOREIGN KEY (`reviews_ReviewID`)
    REFERENCES `demo`.`reviews` (`ReviewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_managers_approves_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_managers_approves_student` (
  `library_manager_LibMgrID` VARCHAR(45) NOT NULL,
  `student_StudentID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`library_manager_LibMgrID`, `student_StudentID`),
  INDEX `fk_library_manager_has_student_student1_idx` (`student_StudentID` ASC) ,
  INDEX `fk_library_manager_has_student_library_manager1_idx` (`library_manager_LibMgrID` ASC) ,
  UNIQUE INDEX `library_manager_LibMgrID_UNIQUE` (`library_manager_LibMgrID` ASC) ,
  UNIQUE INDEX `student_StudentID_UNIQUE` (`student_StudentID` ASC) ,
  CONSTRAINT `fk_library_manager_has_student_library_manager1`
    FOREIGN KEY (`library_manager_LibMgrID`)
    REFERENCES `demo`.`library_manager` (`LibMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_manager_has_student_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `demo`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_manager_approves_teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_manager_approves_teacher` (
  `library_manager_LibMgrID` VARCHAR(45) NOT NULL,
  `teacher_TeacherID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`library_manager_LibMgrID`, `teacher_TeacherID`),
  INDEX `fk_library_manager_has_teacher_teacher1_idx` (`teacher_TeacherID` ASC) ,
  INDEX `fk_library_manager_has_teacher_library_manager1_idx` (`library_manager_LibMgrID` ASC) ,
  UNIQUE INDEX `library_manager_LibMgrID_UNIQUE` (`library_manager_LibMgrID` ASC) ,
  UNIQUE INDEX `teacher_TeacherID_UNIQUE` (`teacher_TeacherID` ASC) ,
  CONSTRAINT `fk_library_manager_has_teacher_library_manager1`
    FOREIGN KEY (`library_manager_LibMgrID`)
    REFERENCES `demo`.`library_manager` (`LibMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_manager_has_teacher_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `demo`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_manager_edits_books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_manager_edits_books` (
  `library_manager_LibMgrID` VARCHAR(45) NOT NULL,
  `books_ISBN` INT NULL,
  PRIMARY KEY (`library_manager_LibMgrID`, `books_ISBN`),
  INDEX `fk_library_manager_has_books_books1_idx` (`books_ISBN` ASC) ,
  INDEX `fk_library_manager_has_books_library_manager1_idx` (`library_manager_LibMgrID` ASC) ,
  CONSTRAINT `fk_library_manager_has_books_library_manager1`
    FOREIGN KEY (`library_manager_LibMgrID`)
    REFERENCES `demo`.`library_manager` (`LibMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_manager_has_books_books1`
    FOREIGN KEY (`books_ISBN`)
    REFERENCES `demo`.`books` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`student_register_reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`student_register_reservations` (
  `student_StudentID` VARCHAR(45) NULL,
  `reservations_ReservationID` INT NOT NULL,
  PRIMARY KEY (`student_StudentID`, `reservations_ReservationID`),
  INDEX `fk_student_has_reservations_reservations1_idx` (`reservations_ReservationID` ASC) ,
  INDEX `fk_student_has_reservations_student1_idx` (`student_StudentID` ASC) ,
  CONSTRAINT `fk_student_has_reservations_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `demo`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_reservations_reservations1`
    FOREIGN KEY (`reservations_ReservationID`)
    REFERENCES `demo`.`reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`teacher_register_reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`teacher_register_reservations` (
  `teacher_TeacherID` VARCHAR(45) NULL,
  `reservations_ReservationID` INT NOT NULL,
  PRIMARY KEY (`teacher_TeacherID`, `reservations_ReservationID`),
  INDEX `fk_teacher_has_reservations_reservations1_idx` (`reservations_ReservationID` ASC) ,
  INDEX `fk_teacher_has_reservations_teacher1_idx` (`teacher_TeacherID` ASC) ,
  CONSTRAINT `fk_teacher_has_reservations_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `demo`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_has_reservations_reservations1`
    FOREIGN KEY (`reservations_ReservationID`)
    REFERENCES `demo`.`reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`student_register_borrowings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`student_register_borrowings` (
  `student_StudentID` VARCHAR(45) NULL,
  `borrowings_BorrowingID` INT NOT NULL,
  PRIMARY KEY (`student_StudentID`, `borrowings_BorrowingID`),
  INDEX `fk_student_has_borrowings_borrowings1_idx` (`borrowings_BorrowingID` ASC) ,
  INDEX `fk_student_has_borrowings_student1_idx` (`student_StudentID` ASC) ,
  CONSTRAINT `fk_student_has_borrowings_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `demo`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_borrowings_borrowings1`
    FOREIGN KEY (`borrowings_BorrowingID`)
    REFERENCES `demo`.`borrowings` (`BorrowingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`teacher_register_borrowings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`teacher_register_borrowings` (
  `teacher_TeacherID` VARCHAR(45) NULL,
  `borrowings_BorrowingID` INT NOT NULL,
  PRIMARY KEY (`teacher_TeacherID`, `borrowings_BorrowingID`),
  INDEX `fk_teacher_has_borrowings_borrowings1_idx` (`borrowings_BorrowingID` ASC) ,
  INDEX `fk_teacher_has_borrowings_teacher1_idx` (`teacher_TeacherID` ASC) ,
  CONSTRAINT `fk_teacher_has_borrowings_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `demo`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_has_borrowings_borrowings1`
    FOREIGN KEY (`borrowings_BorrowingID`)
    REFERENCES `demo`.`borrowings` (`BorrowingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_manager_supervises_reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_manager_supervises_reservations` (
  `library_manager_LibMgrID` VARCHAR(45) NOT NULL,
  `reservations_ReservationID` INT NOT NULL,
  PRIMARY KEY (`library_manager_LibMgrID`, `reservations_ReservationID`),
  INDEX `fk_library_manager_has_reservations_reservations1_idx` (`reservations_ReservationID` ASC) ,
  INDEX `fk_library_manager_has_reservations_library_manager1_idx` (`library_manager_LibMgrID` ASC) ,
  CONSTRAINT `fk_library_manager_has_reservations_library_manager1`
    FOREIGN KEY (`library_manager_LibMgrID`)
    REFERENCES `demo`.`library_manager` (`LibMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_manager_has_reservations_reservations1`
    FOREIGN KEY (`reservations_ReservationID`)
    REFERENCES `demo`.`reservations` (`ReservationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`library_manager_supervises_borrowings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`library_manager_supervises_borrowings` (
  `library_manager_LibMgrID` VARCHAR(45) NOT NULL,
  `borrowings_BorrowingID` INT NOT NULL,
  PRIMARY KEY (`library_manager_LibMgrID`, `borrowings_BorrowingID`),
  INDEX `fk_library_manager_has_borrowings_borrowings1_idx` (`borrowings_BorrowingID` ASC) ,
  INDEX `fk_library_manager_has_borrowings_library_manager1_idx` (`library_manager_LibMgrID` ASC) ,
  CONSTRAINT `fk_library_manager_has_borrowings_library_manager1`
    FOREIGN KEY (`library_manager_LibMgrID`)
    REFERENCES `demo`.`library_manager` (`LibMgrID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_manager_has_borrowings_borrowings1`
    FOREIGN KEY (`borrowings_BorrowingID`)
    REFERENCES `demo`.`borrowings` (`BorrowingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`student_register_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`student_register_reviews` (
  `student_StudentID` VARCHAR(45) NULL,
  `reviews_ReviewID` INT NOT NULL,
  PRIMARY KEY (`student_StudentID`, `reviews_ReviewID`),
  INDEX `fk_student_has_reviews_reviews1_idx` (`reviews_ReviewID` ASC) ,
  INDEX `fk_student_has_reviews_student1_idx` (`student_StudentID` ASC) ,
  CONSTRAINT `fk_student_has_reviews_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `demo`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_reviews_reviews1`
    FOREIGN KEY (`reviews_ReviewID`)
    REFERENCES `demo`.`reviews` (`ReviewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demo`.`teacher_register_reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`teacher_register_reviews` (
  `teacher_TeacherID` VARCHAR(45) NULL,
  `reviews_ReviewID` INT NOT NULL,
  PRIMARY KEY (`teacher_TeacherID`, `reviews_ReviewID`),
  INDEX `fk_teacher_has_reviews_reviews1_idx` (`reviews_ReviewID` ASC) ,
  INDEX `fk_teacher_has_reviews_teacher1_idx` (`teacher_TeacherID` ASC) ,
  CONSTRAINT `fk_teacher_has_reviews_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `demo`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_has_reviews_reviews1`
    FOREIGN KEY (`reviews_ReviewID`)
    REFERENCES `demo`.`reviews` (`ReviewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
