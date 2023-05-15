-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema storedb
-- -----------------------------------------------------
-- stores all the data for the store which can be added to by the forms we are building. This will allow us to insert financial statements using a form. We should think about using the procedures that the forms use to automate the inserts if we have alot of data to do. But the forms could be used as a pos system to make purchases and sales and rent out products.
DROP SCHEMA IF EXISTS `storedb` ;

-- -----------------------------------------------------
-- Schema storedb
--
-- stores all the data for the store which can be added to by the forms we are building. This will allow us to insert financial statements using a form. We should think about using the procedures that the forms use to automate the inserts if we have alot of data to do. But the forms could be used as a pos system to make purchases and sales and rent out products.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `storedb` ;
USE `storedb` ;

-- -----------------------------------------------------
-- Table `storedb`.`common_lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`common_lookup` ;

CREATE TABLE IF NOT EXISTS `storedb`.`common_lookup` (
  `common_lookup_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `common_lookup_type` CHAR(30) NOT NULL,
  `common_lookup_meaning` CHAR(30) NOT NULL,
  `common_lookup_table` CHAR(30) NULL DEFAULT NULL,
  `common_lookup_column` CHAR(30) NULL DEFAULT NULL,
  `common_lookup_code` CHAR(30) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`common_lookup_id`),
  UNIQUE INDEX `common_lookup_u1` (`common_lookup_table` ASC, `common_lookup_column` ASC, `common_lookup_type` ASC) VISIBLE,
  INDEX `common_lookup_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `common_lookup_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  CONSTRAINT `common_lookup_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `common_lookup_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 337
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`system_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`system_user` ;

CREATE TABLE IF NOT EXISTS `storedb`.`system_user` (
  `system_user_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `system_user_name` CHAR(20) NOT NULL,
  `system_user_group_id` INT(10) UNSIGNED NOT NULL,
  `system_user_type` INT(10) UNSIGNED NOT NULL,
  `first_name` CHAR(20) NULL DEFAULT NULL,
  `middle_name` CHAR(20) NULL DEFAULT NULL,
  `last_name` CHAR(20) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`system_user_id`),
  INDEX `system_user_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `system_user_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `system_user_fk3_idx` (`system_user_type` ASC) VISIBLE,
  CONSTRAINT `system_user_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `system_user_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `system_user_fk3`
    FOREIGN KEY (`system_user_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`account_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`account_list` ;

CREATE TABLE IF NOT EXISTS `storedb`.`account_list` (
  `account_list_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_number` CHAR(10) NOT NULL,
  `consumed_date` DATE NULL DEFAULT NULL,
  `consumed_by` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_update_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`account_list_id`),
  INDEX `account_list_fk1_idx` (`consumed_by` ASC) VISIBLE,
  INDEX `account_list_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `account_list_fk3_idx` (`last_update_by` ASC) VISIBLE,
  CONSTRAINT `account_list_fk1`
    FOREIGN KEY (`consumed_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `account_list_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `account_list_fk3`
    FOREIGN KEY (`last_update_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`organization` ;

CREATE TABLE IF NOT EXISTS `storedb`.`organization` (
  `organization_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_name` CHAR(30) NOT NULL,
  `organization_type` INT(10) UNSIGNED NOT NULL,
  `tin` CHAR(30) NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`organization_id`),
  INDEX `oragnization_fk1` (`organization_type` ASC) VISIBLE,
  INDEX `organization_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `organization_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `organization_fk4_idx` (`active_flag` ASC) VISIBLE,
  INDEX `organization_fk5` (`organization_type` ASC) VISIBLE,
  CONSTRAINT `organization_fk1`
    FOREIGN KEY (`organization_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `organization_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `organization_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `organization_fk4`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`member` ;

CREATE TABLE IF NOT EXISTS `storedb`.`member` (
  `member_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_number` CHAR(10) NOT NULL,
  `credit_card_number` CHAR(19) NOT NULL,
  `credit_card_type` INT(10) UNSIGNED NOT NULL,
  `member_type` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `member_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `member_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `member_fk3_idx` (`credit_card_type` ASC) VISIBLE,
  INDEX `member_fk4_idx` (`member_type` ASC) VISIBLE,
  INDEX `account_number_UNIQUE` (`account_number` ASC) VISIBLE,
  INDEX `member_id_UNIQUE` (`member_id` ASC) VISIBLE,
  INDEX `credit_card_number_UNIQUE` (`credit_card_number` ASC) VISIBLE,
  INDEX `credit_card_type_UNIQUE` (`credit_card_type` ASC) VISIBLE,
  INDEX `created_by_UNIQUE` (`created_by` ASC) VISIBLE,
  INDEX `creation_date_UNIQUE` (`creation_date` ASC) VISIBLE,
  INDEX `last_updated_by_UNIQUE` (`last_updated_by` ASC) VISIBLE,
  INDEX `last_update_date_UNIQUE` (`last_update_date` ASC) VISIBLE,
  INDEX `member_type_UNIQUE` (`member_type` ASC) VISIBLE,
  CONSTRAINT `member_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `member_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `member_fk3`
    FOREIGN KEY (`credit_card_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `member_fk4`
    FOREIGN KEY (`member_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`job` ;

CREATE TABLE IF NOT EXISTS `storedb`.`job` (
  `job_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org_id` INT(10) UNSIGNED NOT NULL,
  `job_title` CHAR(50) NOT NULL,
  `job_type` INT(10) UNSIGNED NOT NULL,
  `job_description` CHAR(50) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`job_id`),
  INDEX `job_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `job_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `job_fk3_idx` (`org_id` ASC) VISIBLE,
  INDEX `job_fk4_idx` (`job_type` ASC) VISIBLE,
  CONSTRAINT `job_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `job_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `job_fk3`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `job_fk4`
    FOREIGN KEY (`job_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`contact` ;

CREATE TABLE IF NOT EXISTS `storedb`.`contact` (
  `contact_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(10) UNSIGNED NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  `job_id` INT(10) UNSIGNED NULL,
  `org_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `employee_number` CHAR(10) NULL DEFAULT NULL,
  `contact_type` INT(10) UNSIGNED NOT NULL,
  `first_name` CHAR(20) NOT NULL,
  `middle_name` CHAR(20) NULL DEFAULT NULL,
  `last_name` CHAR(20) NOT NULL,
  `gender_type` INT(10) NULL DEFAULT NULL,
  `ssan` CHAR(11) NOT NULL,
  `employee_photo` MEDIUMBLOB NULL,
  `dob` DATE NULL,
  `race_type` INT(10) UNSIGNED NULL,
  `marital_type` INT(10) UNSIGNED NULL,
  `employee_type` INT(10) UNSIGNED NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `contact_fk1_idx` (`member_id` ASC) VISIBLE,
  INDEX `contact_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `contact_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `contact_fk4_idx` (`organization_id` ASC) VISIBLE,
  INDEX `contact_fk5_idx` (`contact_type` ASC) VISIBLE,
  INDEX `contact_fk6_idx` (`race_type` ASC) VISIBLE,
  INDEX `contact_fk7_idx` (`marital_type` ASC) VISIBLE,
  INDEX `contact_fk8_idx` (`job_id` ASC) VISIBLE,
  INDEX `contact_fk9_idx` (`employee_type` ASC) VISIBLE,
  CONSTRAINT `contact_fk1`
    FOREIGN KEY (`member_id`)
    REFERENCES `storedb`.`member` (`member_id`),
  CONSTRAINT `contact_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `contact_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `contact_fk4`
    FOREIGN KEY (`organization_id`)
    REFERENCES `storedb`.`organization` (`organization_id`),
  CONSTRAINT `contact_fk5`
    FOREIGN KEY (`contact_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `contact_fk6`
    FOREIGN KEY (`race_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_fk7`
    FOREIGN KEY (`marital_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_fk8`
    FOREIGN KEY (`job_id`)
    REFERENCES `storedb`.`job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_fk9`
    FOREIGN KEY (`employee_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`country` ;

CREATE TABLE IF NOT EXISTS `storedb`.`country` (
  `country_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_name` INT(10) UNSIGNED NOT NULL,
  `county_code` CHAR(2) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`state` ;

CREATE TABLE IF NOT EXISTS `storedb`.`state` (
  `state_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` INT(10) UNSIGNED NOT NULL,
  `state_code` CHAR(3) NOT NULL,
  `state_name` CHAR(30) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`state_id`),
  INDEX `fk_airport_1` (`created_by` ASC) VISIBLE,
  INDEX `fk_airport_2` (`last_updated_by` ASC) VISIBLE,
  INDEX `state_fk3_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `state_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `state_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `state_fk3`
    FOREIGN KEY (`country_id`)
    REFERENCES `storedb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`county`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`county` ;

CREATE TABLE IF NOT EXISTS `storedb`.`county` (
  `county_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `state_id` INT(10) UNSIGNED NOT NULL,
  `county_name` CHAR(30) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`county_id`),
  INDEX `fk_airport_1` (`created_by` ASC) VISIBLE,
  INDEX `fk_airport_2` (`last_updated_by` ASC) VISIBLE,
  INDEX `county_fk1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_airport_100`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `fk_airport_200`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `county_fk1`
    FOREIGN KEY (`state_id`)
    REFERENCES `storedb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`city` ;

CREATE TABLE IF NOT EXISTS `storedb`.`city` (
  `city_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `county_id` INT(10) UNSIGNED NULL,
  `state_id` INT(10) UNSIGNED NULL,
  `city_name` CHAR(30) NOT NULL,
  `state_province` CHAR(30) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_airport_1` (`created_by` ASC) VISIBLE,
  INDEX `fk_airport_2` (`last_updated_by` ASC) VISIBLE,
  INDEX `city_fk1_idx` (`county_id` ASC) VISIBLE,
  INDEX `city_fk2_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_airport_1000`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `fk_airport_2000`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `city_fk1`
    FOREIGN KEY (`county_id`)
    REFERENCES `storedb`.`county` (`county_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `city_fk2`
    FOREIGN KEY (`state_id`)
    REFERENCES `storedb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`address` ;

CREATE TABLE IF NOT EXISTS `storedb`.`address` (
  `address_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(10) UNSIGNED NOT NULL,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `address_type` INT(10) UNSIGNED NOT NULL,
  `city_id` INT(10) UNSIGNED NOT NULL,
  `state_id` INT(10) UNSIGNED NOT NULL,
  `county_id` INT(10) UNSIGNED NULL,
  `postal_code` CHAR(20) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `address_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `address_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `address_fk4_idx` (`organization_id` ASC) VISIBLE,
  INDEX `address_fk5_idx` (`contact_id` ASC) VISIBLE,
  INDEX `address_fk6_idx` (`city_id` ASC) VISIBLE,
  INDEX `address_fk7_idx` (`county_id` ASC) VISIBLE,
  INDEX `address_fk8_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `address_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `address_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `address_fk4`
    FOREIGN KEY (`organization_id`)
    REFERENCES `storedb`.`organization` (`organization_id`),
  CONSTRAINT `address_fk5`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_fk6`
    FOREIGN KEY (`city_id`)
    REFERENCES `storedb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_fk7`
    FOREIGN KEY (`county_id`)
    REFERENCES `storedb`.`county` (`county_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_fk8`
    FOREIGN KEY (`state_id`)
    REFERENCES `storedb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`airport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`airport` ;

CREATE TABLE IF NOT EXISTS `storedb`.`airport` (
  `airport_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `airport_code` CHAR(3) NOT NULL,
  `airport_name` CHAR(30) NOT NULL,
  `airport_city_id` INT(10) UNSIGNED NOT NULL,
  `city_id` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`airport_id`),
  INDEX `fk_airport_1_idx` (`created_by` ASC) VISIBLE,
  INDEX `fk_airport_2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `fk_airport_3_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_airport_4_idx` (`airport_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_airport_1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `fk_airport_2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `fk_airport_3`
    FOREIGN KEY (`city_id`)
    REFERENCES `storedb`.`state` (`state_id`),
  CONSTRAINT `fk_airport_4`
    FOREIGN KEY (`airport_city_id`)
    REFERENCES `storedb`.`state` (`state_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`benefit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`benefit` ;

CREATE TABLE IF NOT EXISTS `storedb`.`benefit` (
  `benefit_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `employee_contribution` DECIMAL(10,2) NULL DEFAULT NULL,
  `employer_contribution` DECIMAL(10,2) NULL DEFAULT NULL,
  `benefit_type` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`benefit_id`),
  INDEX `benefit_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `benefit_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `benefit_fk3_idx` (`benefit_type` ASC) VISIBLE,
  INDEX `benefit_fk4_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `benefit_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `benefit_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `benefit_fk3`
    FOREIGN KEY (`benefit_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `benefit_fk4`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`bonus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`bonus` ;

CREATE TABLE IF NOT EXISTS `storedb`.`bonus` (
  `bonus_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` INT(10) UNSIGNED NOT NULL,
  `org_id` INT(10) UNSIGNED NOT NULL,
  `bonus_amount` DECIMAL(10,2) NOT NULL,
  `bonus_date` DATE NOT NULL,
  `paid_date` DATE NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`bonus_id`),
  INDEX `bonus_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `bonus_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `bonus_fk3_idx` (`org_id` ASC) VISIBLE,
  INDEX `bonus_fk4_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `bonus_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `bonus_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `bonus_fk3`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bonus_fk4`
    FOREIGN KEY (`employee_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`calendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`calendar` ;

CREATE TABLE IF NOT EXISTS `storedb`.`calendar` (
  `calendar_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `calendar_name` CHAR(10) NULL DEFAULT NULL,
  `calendar_short_name` CHAR(3) NULL DEFAULT NULL,
  `period_name` CHAR(30) NULL DEFAULT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`calendar_id`),
  INDEX `calendar_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `calendar_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `calendar_fk3_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `calendar_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `calendar_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `calendar_fk3`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`chart_of_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`chart_of_account` ;

CREATE TABLE IF NOT EXISTS `storedb`.`chart_of_account` (
  `account_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_number` CHAR(10) NOT NULL,
  `account_group_type` INT(10) UNSIGNED NOT NULL,
  `ledger_type` INT(10) UNSIGNED NOT NULL,
  `account_type` INT(10) UNSIGNED NOT NULL,
  `account_code` INT(10) UNSIGNED NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_update_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `chart_of_account_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `chart_of_account_fk2_idx` (`last_update_by` ASC) VISIBLE,
  INDEX `chart_of_account_fk4_idx` (`account_type` ASC) VISIBLE,
  INDEX `chart_of_account_fk5_idx` (`account_group_type` ASC) VISIBLE,
  INDEX `chart_of_account_fk6_idx` (`ledger_type` ASC) VISIBLE,
  CONSTRAINT `chart_of_account_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `chart_of_account_fk2`
    FOREIGN KEY (`last_update_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `chart_of_account_fk4`
    FOREIGN KEY (`account_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `chart_of_account_fk5`
    FOREIGN KEY (`account_group_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `chart_of_account_fk6`
    FOREIGN KEY (`ledger_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`item_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`item_rating` ;

CREATE TABLE IF NOT EXISTS `storedb`.`item_rating` (
  `item_rating_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_rating` CHAR(8) NULL DEFAULT NULL,
  `item_rating_meaning` CHAR(40) NULL,
  `item_rating_agency` CHAR(4) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` INT(10) NOT NULL,
  PRIMARY KEY (`item_rating_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`genre` ;

CREATE TABLE IF NOT EXISTS `storedb`.`genre` (
  `genre_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre` CHAR(50) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`item` ;

CREATE TABLE IF NOT EXISTS `storedb`.`item` (
  `item_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_rating_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `genre_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `item_asin` CHAR(14) NOT NULL,
  `item_type` INT(10) UNSIGNED NULL,
  `item_title` VARCHAR(1000) NOT NULL,
  `item_subtitle` VARCHAR(500) NULL DEFAULT NULL,
  `item_release_date` DATE NOT NULL,
  `item_screen_type` INT(45) UNSIGNED NULL DEFAULT NULL,
  `item_image_url` CHAR(100) NULL DEFAULT NULL,
  `item_case` TINYINT(1) NOT NULL,
  `case_quantity` INT(10) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `item_fk1_idx` (`item_type` ASC) VISIBLE,
  INDEX `item_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `item_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `item_fk4_idx` (`item_rating_id` ASC) VISIBLE,
  INDEX `item_fk5_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `item_fk1`
    FOREIGN KEY (`item_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `item_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `item_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `item_fk4`
    FOREIGN KEY (`item_rating_id`)
    REFERENCES `storedb`.`item_rating` (`item_rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_fk5`
    FOREIGN KEY (`genre_id`)
    REFERENCES `storedb`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`purchase_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`purchase_order` ;

CREATE TABLE IF NOT EXISTS `storedb`.`purchase_order` (
  `purchase_order_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `purchase_quantity` INT(10) NULL DEFAULT NULL,
  `purchase_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`purchase_order_id`),
  INDEX `purchase_order_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `purchase_order_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `purchase_order_fk3_idx` (`contact_id` ASC) VISIBLE,
  INDEX `purchase_order_id` (`purchase_order_id` ASC) VISIBLE,
  CONSTRAINT `purchase_order_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `purchase_order_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `purchase_order_fk3`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`discount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`discount` ;

CREATE TABLE IF NOT EXISTS `storedb`.`discount` (
  `discounts_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` INT(10) UNSIGNED NULL,
  `purchase_order_id` INT(10) UNSIGNED NULL,
  `discount_percent` DECIMAL(10,2) NOT NULL,
  `discount_amount` DECIMAL(10,2) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`discounts_id`),
  INDEX `discount_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `discount_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `discount_fk3_idx` (`item_id` ASC) VISIBLE,
  INDEX `discount_fk4_idx` (`purchase_order_id` ASC) VISIBLE,
  CONSTRAINT `discount_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `discount_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `discount_fk3`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `discount_fk4`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `storedb`.`purchase_order` (`purchase_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`employee_benefit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`employee_benefit` ;

CREATE TABLE IF NOT EXISTS `storedb`.`employee_benefit` (
  `benefit_id` INT(10) UNSIGNED NOT NULL,
  `employee_id` INT(10) UNSIGNED NOT NULL,
  `org_id` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`benefit_id`, `employee_id`, `org_id`),
  INDEX `employee_benefit_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `employee_benefit_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `employee_benefit_fk3_idx` (`org_id` ASC) VISIBLE,
  INDEX `employee_benefit_fk4_idx` (`employee_id` ASC) VISIBLE,
  INDEX `employee_benefit_fk5_idx` (`benefit_id` ASC) VISIBLE,
  INDEX `employee_benefit_pk1` (`benefit_id` ASC, `employee_id` ASC, `org_id` ASC) VISIBLE,
  CONSTRAINT `employee_benefit_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employee_benefit_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employee_benefit_fk3`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_benefit_fk4`
    FOREIGN KEY (`employee_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_benefit_fk5`
    FOREIGN KEY (`benefit_id`)
    REFERENCES `storedb`.`benefit` (`benefit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`employee_bonus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`employee_bonus` ;

CREATE TABLE IF NOT EXISTS `storedb`.`employee_bonus` (
  `bonus_id` INT(10) UNSIGNED NOT NULL,
  `employee_id` INT(10) UNSIGNED NOT NULL,
  `org_id` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`bonus_id`, `employee_id`, `org_id`),
  INDEX `employee_benefit_fk1` (`created_by` ASC) VISIBLE,
  INDEX `employee_benefit_fk2` (`last_updated_by` ASC) VISIBLE,
  INDEX `employee_benefit_fk3` (`org_id` ASC) VISIBLE,
  INDEX `employee_benefit_fk4` (`employee_id` ASC) VISIBLE,
  INDEX `employee_benefit_fk5` (`bonus_id` ASC) VISIBLE,
  INDEX `employee_benefit_pk1` (`bonus_id` ASC, `employee_id` ASC, `org_id` ASC) VISIBLE,
  CONSTRAINT `employee_bonus_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employee_bonus_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employee_bonus_fk3`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_bonus_fk4`
    FOREIGN KEY (`employee_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_bonus_fk5`
    FOREIGN KEY (`bonus_id`)
    REFERENCES `storedb`.`bonus` (`bonus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`rental` ;

CREATE TABLE IF NOT EXISTS `storedb`.`rental` (
  `rental_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `check_out_date` DATE NOT NULL,
  `expected_return_date` DATE NOT NULL,
  `actual_return_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `rental_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `rental_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `rental_fk3_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `rental_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `rental_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `rental_fk3`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`invoice` ;

CREATE TABLE IF NOT EXISTS `storedb`.`invoice` (
  `invoice_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  -- change from 'NULL' to NOT NULL at line 997 'invoice_num'
  `invoice_num` INT(10) UNSIGNED NOT NULL,
  `rental_id` INT(10) UNSIGNED NOT NULL,
  `invoice_price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `invoice_date` DATE NOT NULL,
  `invoice_pay_flag` INT(10) UNSIGNED NOT NULL,
  `request_quantity` INT(10) UNSIGNED NOT NULL,
  `purchase_price` DECIMAL(10,2) NOT NULL,
  `purchase_date` DATE NOT NULL,
  `purchase_method_type` INT(10) UNSIGNED NOT NULL,
  `invoice_type` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_update_by` INT(10) UNSIGNED NULL DEFAULT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`invoice_id`, `invoice_num`),
  INDEX `invoice_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `invoice_fk2_idx` (`last_update_by` ASC) VISIBLE,
  INDEX `invoice_fk3_idx` (`rental_id` ASC) VISIBLE,
  INDEX `invoice_fk4_idx` (`purchase_method_type` ASC) VISIBLE,
  INDEX `invoice_fk5_idx` (`invoice_pay_flag` ASC) VISIBLE,
  INDEX `invoice_fk6_idx` (`invoice_type` ASC) VISIBLE,
  CONSTRAINT `invoice_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `invoice_fk2`
    FOREIGN KEY (`last_update_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `invoice_fk3`
    FOREIGN KEY (`rental_id`)
    REFERENCES `storedb`.`rental` (`rental_id`),
  CONSTRAINT `invoice_fk4`
    FOREIGN KEY (`purchase_method_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `invoice_fk5`
    FOREIGN KEY (`invoice_pay_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `invoice_fk6`
    FOREIGN KEY (`invoice_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`state_tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`state_tax` ;

CREATE TABLE IF NOT EXISTS `storedb`.`state_tax` (
  `state_tax_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `state_id` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`state_tax_id`),
  INDEX `state_tax_fk1_idx` (`state_id` ASC) VISIBLE,
  INDEX `state_tax_fk2_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `state_tax_fk1`
    FOREIGN KEY (`state_id`)
    REFERENCES `storedb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `state_tax_fk2`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`county_tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`county_tax` ;

CREATE TABLE IF NOT EXISTS `storedb`.`county_tax` (
  `county_tax_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `county_id` INT(10) UNSIGNED NOT NULL,
  `state_tax_id` INT(10) UNSIGNED NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`county_tax_id`),
  INDEX `county_tax_fk1_idx` (`county_id` ASC) VISIBLE,
  INDEX `county_tax_fk2_idx` (`state_tax_id` ASC) VISIBLE,
  INDEX `county_tax_fk3_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `county_tax_fk1`
    FOREIGN KEY (`county_id`)
    REFERENCES `storedb`.`county` (`county_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `county_tax_fk2`
    FOREIGN KEY (`state_tax_id`)
    REFERENCES `storedb`.`state_tax` (`state_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `county_tax_fk3`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`city_tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`city_tax` ;

CREATE TABLE IF NOT EXISTS `storedb`.`city_tax` (
  `city_tax_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `county_tax_id` INT(10) UNSIGNED NOT NULL,
  `state_tax_id` INT(10) UNSIGNED NOT NULL,
  `city_id` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`city_tax_id`),
  INDEX `city_tax_fk1_idx` (`state_tax_id` ASC) VISIBLE,
  INDEX `city_tax_fk2_idx` (`county_tax_id` ASC) VISIBLE,
  INDEX `city_tax_fk3_idx` (`city_id` ASC) VISIBLE,
  INDEX `city_tax_fk4_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `city_tax_fk1`
    FOREIGN KEY (`state_tax_id`)
    REFERENCES `storedb`.`state_tax` (`state_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `city_tax_fk2`
    FOREIGN KEY (`county_tax_id`)
    REFERENCES `storedb`.`county_tax` (`county_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `city_tax_fk3`
    FOREIGN KEY (`city_id`)
    REFERENCES `storedb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `city_tax_fk4`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`sales_tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`sales_tax` ;

CREATE TABLE IF NOT EXISTS `storedb`.`sales_tax` (
  `sales_tax_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `county_tax_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `city_tax_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `state_tax_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `sales_tax_percent` DECIMAL(10,2) NOT NULL,
  `effective_start_date` DATE NOT NULL,
  `effective_end_date` DATE NOT NULL,
  `sales_tax_type` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`sales_tax_id`),
  INDEX `sales_tax_fk1_idx` (`city_tax_id` ASC) VISIBLE,
  INDEX `sales_tax_fk2_idx` (`county_tax_id` ASC) VISIBLE,
  INDEX `sales_tax_fk3_idx` (`state_tax_id` ASC) VISIBLE,
  CONSTRAINT `sales_tax_fk1`
    FOREIGN KEY (`city_tax_id`)
    REFERENCES `storedb`.`city_tax` (`city_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_tax_fk2`
    FOREIGN KEY (`county_tax_id`)
    REFERENCES `storedb`.`county_tax` (`county_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_tax_fk3`
    FOREIGN KEY (`state_tax_id`)
    REFERENCES `storedb`.`state_tax` (`state_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`vat_tax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`vat_tax` ;

CREATE TABLE IF NOT EXISTS `storedb`.`vat_tax` (
  `vat_tax_id` INT(10) UNSIGNED NOT NULL,
  `country_id` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `active_flag` INT(10) NOT NULL,
  `percentage_amount` DOUBLE UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_update_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`vat_tax_id`),
  INDEX `vat_tax_fk1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `vat_tax_fk1`
    FOREIGN KEY (`country_id`)
    REFERENCES `storedb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `storedb`.`general_ledger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`general_ledger` ;

CREATE TABLE IF NOT EXISTS `storedb`.`general_ledger` (
  `coa_id` INT(10) UNSIGNED NOT NULL,
  `invoice_id` INT(10) UNSIGNED NOT NULL,
  -- change from 'NULL' to NOT NULL at line 1235, 1237, 1238 respectively
  `sales_tax_id` INT(10) UNSIGNED NOT NULL,
  `purchase_order_id` INT(10) UNSIGNED NOT NULL,
  `vat_tax_id` INT(10) UNSIGNED NOT NULL,
  `calendar_id` INT(10) UNSIGNED NOT NULL,
  `transaction_amount` DECIMAL(10,2) NOT NULL,
  `transaction_date` DATE NULL DEFAULT NULL,
  `payment_method_type` INT(10) UNSIGNED NOT NULL,
  `transaction_type` INT(10) UNSIGNED NOT NULL,
  `transaction_account` CHAR(15) NULL DEFAULT NULL,
  `payment_account_number` CHAR(19) NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`coa_id`, `invoice_id`, `sales_tax_id`, `purchase_order_id`),
  INDEX `general_ledger_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `general_ledger_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `general_ledger_fk3_idx` (`coa_id` ASC) VISIBLE,
  INDEX `general_ledger_fk4_idx` (`invoice_id` ASC) VISIBLE,
  INDEX `general_ledger_fk5_idx` (`payment_method_type` ASC) VISIBLE,
  INDEX `general_ledger_fk6_idx` (`transaction_type` ASC) VISIBLE,
  INDEX `general_ledger_fk8_idx` (`sales_tax_id` ASC) VISIBLE,
  INDEX `general_ledger_fk9_idx` (`purchase_order_id` ASC) VISIBLE,
  INDEX `general_ledger_pk1` (`coa_id` ASC, `invoice_id` ASC, `sales_tax_id` ASC, `purchase_order_id` ASC) VISIBLE,
  INDEX `general_ledger_fk10_idx` (`calendar_id` ASC) VISIBLE,
  INDEX `general_ledger_fk11_idx` (`vat_tax_id` ASC) VISIBLE,
  CONSTRAINT `general_ledger_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `general_ledger_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `general_ledger_fk3`
    FOREIGN KEY (`coa_id`)
    REFERENCES `storedb`.`chart_of_account` (`account_id`),
  CONSTRAINT `general_ledger_fk4`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `storedb`.`invoice` (`invoice_id`),
  CONSTRAINT `general_ledger_fk5`
    FOREIGN KEY (`payment_method_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `general_ledger_fk6`
    FOREIGN KEY (`transaction_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `general_ledger_fk8`
    FOREIGN KEY (`sales_tax_id`)
    REFERENCES `storedb`.`sales_tax` (`sales_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `general_ledger_fk9`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `storedb`.`purchase_order` (`purchase_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `general_ledger_fk10`
    FOREIGN KEY (`calendar_id`)
    REFERENCES `storedb`.`calendar` (`calendar_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `general_ledger_fk11`
    FOREIGN KEY (`vat_tax_id`)
    REFERENCES `storedb`.`vat_tax` (`vat_tax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`inventory_organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`inventory_organization` ;

CREATE TABLE IF NOT EXISTS `storedb`.`inventory_organization` (
  `organization_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_name` CHAR(20) NOT NULL,
  `organization_type` INT(10) UNSIGNED NOT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`organization_id`),
  INDEX `inventory_organization_fk1_idx` (`organization_type` ASC) VISIBLE,
  INDEX `inventory_organization_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `inventory_organization_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `inventory_organization_fk4_idx` (`active_flag` ASC) VISIBLE,
  INDEX `inventory_organization_fk5` (`organization_type` ASC) VISIBLE,
  CONSTRAINT `inventory_organization_fk1`
    FOREIGN KEY (`organization_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `inventory_organization_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_organization_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_organization_fk4`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`inventory` ;

CREATE TABLE IF NOT EXISTS `storedb`.`inventory` (
  `inventory_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` INT(10) UNSIGNED NOT NULL,
  `org_id` INT(10) UNSIGNED NULL,
  `in_stock_date` DATE NULL DEFAULT NULL,
  `out_stock_date` DATE NULL DEFAULT NULL,
  `consumed_by` INT(10) UNSIGNED NULL DEFAULT NULL,
  `consumed_date` DATE NULL DEFAULT NULL,
  `inventory_item_type` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `inventory_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `inventory_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `inventory_fk3_idx` (`item_id` ASC) VISIBLE,
  INDEX `inventory_fk5_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `inventory_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_fk3`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `inventory_fk5`
    FOREIGN KEY (`org_id`)
    REFERENCES `storedb`.`inventory_organization` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`inventory_organization_structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`inventory_organization_structure` ;

CREATE TABLE IF NOT EXISTS `storedb`.`inventory_organization_structure` (
  `org_structure_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_parent_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_child_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_type` INT(10) UNSIGNED NOT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`org_structure_id`),
  INDEX `inventory_organization_structure_fk1_idx` (`organization_id` ASC) VISIBLE,
  INDEX `inventory_organization_structure_fk2_idx` (`org_structure_type` ASC) VISIBLE,
  INDEX `inventory_organization_structure_fk3_idx` (`created_by` ASC) VISIBLE,
  INDEX `inventory_organization_structure_fk4_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `inventory_organization_structure_fk5_idx` (`active_flag` ASC) VISIBLE,
  INDEX `inventory_organization_structure_fk6` (`org_structure_child_id` ASC) VISIBLE,
  CONSTRAINT `inventory_organization_structure_fk1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `storedb`.`inventory_organization` (`organization_id`),
  CONSTRAINT `inventory_organization_structure_fk2`
    FOREIGN KEY (`org_structure_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `inventory_organization_structure_fk3`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_organization_structure_fk4`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `inventory_organization_structure_fk5`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`invoice_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`invoice_item` ;

CREATE TABLE IF NOT EXISTS `storedb`.`invoice_item` (
  `invoice_id` INT(10) UNSIGNED NOT NULL,
  `item_id` INT(10) UNSIGNED NOT NULL,
  `inventory_id` INT(10) UNSIGNED NOT NULL,
  `invoice_item_amount` DECIMAL(10,2) NOT NULL,
  `created_by` INT(10) UNSIGNED NULL DEFAULT NULL,
  `creation_date` DATE NULL DEFAULT NULL,
  `last_updated_by` INT(10) UNSIGNED NULL DEFAULT NULL,
  `last_update_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`item_id`, `invoice_id`, `inventory_id`),
  INDEX `invoice_item_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `invoice_item_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `invoice_item_fk3_idx` (`item_id` ASC) VISIBLE,
  INDEX `invoice_item_fk4_idx` (`invoice_id` ASC) VISIBLE,
  INDEX `invoice_item_fk5_idx` (`inventory_id` ASC) VISIBLE,
  INDEX `invoice_item_pk1` (`invoice_id` ASC, `inventory_id` ASC, `item_id` ASC) VISIBLE,
  CONSTRAINT `invoice_item_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `invoice_item_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `invoice_item_fk3`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `invoice_item_fk4`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `storedb`.`invoice` (`invoice_id`),
  CONSTRAINT `invoice_item_fk5`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `storedb`.`inventory` (`inventory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`organization_structure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`organization_structure` ;

CREATE TABLE IF NOT EXISTS `storedb`.`organization_structure` (
  `org_structure_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_parent_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_child_id` INT(10) UNSIGNED NOT NULL,
  `org_structure_type` INT(10) UNSIGNED NOT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`org_structure_id`),
  INDEX `organization_structure_fk1_idx` (`organization_id` ASC) VISIBLE,
  INDEX `organization_structure_fk2_idx` (`org_structure_type` ASC) VISIBLE,
  INDEX `organization_structure_fk3_idx` (`created_by` ASC) VISIBLE,
  INDEX `organization_structure_fk4_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `organization_structure_fk5_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `organization_structure_fk1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `storedb`.`organization` (`organization_id`),
  CONSTRAINT `organization_structure_fk2`
    FOREIGN KEY (`org_structure_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `organization_structure_fk3`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `organization_structure_fk4`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `organization_structure_fk5`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`po_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`po_item` ;

CREATE TABLE IF NOT EXISTS `storedb`.`po_item` (
  `po_item_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_order_id` INT(10) UNSIGNED NOT NULL,
  `item_id` INT(10) UNSIGNED NOT NULL,
  `inventory_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`po_item_id`),
  INDEX `po_item_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `po_item_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `po_item_fk3_idx` (`purchase_order_id` ASC) VISIBLE,
  INDEX `po_item_fk4_idx` (`item_id` ASC) VISIBLE,
  INDEX `po_item_fk5_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `po_item_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `po_item_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `po_item_fk3`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `storedb`.`purchase_order` (`purchase_order_id`),
  CONSTRAINT `po_item_fk4`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `po_item_fk5`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `storedb`.`inventory` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`price` ;

CREATE TABLE IF NOT EXISTS `storedb`.`price` (
  `price_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `price_type` INT(10) UNSIGNED NOT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `price_amount` DECIMAL(10,2) UNSIGNED NULL DEFAULT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`price_id`),
  INDEX `price_id_fk1_idx` (`item_id` ASC) VISIBLE,
  INDEX `price_id_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `price_id_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `price_id_fk4_idx` (`active_flag` ASC) VISIBLE,
  INDEX `price_fk5_idx` (`price_type` ASC) VISIBLE,
  CONSTRAINT `price_id_fk1`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `price_id_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `price_id_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `price_id_fk4`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `price_fk5`
    FOREIGN KEY (`price_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`rental_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`rental_item` ;

CREATE TABLE IF NOT EXISTS `storedb`.`rental_item` (
  `rental_item_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rental_id` INT(10) UNSIGNED NOT NULL,
  `item_id` INT(10) UNSIGNED NOT NULL,
  `inventory_id` INT(10) UNSIGNED NOT NULL,
  `rental_item_type` INT(10) UNSIGNED NULL,
  `rental_item_price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `rental_type` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`rental_item_id`),
  UNIQUE INDEX `natural_key` (`rental_item_id` ASC, `rental_id` ASC, `item_id` ASC, `rental_item_type` ASC, `rental_item_price` ASC) VISIBLE,
  INDEX `rental_item_fk1_idx` (`rental_id` ASC) VISIBLE,
  INDEX `rental_item_fk2_idx` (`item_id` ASC) VISIBLE,
  INDEX `rental_item_fk3_idx` (`created_by` ASC) VISIBLE,
  INDEX `rental_item_fk4_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `rental_item_fk5_idx` (`rental_item_type` ASC) VISIBLE,
  INDEX `rental_item_fk6_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `rental_item_fk1`
    FOREIGN KEY (`rental_id`)
    REFERENCES `storedb`.`rental` (`rental_id`),
  CONSTRAINT `rental_item_fk2`
    FOREIGN KEY (`item_id`)
    REFERENCES `storedb`.`item` (`item_id`),
  CONSTRAINT `rental_item_fk3`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `rental_item_fk4`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `rental_item_fk5`
    FOREIGN KEY (`rental_item_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `rental_item_fk6`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `storedb`.`inventory` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`salary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`salary` ;

CREATE TABLE IF NOT EXISTS `storedb`.`salary` (
  `salary_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `salary_type` INT(10) UNSIGNED NOT NULL,
  `payday_type` INT(10) UNSIGNED NOT NULL,
  `pay_type` INT(10) UNSIGNED NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `salary_amount` DECIMAL(10,2) NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`salary_id`),
  INDEX `salary_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `salary_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `salary_fk3_idx` (`salary_type` ASC) VISIBLE,
  INDEX `salary_fk4_idx` (`payday_type` ASC) VISIBLE,
  INDEX `salary_fk5_idx` (`contact_id` ASC) VISIBLE,
  INDEX `salary_fk6_idx` (`pay_type` ASC) VISIBLE,
  CONSTRAINT `salary_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `salary_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `salary_fk3`
    FOREIGN KEY (`salary_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `salary_fk4`
    FOREIGN KEY (`payday_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `salary_fk5`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `salary_fk6`
    FOREIGN KEY (`pay_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`street_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`street_address` ;

CREATE TABLE IF NOT EXISTS `storedb`.`street_address` (
  `street_address_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT(10) UNSIGNED NOT NULL,
  `street_address_name` CHAR(60) NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`street_address_id`),
  INDEX `street_address_fk1_idx` (`address_id` ASC) VISIBLE,
  INDEX `street_address_fk2_idx` (`created_by` ASC) VISIBLE,
  INDEX `street_address_fk3_idx` (`last_updated_by` ASC) VISIBLE,
  CONSTRAINT `street_address_fk1`
    FOREIGN KEY (`address_id`)
    REFERENCES `storedb`.`address` (`address_id`),
  CONSTRAINT `street_address_fk2`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `street_address_fk3`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`telephone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`telephone` ;

CREATE TABLE IF NOT EXISTS `storedb`.`telephone` (
  `telephone_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(10) UNSIGNED NOT NULL,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `address_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `telephone_type` INT(10) UNSIGNED NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  `area_code` CHAR(6) NOT NULL,
  `telephone_number` CHAR(10) NOT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `start_active_date` DATE NOT NULL,
  `end_active_date` DATE NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`telephone_id`),
  INDEX `telephone_fk2_idx` (`address_id` ASC) VISIBLE,
  INDEX `telephone_fk3_idx` (`created_by` ASC) VISIBLE,
  INDEX `telephone_fk4_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `telephone_fk5_idx` (`organization_id` ASC) VISIBLE,
  INDEX `telephone_fk6_idx` (`active_flag` ASC) VISIBLE,
  INDEX `telephone_fk7_idx` (`telephone_type` ASC) VISIBLE,
  INDEX `telephone_fk8_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `telephone_fk2`
    FOREIGN KEY (`address_id`)
    REFERENCES `storedb`.`address` (`address_id`),
  CONSTRAINT `telephone_fk3`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `telephone_fk4`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `telephone_fk5`
    FOREIGN KEY (`organization_id`)
    REFERENCES `storedb`.`organization` (`organization_id`),
  CONSTRAINT `telephone_fk6`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `telephone_fk7`
    FOREIGN KEY (`telephone_type`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`),
  CONSTRAINT `telephone_fk8`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`genre_source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`genre_source` ;

CREATE TABLE IF NOT EXISTS `storedb`.`genre_source` (
  `genre_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`genre_id`, `contact_id`),
  INDEX `genre_source_uq1` (`genre_id` ASC, `contact_id` ASC) VISIBLE,
  INDEX `genre_source_fk1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `genre_source_fk2_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `genre_source_fk1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `storedb`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `genre_source_fk2`
    FOREIGN KEY (`contact_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `storedb`.`employment_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`employment_history` ;

CREATE TABLE IF NOT EXISTS `storedb`.`employment_history` (
  `employment_history_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` INT(10) UNSIGNED NOT NULL,
  `employment_start_date` DATE NOT NULL,
  `employment_end_date` DATE NULL DEFAULT NULL,
  `active_flag` INT(10) UNSIGNED NOT NULL,
  `created_by` INT(10) UNSIGNED NOT NULL,
  `creation_date` DATE NOT NULL,
  `last_updated_by` INT(10) UNSIGNED NOT NULL,
  `last_update_date` DATE NOT NULL,
  PRIMARY KEY (`employment_history_id`),
  INDEX `employment_history_fk1_idx` (`created_by` ASC) VISIBLE,
  INDEX `employment_history_fk2_idx` (`last_updated_by` ASC) VISIBLE,
  INDEX `employment_history_fk3_idx` (`employee_id` ASC) VISIBLE,
  INDEX `employment_history_fk4_idx` (`active_flag` ASC) VISIBLE,
  CONSTRAINT `employment_history_fk1`
    FOREIGN KEY (`created_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employment_history_fk2`
    FOREIGN KEY (`last_updated_by`)
    REFERENCES `storedb`.`system_user` (`system_user_id`),
  CONSTRAINT `employment_history_fk3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `storedb`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employment_history_fk4`
    FOREIGN KEY (`active_flag`)
    REFERENCES `storedb`.`common_lookup` (`common_lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `storedb` ;

-- -----------------------------------------------------
-- Placeholder table for view `storedb`.`current_rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `storedb`.`current_rental` (`account_number` INT, `full_name` INT, `TITLE` INT, `SUBTITLE` INT, `PRODUCT` INT, `check_out_date` INT, `expected_return_date` INT, `actual_return_date` INT);

-- -----------------------------------------------------
-- View `storedb`.`current_rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `storedb`.`current_rental`;
DROP VIEW IF EXISTS `storedb`.`current_rental` ;
USE `storedb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`student`@`localhost` SQL SECURITY DEFINER VIEW `current_rental` AS select `m`.`account_number` AS `account_number`,(case when (`c`.`middle_name` is not null) then (`c`.`first_name` or ' ' or `c`.`middle_name` or ' ' or `c`.`last_name`) else (`c`.`first_name` or ' ' or `c`.`last_name`) end) AS `full_name`,`i`.`item_title` AS `TITLE`,`i`.`item_subtitle` AS `SUBTITLE`,substr(`cl`.`common_lookup_meaning`,1,3) AS `PRODUCT`,`r`.`check_out_date` AS `check_out_date`,`r`.`expected_return_date` AS `expected_return_date`,`r`.`actual_return_date` AS `actual_return_date` from (((((`common_lookup` `cl` join `contact` `c`) join `item` `i`) join `member` `m`) join `rental` `r`) join `rental_item` `ri`) where ((`r`.`contact_id` = `c`.`contact_id`) and (`r`.`rental_id` = `ri`.`rental_id`) and (`ri`.`item_id` = `i`.`item_id`) and (`i`.`item_type` = `cl`.`common_lookup_id`) and (`c`.`member_id` = `m`.`member_id`)) order by 1,2,3;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SHOW TABLES FROM storedb;


