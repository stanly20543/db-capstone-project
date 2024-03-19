-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondm` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondm` ;

-- -----------------------------------------------------
-- Table `littlelemondm`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`customer` (
  `customerid` INT NOT NULL,
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `phoneNo` INT NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customerid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menu` (
  `menuid` INT NOT NULL,
  `cuisines` VARCHAR(255) NOT NULL,
  `starters` VARCHAR(255) NOT NULL,
  `courseid` VARCHAR(255) NOT NULL,
  `drinks` VARCHAR(255) NOT NULL,
  `desserts` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`menuid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`orders` (
  `orderid` INT NOT NULL,
  `orderdate` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `totalcost` DECIMAL(10,0) NOT NULL,
  `menuid` INT NOT NULL,
  PRIMARY KEY (`orderid`),
  INDEX `fk_orders_menu1_idx` (`menuid` ASC) VISIBLE,
  CONSTRAINT `fk_orders_menu1`
    FOREIGN KEY (`menuid`)
    REFERENCES `littlelemondm`.`menu` (`menuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondm`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`staff` (
  `staffid` INT NOT NULL,
  `firstname` VARCHAR(255) NULL,
  `lastname` VARCHAR(255) NULL,
  `phoneNo` INT NULL,
  `address` VARCHAR(255) NULL,
  PRIMARY KEY (`staffid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`delivery` (
  `deliveryid` INT NOT NULL,
  `deliverydate` DATE NULL,
  `status` VARCHAR(45) NULL,
  `staffid` INT NULL,
  PRIMARY KEY (`deliveryid`),
  INDEX `staffid_idx` (`staffid` ASC) VISIBLE,
  CONSTRAINT `staffid`
    FOREIGN KEY (`staffid`)
    REFERENCES `littlelemondm`.`staff` (`staffid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondm`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`bookings` (
  `bookingid` INT NOT NULL,
  `date` DATE NOT NULL,
  `tableNo` INT NOT NULL,
  `customerid` INT NULL,
  `orderid` INT NULL,
  `deliveryid` INT NULL,
  PRIMARY KEY (`bookingid`),
  UNIQUE INDEX `bookingid_UNIQUE` (`bookingid` ASC) VISIBLE,
  INDEX `customerid_idx` (`customerid` ASC) VISIBLE,
  INDEX `orderid_idx` (`orderid` ASC) VISIBLE,
  INDEX `deliveryid_idx` (`deliveryid` ASC) VISIBLE,
  CONSTRAINT `customerid`
    FOREIGN KEY (`customerid`)
    REFERENCES `littlelemondm`.`customer` (`customerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderid`
    FOREIGN KEY (`orderid`)
    REFERENCES `littlelemondm`.`orders` (`orderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `deliveryid`
    FOREIGN KEY (`deliveryid`)
    REFERENCES `littlelemondm`.`delivery` (`deliveryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
