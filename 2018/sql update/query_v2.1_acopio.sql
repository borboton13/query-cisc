/** 13.07.2018 **/
ALTER TABLE productormateriaprima ADD COLUMN idpersonacliente BIGINT(20) NULL;
ALTER TABLE personacliente ADD COLUMN idproductormateriaprima BIGINT(20) NULL;
ALTER TABLE productormateriaprima ADD FOREIGN KEY (idpersonacliente) REFERENCES personacliente(idpersonacliente);
ALTER TABLE personacliente ADD FOREIGN KEY (idproductormateriaprima) REFERENCES productormateriaprima(idproductormateriaprima);

-- v2.3 hecho
-- ALTER TABLE inv_vales ADD COLUMN idtmpenc BIGINT(20) NULL;