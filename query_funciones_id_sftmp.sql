DELIMITER $$
CREATE FUNCTION `newId_sf_tmpenc`() RETURNS INT
BEGIN
    DECLARE nLast_val INT;
    SET nLast_val =  (SELECT valor
                          FROM secuencia
                          WHERE tabla = 'sf_tmpenc');
        SET nLast_val = nLast_val + 1;
        UPDATE secuencia SET valor = nLast_val
        WHERE tabla = 'sf_tmpenc';
    RETURN nLast_val;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `newId_sf_tmpdet`() RETURNS INT
BEGIN
    DECLARE nLast_val INT;
    SET nLast_val =  (SELECT valor
                          FROM secuencia
                          WHERE tabla = 'sf_tmpdet');
        SET nLast_val = nLast_val + 1;
        UPDATE secuencia SET valor = nLast_val
        WHERE tabla = 'sf_tmpdet';
    RETURN nLast_val;
END$$
DELIMITER ;

SELECT *
FROM secuencia
WHERE tabla = 'sf_tmpenc'
;

SELECT nextIdSFTmpEnc();