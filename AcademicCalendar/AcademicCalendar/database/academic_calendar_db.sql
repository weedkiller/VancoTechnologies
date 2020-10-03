-- MySQL Script generated by MySQL Workbench
-- Mon Apr 20 03:47:46 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema academic_calendar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema academic_calendar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `academic_calendar` DEFAULT CHARACTER SET utf8 ;
USE `academic_calendar` ;

-- -----------------------------------------------------
-- Table `academic_calendar`.`subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academic_calendar`.`subjects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` VARCHAR(255) NOT NULL,
  `term` VARCHAR(255) NOT NULL,
  `subject_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `academic_calendar`.`faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `academic_calendar`.`faculties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `subject_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fac_subject_id_idx` (`subject_id` ASC),
  CONSTRAINT `fac_subject_id`
    FOREIGN KEY (`subject_id`)
    REFERENCES `academic_calendar`.`subjects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;