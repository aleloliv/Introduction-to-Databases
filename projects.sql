-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projects
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projects` DEFAULT CHARACTER SET utf8 ;
USE `projects` ;
-- -----------------------------------------------------
-- Table `projects`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects`.`projects` ;

CREATE TABLE IF NOT EXISTS `projects`.`projects` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `project_name` VARCHAR(100) NOT NULL,
  `project_due_date` DATETIME NOT NULL,
  `project_owner` VARCHAR(100) NOT NULL,
  `project_type` VARCHAR(100) NOT NULL,
  `allowed_files` VARCHAR(100) NOT NULL,
  `project_scope` LONGTEXT NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `projects`.`tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects`.`tasks` ;

CREATE TABLE IF NOT EXISTS `projects`.`tasks` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `task_name` VARCHAR(100) NOT NULL,
  `task_description` VARCHAR(255) NOT NULL,
  `task_start` DATETIME NOT NULL,
  `task_end` DATETIME NOT NULL,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`task_id`),
  INDEX `fk_tasks_projects_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_tasks_projects`
    FOREIGN KEY (`project_id`)
    REFERENCES `projects`.`projects` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `projects`.`designers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects`.`designers` ;

CREATE TABLE IF NOT EXISTS `projects`.`designers` (
  `designer_id` INT NOT NULL AUTO_INCREMENT,
  `designer_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`designer_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `projects`.`assigned_designer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projects`.`assigned_designer` ;

CREATE TABLE IF NOT EXISTS `projects`.`assigned_designer` (
  `designer_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`designer_id`, `task_id`),
  INDEX `fk_assigned_designer_tasks1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_assigned_designer_designers1_idx` (`designer_id` ASC) VISIBLE,
  CONSTRAINT `fk_assigned_designer_designers1`
    FOREIGN KEY (`designer_id`)
    REFERENCES `projects`.`designers` (`designer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_designer_tasks1`
    FOREIGN KEY (`task_id`)
    REFERENCES `projects`.`tasks` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

DROP TABLE IF EXISTS `projects`.`formats` ;

CREATE TABLE IF NOT EXISTS `projects`.`formats` (
	`format_id` INT NOT NULL AUTO_INCREMENT,
    `file_format` VARCHAR(10) NOT NULL,
    `project_id` INT NOT NULL,
    PRIMARY KEY(`format_id`),
	INDEX `fk_formats_projects_idx` (`project_id` ASC) VISIBLE,
	CONSTRAINT `fk_formats_projects`
		FOREIGN KEY (`project_id`)
        REFERENCES `projects`.`projects` (`project_id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;