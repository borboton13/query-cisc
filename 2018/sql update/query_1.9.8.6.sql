/** 24.06.2018 **/
INSERT INTO secuencia (tabla, valor) VALUES ('pedidos', 0);
INSERT INTO secuencia (tabla, valor) VALUES ('articulos_pedido', 0);

UPDATE secuencia SET valor = (SELECT MAX(p.`IDARTICULOSPEDIDO`)+1 FROM articulos_pedido p) 
WHERE tabla='articulos_pedido';

/** 26.06.2018 **/
