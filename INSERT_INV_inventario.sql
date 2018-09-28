
-- -----------------------------------------------
-- -----------------------------------------------
-- Insert PRODUCTOS VETERINARIOS (revisar cod almacen)
-- -----------------------------------------------
-- -----------------------------------------------
INSERT INTO inv_inventario (cod_art, no_cia, cod_alm, saldo_uni, VERSION )
SELECT cod_art, no_cia, 5, 0 , 0  -- , descri, `saldo_fis`
-- SELECT cod_art, no_cia, 5, `saldo_fis`, 0
FROM inv_articulos
WHERE COD_ART = 633
-- WHERE cod_gru IN ( 9,10,11,12,13,14,15,16 )
-- WHERE cod_gru IN (8)
-- WHERE cuenta_art = '4420110201'
-- AND COD_ART IN (589, 594)
-- and saldo_fis > 0
;

-- Insert inv_inventario_detalle
SET @folio = 640;
INSERT INTO inv_inventario_detalle (id_inv_det,no_cia,cod_cc,cod_art,cantidad,VERSION,cod_alm,idunidadnegocio)
SELECT (@folio := @folio + 1), '01', '0111', cod_art, saldo_uni, 0, 5, 470
FROM inv_inventario
WHERE cod_alm = 5
AND COD_ART IN (633)
-- AND COD_ART > 433
;

SELECT *
FROM inv_inventario i
WHERE i.`cod_art` IN (

);

-- -----------------------------------------------
-- -----------------------------------------------

-- -----------------------------------------------
-- -----------------------------------------------
-- Insert MATERIALES DE PRODUCCION
-- -----------------------------------------------
-- -----------------------------------------------
-- INSERT INTO inv_inventario (cod_art, no_cia, cod_alm, saldo_uni, VERSION )
SELECT cod_art, no_cia, 3, 0 , 0  -- , descri, `saldo_fis`, 
FROM inv_articulos
-- WHERE cuenta_art <> '4430110900'
WHERE COD_ART IN (531)
-- and saldo_fis > 0
;

-- Insert inv_inventario_detalle
-- SET @folio = 411;
-- INSERT INTO inv_inventario_detalle (id_inv_det,no_cia,cod_cc,cod_art,cantidad,VERSION,cod_alm,idunidadnegocio)
SELECT (@folio := @folio + 1), '01', '0111', cod_art, saldo_uni, 0, 3, 470
FROM inv_inventario
WHERE cod_alm = 3
AND COD_ART IN (531)
-- AND COD_ART > 433
;
-- -----------------------------------------------
-- -----------------------------------------------

-- -----------------------------------------------
-- -----------------------------------------------
-- Insert INSUMOS DE PRODUCCION
-- -----------------------------------------------
-- -----------------------------------------------
-- INSERT INTO inv_inventario (cod_art, no_cia, cod_alm, saldo_uni, VERSION )
SELECT cod_art, no_cia, 1, 0 , 0  -- , descri, `saldo_fis`
-- SELECT cod_art, no_cia, 5, `saldo_fis`, 0
FROM inv_articulos
WHERE COD_ART = 525
-- WHERE cod_gru IN ( 9,10,11,12,13,14,15,16 )
-- WHERE cod_gru IN (8)
-- WHERE cuenta_art = '4430110900'
-- AND COD_ART IN (528)
-- and saldo_fis > 0
;

-- Insert inv_inventario_detalle
SET @folio = 510;
INSERT INTO inv_inventario_detalle (id_inv_det,no_cia,cod_cc,cod_art,cantidad,VERSION,cod_alm,idunidadnegocio)
SELECT (@folio := @folio + 1), '01', '0111', cod_art, saldo_uni, 0, 1, 470
FROM inv_inventario
WHERE cod_alm = 1
-- AND COD_ART IN (540)
-- AND COD_ART > 433
;
-- -----------------------------------------------
-- -----------------------------------------------

-- REPORTE INVENTARIO
SELECT a.`cod_art`, a.`descri`, a.`costo_uni`, i.`saldo_uni`, a.`saldo_mon`, a.`costo_uni` * i.`saldo_uni`, a.`costo_uni` * a.saldo_fis
FROM inv_articulos a
JOIN inv_inventario i ON a.`cod_art` = i.`cod_art`
WHERE cod_gru = 8
;


SELECT SUM(i.`saldo_uni`)
FROM inv_inventario i
WHERE i.`no_cia` = '01' 
AND i.`cod_art` = 290
;