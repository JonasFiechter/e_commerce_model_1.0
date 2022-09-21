CREATE SCHEMA IF NOT EXISTS `e_commerce` DEFAULT CHARACTER SET utf8 ;
USE `e_commerce` ;

-- -----------------------------------------------------
-- Table `e_commerce`.`custommer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`custommer` (
  `id_custommer` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_custommer`));


-- -----------------------------------------------------
-- Table `e_commerce`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`seller` (
  `id_seller` INT NOT NULL AUTO_INCREMENT,
  `identification` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_seller`));


-- -----------------------------------------------------
-- Table `e_commerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_seller1_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `e_commerce`.`seller` (`id_seller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`cart` (
  `id_cart` INT NOT NULL AUTO_INCREMENT,
  `custommer_id` INT NOT NULL,
  `creation_date` DATETIME NOT NULL,
  PRIMARY KEY (`id_cart`),
  INDEX `fk_cart_custommer1_idx` (`custommer_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_custommer1`
    FOREIGN KEY (`custommer_id`)
    REFERENCES `e_commerce`.`custommer` (`id_custommer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`purchase` (
  `id_purchase` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATE NOT NULL,
  `cart_id_cart` INT NOT NULL,
  PRIMARY KEY (`id_purchase`, `cart_id_cart`),
  INDEX `fk_purchase_cart_idx` (`cart_id_cart` ASC) VISIBLE,
  CONSTRAINT `fk_purchase_cart`
    FOREIGN KEY (`cart_id_cart`)
    REFERENCES `e_commerce`.`cart` (`id_cart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`cart_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`cart_has_product` (
  `cart_id_cart` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`cart_id_cart`, `product_id`),
  INDEX `fk_cart_has_product_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_cart_has_product_cart1_idx` (`cart_id_cart` ASC) VISIBLE,
  CONSTRAINT `fk_cart_has_product_cart1`
    FOREIGN KEY (`cart_id_cart`)
    REFERENCES `e_commerce`.`cart` (`id_cart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_commerce`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NULL,
  `phone_3` VARCHAR(45) NULL,
  PRIMARY KEY (`id_supplier`));


-- -----------------------------------------------------
-- Table `e_commerce`.`product_has_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`product_has_supplier` (
  `product_id_product` INT NOT NULL,
  `supplier_id_supplier` INT NOT NULL,
  PRIMARY KEY (`product_id_product`, `supplier_id_supplier`),
  INDEX `fk_product_has_supplier_supplier1_idx` (`supplier_id_supplier` ASC) VISIBLE,
  INDEX `fk_product_has_supplier_product1_idx` (`product_id_product` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_supplier_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `e_commerce`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_supplier_supplier1`
    FOREIGN KEY (`supplier_id_supplier`)
    REFERENCES `e_commerce`.`supplier` (`id_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`stock` (
  `id_stock` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_stock`));


-- -----------------------------------------------------
-- Table `e_commerce`.`product_has_stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`product_has_stock` (
  `stock_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `ammount` INT NOT NULL,
  PRIMARY KEY (`stock_id`, `product_id`),
  INDEX `fk_product_has_stock_stock1_idx` (`stock_id` ASC) VISIBLE,
  INDEX `fk_product_has_stock_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_stock_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_commerce`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_stock_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `e_commerce`.`stock` (`id_stock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`person` (
  `id_person` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `birth_date` DATE NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NULL,
  `custommer_id` INT NOT NULL,
  PRIMARY KEY (`id_person`),
  CONSTRAINT `fk_person_custommer1`
    FOREIGN KEY (`custommer_id`)
    REFERENCES `e_commerce`.`custommer` (`id_custommer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `e_commerce`.`entity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`entity` (
  `id_entity` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `since` DATE NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_1` VARCHAR(45) NOT NULL,
  `phone_2` VARCHAR(45) NULL,
  `phone_3` VARCHAR(45) NULL,
  `custommer_id` INT NOT NULL,
  PRIMARY KEY (`id_entity`),
  CONSTRAINT `fk_entity_custommer1`
    FOREIGN KEY (`custommer_id`)
    REFERENCES `e_commerce`.`custommer` (`id_custommer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `e_commerce`.`payment_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`payment_card` (
  `id_payment_card` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `card_owner` VARCHAR(100) NOT NULL,
  `secure_key` INT NOT NULL,
  `custommer_id_custommer` INT NOT NULL,
  PRIMARY KEY (`id_payment_card`),
  INDEX `fk_payment_card_custommer1_idx` (`custommer_id_custommer` ASC) VISIBLE,
  CONSTRAINT `fk_payment_card_custommer1`
    FOREIGN KEY (`custommer_id_custommer`)
    REFERENCES `e_commerce`.`custommer` (`id_custommer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `e_commerce`.`deliver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`deliver` (
  `id_deliver` INT NOT NULL AUTO_INCREMENT,
  `track_code` VARCHAR(100) NOT NULL,
  `purchase_id` INT NOT NULL,
  `purchase_cart_id` INT NOT NULL,
  PRIMARY KEY (`id_deliver`, `purchase_id`, `purchase_cart_id`),
  UNIQUE INDEX `track_code_UNIQUE` (`track_code` ASC) VISIBLE,
  INDEX `fk_deliver_purchase1_idx` (`purchase_id` ASC, `purchase_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_deliver_purchase1`
    FOREIGN KEY (`purchase_id` , `purchase_cart_id`)
    REFERENCES `e_commerce`.`purchase` (`id_purchase` , `cart_id_cart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);