--no olvidar porner el no_trans en unico
SELECT sigte_trans();

DELIMITER $$

USE `khipus`$$

DROP FUNCTION IF EXISTS `sigte_trans`$$

CREATE DEFINER=`root`@`localhost` FUNCTION `sigte_trans`() RETURNS VARCHAR(10)
BEGIN
	DECLARE var_name VARCHAR(10);
	SET var_name = 0;
	SELECT IFNULL(SUM( @row := @row + 1),0) AS ROW INTO var_name
	FROM khipus.inv_vales t, (SELECT @row := 0) r;
  RETURN var_name +1;
    END$$

DELIMITER ;


DELIMITER $$
USE `khipus`$$
DROP FUNCTION IF EXISTS `sigte_trans`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `sigte_trans`() RETURNS VARCHAR(10)
BEGIN
	DECLARE act_trans VARCHAR(10);
	SET act_trans = 0;
	SELECT MAX(no_trans) INTO act_trans FROM khipus.inv_vales;
  RETURN act_trans+1;
    END$$

DELIMITER ;
