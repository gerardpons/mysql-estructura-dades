CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8;

USE `pizzeria`;

CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `localidad_id` INT NOT NULL,
  `provincia_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  INDEX `fk_cliente_provincia1_idx` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `provincia_id` INT NOT NULL,
  `localidad_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tienda_provincia1_idx` (`provincia_id` ASC) VISIBLE,
  INDEX `fk_tienda_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `cargo` ENUM('repartidor', 'cocinero') NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleado_tienda2_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_tienda2`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id` INT NOT NULL,
  `fecha_hora` VARCHAR(45) NULL,
  `tipo` ENUM('domicilio', 'recoger') NULL,
  `precio` VARCHAR(45) NULL,
  `cliente_id` INT NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_pedido_tienda2_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda2`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizza_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `pizzeria`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`bebida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado_pedido` (
  `empleado_id` INT NOT NULL,
  `pedido_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`empleado_id`, `pedido_id`),
  INDEX `fk_empleado_has_pedido_pedido2_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_empleado_has_pedido_empleado2_idx` (`empleado_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_has_pedido_empleado2`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_has_pedido_pedido2`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_pizza` (
  `pedido_id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pedido_id`, `pizza_id`),
  INDEX `fk_pedido_has_pizza_pizza1_idx` (`pizza_id` ASC) VISIBLE,
  INDEX `fk_pedido_has_pizza_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_pizza_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `pizzeria`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_hamburguesa` (
  `pedido_id` INT NOT NULL,
  `hamburguesa_id` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pedido_id`, `hamburguesa_id`),
  INDEX `fk_pedido_has_hamburguesa_hamburguesa1_idx` (`hamburguesa_id` ASC) VISIBLE,
  INDEX `fk_pedido_has_hamburguesa_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_has_hamburguesa_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_hamburguesa_hamburguesa1`
    FOREIGN KEY (`hamburguesa_id`)
    REFERENCES `pizzeria`.`hamburguesa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `pizzeria`.`bebida_pedido` (
  `bebida_id` INT NOT NULL,
  `pedido_id` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bebida_id`, `pedido_id`),
  INDEX `fk_bebida_has_pedido_pedido1_idx` (`pedido_id` ASC) VISIBLE,
  INDEX `fk_bebida_has_pedido_bebida1_idx` (`bebida_id` ASC) VISIBLE,
  CONSTRAINT `fk_bebida_has_pedido_bebida1`
    FOREIGN KEY (`bebida_id`)
    REFERENCES `pizzeria`.`bebida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bebida_has_pedido_pedido1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);