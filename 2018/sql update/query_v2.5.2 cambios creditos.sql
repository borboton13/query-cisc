/** 29/08/2018 **/
ALTER TABLE socio ADD COLUMN nsocio VARCHAR(10) AFTER nosocio;
ALTER TABLE credito ADD COLUMN codigoant VARCHAR(15) AFTER codigo; 