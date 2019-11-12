-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Gafas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Gafas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Gafas` DEFAULT CHARACTER SET utf8 ;
USE `Gafas` ;

-- -----------------------------------------------------
-- Table `Gafas`.`adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`adress` (
  `idUser` INT(9) NOT NULL,
  `street` VARCHAR(100) NOT NULL,
  `num` INT NOT NULL,
  `floor` INT(2) NOT NULL,
  `door` INT(1) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `code` INT(6) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Provider` (
  `idUser` INT(9) NOT NULL,
  `nifProvider` INT(9) NOT NULL,
  `nameProv` VARCHAR(45) NOT NULL,
  `telf` INT(9) NOT NULL,
  `fax` INT(15) NOT NULL,
  `adress_idUser` INT(9) NOT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `fk_Provider_adress1_idx` (`adress_idUser` ASC),
  CONSTRAINT `fk_Provider_adress1`
    FOREIGN KEY (`adress_idUser`)
    REFERENCES `Gafas`.`adress` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Muntura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Muntura` (
  `idMuntura` INT NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idMuntura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Glasses` (
  `idGlasses` INT(9) NOT NULL,
  `brandGlasses` VARCHAR(45) NOT NULL,
  `graduationGlasses` FLOAT NOT NULL,
  `colorMuntura` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `colorVidre` VARCHAR(45) NOT NULL,
  `Muntura_idMuntura` INT NOT NULL,
  `Provider_idUser` INT(9) NOT NULL,
  PRIMARY KEY (`idGlasses`),
  INDEX `fk_Glasses_Muntura1_idx` (`Muntura_idMuntura` ASC),
  INDEX `fk_Glasses_Provider1_idx` (`Provider_idUser` ASC),
  CONSTRAINT `fk_Glasses_Muntura1`
    FOREIGN KEY (`Muntura_idMuntura`)
    REFERENCES `Gafas`.`Muntura` (`idMuntura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Glasses_Provider1`
    FOREIGN KEY (`Provider_idUser`)
    REFERENCES `Gafas`.`Provider` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Clients` (
  `idUser` INT(9) NOT NULL,
  `idEmail` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `telf` INT(9) NOT NULL,
  `registerDate` INT(6) NOT NULL,
  `adress_idUser` INT(9) NOT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `fk_Clients_adress1_idx` (`adress_idUser` ASC),
  CONSTRAINT `fk_Clients_adress1`
    FOREIGN KEY (`adress_idUser`)
    REFERENCES `Gafas`.`adress` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Empleat` (
  `idEmpleat` INT NOT NULL,
  `nameEmpleat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`NouClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`NouClient` (
  `idNewUser` INT(9) NOT NULL,
  `Clients_idUser` INT(9) NULL,
  PRIMARY KEY (`idNewUser`),
  INDEX `fk_NouClient_Clients1_idx` (`Clients_idUser` ASC),
  CONSTRAINT `fk_NouClient_Clients1`
    FOREIGN KEY (`Clients_idUser`)
    REFERENCES `Gafas`.`Clients` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gafas`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gafas`.`Venta` (
  `idVenta` INT(12) NOT NULL,
  `Empleat_idEmpleat` INT NOT NULL,
  `Glasses_idGlasses` INT(9) NOT NULL,
  `Clients_idUser` INT(9) NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Venta_Empleat1_idx` (`Empleat_idEmpleat` ASC),
  INDEX `fk_Venta_Glasses1_idx` (`Glasses_idGlasses` ASC),
  INDEX `fk_Venta_Clients1_idx` (`Clients_idUser` ASC),
  CONSTRAINT `fk_Venta_Empleat1`
    FOREIGN KEY (`Empleat_idEmpleat`)
    REFERENCES `Gafas`.`Empleat` (`idEmpleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Glasses1`
    FOREIGN KEY (`Glasses_idGlasses`)
    REFERENCES `Gafas`.`Glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Clients1`
    FOREIGN KEY (`Clients_idUser`)
    REFERENCES `Gafas`.`Clients` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
