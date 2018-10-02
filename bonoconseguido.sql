SELECT bc.`idbonoconseguido`, b.`tipobono`, b.`idbono`, b.`nombre`, bc.`monto`, c.`mes`, bc.`idcontratopuesto`
FROM bonoconseguido bc
JOIN bono b 			ON bc.`idbono` = b.`idbono`
JOIN ciclogeneracionplanilla c 	ON bc.`idciclogeneracionplanilla` = c.`idciclogeneracionplanilla`
;


UPDATE bonoconseguido b SET b.`idbono` = 9
WHERE b.`idbonoconseguido` IN (

);

DELETE FROM bonoconseguido 
WHERE idbonoconseguido IN (

);


