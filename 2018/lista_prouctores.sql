SELECT P.IDPERSONA, E.NOIDENTIFICACION, P.APELLIDOPATERNO, P.APELLIDOMATERNO, P.NOMBRES, Z.IDZONAPRODUCTIVA, Z.NOMBRE, Z.NUMERO
FROM PRODUCTORMATERIAPRIMA PM
LEFT JOIN ZONAPRODUCTIVA Z  ON PM.IDZONAPRODUCTIVA = Z.IDZONAPRODUCTIVA
LEFT JOIN PERSONA P         ON PM.IDPRODUCTORMATERIAPRIMA = P.IDPERSONA
LEFT JOIN ENTIDAD E         ON PM.IDPRODUCTORMATERIAPRIMA = E.IDENTIDAD
