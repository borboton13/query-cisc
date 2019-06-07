select s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`fechapago`, c.`importe`, c.`saldo`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`
from credito c
join socio s on c.`idsocio` = s.`idsocio`
join tipocredito t on c.`idtipocredito` = t.`idtipocredito`
where c.`idtipocredito` = 2
;

select s.`idsocio`, c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`importe`, c.`saldo`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`, tr.`tipo`, tr.`id_tmpenc`
from credito c
join socio s 			on c.`idsocio` = s.`idsocio`
join tipocredito t 		on c.`idtipocredito` = t.`idtipocredito`
join transaccioncredito tr 	on c.`idcredito` = tr.`idcredito`
where c.`idtipocredito` = 2
;