select s.`idsocio`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`idcredito`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`fechapago`, c.`importe`, c.`saldo`, c.`cuota`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`
from credito c
join socio s on c.`idsocio` = s.`idsocio`
join zonaproductiva z on s.`idzonaproductiva` = z.`idzonaproductiva`
join tipocredito t on c.`idtipocredito` = t.`idtipocredito`
-- where c.`idtipocredito` = 2
-- where s.`idzonaproductiva` = 6
where z.`numero` = 17
;



select s.`idsocio`, c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`fechaconcesion`, c.`importe`, c.`saldo`, c.`ultimopago`, c.`idtipocredito`,
t.`nombre`, tr.`tipo`, tr.`id_tmpenc`
from credito c
join socio s 			on c.`idsocio` = s.`idsocio`
join tipocredito t 		on c.`idtipocredito` = t.`idtipocredito`
join transaccioncredito tr 	on c.`idcredito` = tr.`idcredito`
where c.`idtipocredito` = 1
;

-- ESTADO DE CARTERA VIGENTE
select c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`importe`, max(t.fechatransaccion) as fecha, 
sum(t.`capital`) as pagado, c.`importe` - sum(t.`capital`) as saldo
from credito c
join socio s 			on c.`idsocio` = s.`idsocio`
join transaccioncredito t 	on c.`idcredito` = t.`idcredito`
where c.`estado` = 'VIG'
and t.`fechatransaccion` <= '2019-01-31'
group by c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`importe`
;
-- 
select max(t.fechatransaccion) as fecha, sum(t.`capital`) as pagado, c.`importe` - sum(t.`capital`) as saldo
from credito c
join socio s 			on c.`idsocio` = s.`idsocio`
join transaccioncredito t 	on c.`idcredito` = t.`idcredito`
where c.idcredito = 29
and t.`fechatransaccion` <= '2019-01-31'
-- group by c.`idcredito`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, c.`codigoant`, c.`estado`, c.`importe`
;
-- 


select e.`fecha`, e.`tipo_doc`, e.`no_doc`, e.`glosa`, c.`idcredito`, c.`codigo`, c.`codigoant`, s.`nombres`, s.`apellidopaterno`, s.`apellidomaterno`, 
concat(s.`nombres`,' ', s.`apellidopaterno`, ' ', s.`apellidomaterno`, ' ', c.`codigoant`, ', ', e.`glosa`)
from sf_tmpenc e
join sf_tmpdet d on e.`id_tmpenc` = d.`id_tmpenc`
join credito c on d.`idcredito` = c.`idcredito`
join socio s on c.`idsocio` = s.`idsocio`
where e.`tipo_doc` = 'CE'
;


select t.`idtransaccioncredito`, t.`idcredito`, t.`fechacreacion`, t.`fechatransaccion`, e.`fecha`
from transaccioncredito t 
join sf_tmpenc e on t.`id_tmpenc` = e.`id_tmpenc`
;

select t.`idtransaccioncredito`, t.`idcredito`, t.`fechacreacion`, t.`fechatransaccion`, e.`fecha`, e.`tipo_doc`, e.`no_doc`
from sf_tmpenc e 
join transaccioncredito t on e.`id_tmpenc` = t.`id_tmpenc`
where e.`fecha` <> t.`fechatransaccion`
;

-- update sf_tmpenc e 
join transaccioncredito t on e.`id_tmpenc` = t.`id_tmpenc`
set e.`fecha` = t.`fechatransaccion`
where e.`fecha` <> t.`fechatransaccion`
;

-- PARA ESTADO DE CARTERA
select z.`nombre`, s.`nombres`, s.`apellidopaterno`, c.`codigoant`, c.estado, tc.`idmoneda`, c.`fechaconcesion`, c.`ultimopago`, c.`fechavence`, c.`importe`, sum(t.`capital`) as capital, (c.`importe` - sum(t.`capital`)) as saldo_capital,
max(t.`fechatransaccion`) as ultima
from transaccioncredito t
left join credito c on t.`idcredito` = c.`idcredito`
left join socio s on c.`idsocio` = s.`idsocio`
left join zonaproductiva z on s.`idzonaproductiva` = z.`idzonaproductiva`
left join tipocredito tc on c.`idtipocredito` = tc.`idtipocredito`
where c.estado <> 'FIN'
and z.`numero` = 15
-- and tc.`idmoneda` = 2
and t.`fechatransaccion` <= '2020-01-31'
group by z.`nombre`, s.`nombres`, s.`apellidopaterno`, c.`codigoant`, c.`fechaconcesion`, c.`ultimopago`, c.`fechavence`, c.`importe`
;



