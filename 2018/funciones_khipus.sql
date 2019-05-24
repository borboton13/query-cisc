DELIMITER $$
CREATE FUNCTION `getNextSeq`(sSeqName VARCHAR(50)) RETURNS VARCHAR(10) CHARSET utf8
BEGIN
    DECLARE nLast_val VARCHAR(10);
 
    SET nLast_val =  (SELECT seq_val
                          FROM _sequence
                          WHERE seq_name = sSeqName);
    IF nLast_val IS NULL THEN
        SET nLast_val = 1;
        INSERT INTO _sequence (seq_name,seq_val)
        VALUES (sSeqName,nLast_Val);
    ELSE
        SET nLast_val = nLast_val + 1;
        UPDATE _sequence SET seq_val = nLast_val
        WHERE seq_name = sSeqName;
    END IF;
    
    RETURN nLast_val;
END$$
DELIMITER ;

-- 

DELIMITER $$
CREATE FUNCTION `next_tmpenc`() RETURNS VARCHAR(10) CHARSET utf8
BEGIN
    DECLARE act_trans VARCHAR(10);
    SET act_trans = 0;
    SELECT IFNULL(MAX(no_trans),0) INTO act_trans FROM khipus.sf_tmpenc;
  RETURN act_trans+1;
    END$$
DELIMITER ;


--

DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `sigte_trans`() RETURNS VARCHAR(10) CHARSET utf8
BEGIN
    DECLARE act_trans VARCHAR(10);
    SET act_trans = 0;
    SELECT IFNULL(MAX(no_trans),0) INTO act_trans FROM khipus.inv_vales;
  RETURN act_trans+1;
    END$$
DELIMITER ;


