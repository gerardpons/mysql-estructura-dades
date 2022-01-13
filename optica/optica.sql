CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;

USE `optica` ;

CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `nif` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `fax` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`nif`));

CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `proveedor_nif` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_marca_proveedor1_idx` (`proveedor_nif` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_nif`)
    REFERENCES `optica`.`proveedor` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grad_derecho` VARCHAR(45) NOT NULL,
  `grad_izquierdo` VARCHAR(45) NOT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_cristal` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `marca_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_marca1_idx` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `optica`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `referido` INT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `optica`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `optica`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `empleado_id` INT NOT NULL,
  `gafas_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleado_vende_gafas_empleado1_idx` (`empleado_id` ASC) VISIBLE,
  INDEX `fk_empleado_vende_gafas_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  INDEX `fk_venta_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_vende_gafas_empleado1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `optica`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_vende_gafas_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `optica`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);