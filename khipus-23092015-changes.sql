ALTER TABLE `inv_product` ADD CONSTRAINT PK_INV_PRODUCT PRIMARY KEY (id_inv_prod);

CREATE TABLE `registroinvproducto` (
  `idregistroinvproducto` BIGINT(20) NOT NULL,
  `fecha` DATETIME,
  `cod_art` VARCHAR(6),
  `cantidad` DECIMAL(12,2),
  `tipo` VARCHAR(64),
  `tipomovimiento` VARCHAR(64),
  `descripcion` VARCHAR(255),
  `id_inv_prod` BIGINT(20),
  PRIMARY KEY (`idregistroinvproducto`)
);

ALTER TABLE registroinvproducto ADD CONSTRAINT FK_INV_PRODUCT FOREIGN KEY (id_inv_prod) REFERENCES `inv_product` (id_inv_prod);


ALTER TABLE ventadirecta ADD flagstock INT(11) DEFAULT 0;
ALTER TABLE pedidos ADD flagstock INT(11) DEFAULT 0;

