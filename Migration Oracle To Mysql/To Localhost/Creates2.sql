-- ----------------------------------------------------------------------
-- MySQL Migration Toolkit
-- SQL Create Script
-- ----------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `eos`
  CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `eos`;
-- -------------------------------------
-- Tables

DROP TABLE IF EXISTS `eos`.`acopiomateriaprima`;
CREATE TABLE `eos`.`acopiomateriaprima` (
  `idacopiomateriaprima` DECIMAL(19, 0) NULL,
  `cantidad` DECIMAL(16, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idsesionacopio` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`acreedor`;
CREATE TABLE `eos`.`acreedor` (
  `idacreedor` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(20) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`actividad`;
CREATE TABLE `eos`.`actividad` (
  `idactividad` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(30) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idprograma` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`aflocalizacion`;
CREATE TABLE `eos`.`aflocalizacion` (
  `idaflocalizacion` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ambientedeposito`;
CREATE TABLE `eos`.`ambientedeposito` (
  `idambientedeposito` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddepositoproductoterminado` DECIMAL(19, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`archivo`;
CREATE TABLE `eos`.`archivo` (
  `tipo` VARCHAR(20) BINARY NULL,
  `idarchivo` DECIMAL(19, 0) NULL,
  `tipocontenido` VARCHAR(200) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `tamanio` DECIMAL(19, 0) NULL,
  `valor` LONGBLOB NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`asignatura`;
CREATE TABLE `eos`.`asignatura` (
  `idasignatura` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `idreferencia` VARCHAR(100) BINARY NULL,
  `idcarrera` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`banco`;
CREATE TABLE `eos`.`banco` (
  `fechaactivacion` DATETIME NULL,
  `numeroadenda` VARCHAR(30) BINARY NULL,
  `fechabaja` DATETIME NULL,
  `fechafincontrato` DATETIME NULL,
  `numerocontrato` VARCHAR(50) BINARY NULL,
  `estado` VARCHAR(15) BINARY NULL,
  `fechaestado` DATETIME NULL,
  `idbanco` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`bandahoraria`;
CREATE TABLE `eos`.`bandahoraria` (
  `idbandahoraria` DECIMAL(19, 0) NULL,
  `duracion` BIGINT(10) NULL,
  `diafin` VARCHAR(200) BINARY NULL,
  `horafin` DATETIME NULL,
  `diapormedio` BIGINT(10) NULL,
  `diainicio` VARCHAR(200) BINARY NULL,
  `horainicio` DATETIME NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipobandahoraria` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`bandahorariacontrato`;
CREATE TABLE `eos`.`bandahorariacontrato` (
  `idbandahorariacontrato` DECIMAL(19, 0) NULL,
  `horarioacademico` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `edificio` VARCHAR(255) BINARY NULL,
  `ambiente` VARCHAR(255) BINARY NULL,
  `pivotecosto` BIGINT(10) NULL,
  `fechafin` DATETIME NULL,
  `gestion` BIGINT(10) NULL,
  `grupoasignatura` VARCHAR(200) BINARY NULL,
  `fechainicio` DATETIME NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `nombreasignatura` VARCHAR(200) BINARY NULL,
  `periodo` BIGINT(10) NULL,
  `precioperiodo` DECIMAL(16, 6) NULL,
  `compartido` BIGINT(10) NULL,
  `asignatura` VARCHAR(255) BINARY NULL,
  `tipohora` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idbandahoraria` DECIMAL(19, 0) NULL,
  `idlimite` DECIMAL(19, 0) NULL,
  `idtolerancia` DECIMAL(19, 0) NULL,
  `idtipobandahoraria` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`barrio`;
CREATE TABLE `eos`.`barrio` (
  `idbarrio` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idzona` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`bono`;
CREATE TABLE `eos`.`bono` (
  `idbono` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `tipobono` VARCHAR(30) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddescripcion` DECIMAL(19, 0) NULL,
  `idtasasmn` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`bonoantiguedad`;
CREATE TABLE `eos`.`bonoantiguedad` (
  `fechafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `idbonoantiguedad` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`bonoconseguido`;
CREATE TABLE `eos`.`bonoconseguido` (
  `idbonoconseguido` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idbono` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`caja`;
CREATE TABLE `eos`.`caja` (
  `idcaja` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `descripcion` VARCHAR(150) BINARY NULL,
  `autorizacionrequerida` BIGINT(10) NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `fechaestado` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipocaja` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cajausuario`;
CREATE TABLE `eos`.`cajausuario` (
  `idcaja` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL,
  `fechacierre` DATETIME NULL,
  `fechaapertura` DATETIME NULL,
  `estado` VARCHAR(15) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`calle`;
CREATE TABLE `eos`.`calle` (
  `idcalle` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idbarrio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cambiobandahorario`;
CREATE TABLE `eos`.`cambiobandahorario` (
  `idcambiohorario` DECIMAL(19, 0) NULL,
  `carrera` VARCHAR(255) BINARY NULL,
  `idcarrera` BIGINT(10) NULL,
  `fechacambio` DATETIME NULL,
  `ciactual` BIGINT(10) NULL,
  `diaactual` VARCHAR(255) BINARY NULL,
  `hfinactual` DATETIME NULL,
  `hinicioactual` DATETIME NULL,
  `grupo` VARCHAR(255) BINARY NULL,
  `sede` VARCHAR(255) BINARY NULL,
  `materno` VARCHAR(255) BINARY NULL,
  `nombres` VARCHAR(255) BINARY NULL,
  `cinuevo` BIGINT(10) NULL,
  `dianuevo` VARCHAR(255) BINARY NULL,
  `hfinnuevo` DATETIME NULL,
  `maternonuevo` VARCHAR(255) BINARY NULL,
  `nombresnuevo` VARCHAR(255) BINARY NULL,
  `paternonuevo` VARCHAR(255) BINARY NULL,
  `hinicionuevo` DATETIME NULL,
  `paterno` VARCHAR(255) BINARY NULL,
  `asignatura` VARCHAR(255) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cargo`;
CREATE TABLE `eos`.`cargo` (
  `idcargo` DECIMAL(19, 0) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`carrera`;
CREATE TABLE `eos`.`carrera` (
  `idcarrera` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `idreferencia` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idfacultad` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`categoriacliente`;
CREATE TABLE `eos`.`categoriacliente` (
  `idcategoriacliente` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`categoriaclubsocio`;
CREATE TABLE `eos`.`categoriaclubsocio` (
  `idcategoriaclubsocio` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`categoriapuesto`;
CREATE TABLE `eos`.`categoriapuesto` (
  `idcategoriapuesto` DECIMAL(19, 0) NULL,
  `sigla` VARCHAR(200) BINARY NULL,
  `activo` BIGINT(10) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `codctaprovaguime` VARCHAR(50) BINARY NULL,
  `codctaprevindemme` VARCHAR(50) BINARY NULL,
  `codctactbhaberme` VARCHAR(50) BINARY NULL,
  `codctactbdebeme` VARCHAR(50) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `codctagastoaguimn` VARCHAR(50) BINARY NULL,
  `codctaprovaguimn` VARCHAR(50) BINARY NULL,
  `codctagastoindemmn` VARCHAR(50) BINARY NULL,
  `codctaprevindemmn` VARCHAR(50) BINARY NULL,
  `codctactbhaber` VARCHAR(50) BINARY NULL,
  `codctactbdebe` VARCHAR(50) BINARY NULL,
  `tipogeneracion` VARCHAR(30) BINARY NULL,
  `fonpenctapatronal` VARCHAR(50) BINARY NULL,
  `posicion` BIGINT(10) NULL,
  `idsector` DECIMAL(19, 0) NULL,
  `segsocctapatronal` VARCHAR(50) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idlimite` DECIMAL(19, 0) NULL,
  `idtolerancia` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`causaretiro`;
CREATE TABLE `eos`.`causaretiro` (
  `idcausaretiro` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `permitepagos` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ciclo`;
CREATE TABLE `eos`.`ciclo` (
  `idciclo` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `fechafin` DATETIME NULL,
  `tipocambiome` DECIMAL(15, 2) NULL,
  `diaslaborales` BIGINT(10) NULL,
  `semanaslaborales` DECIMAL(15, 2) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `fechainicio` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipociclo` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `cicloraiz` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ciclogeneracionplanilla`;
CREATE TABLE `eos`.`ciclogeneracionplanilla` (
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `fechafinfiscal` DATETIME NULL,
  `tipocambiofinalufv` DECIMAL(16, 6) NULL,
  `fechaaperturagen` DATETIME NULL,
  `fechalimitegen` DATETIME NULL,
  `fechafingen` DATETIME NULL,
  `fechainiciogen` DATETIME NULL,
  `tipocambioinicialufv` DECIMAL(16, 6) NULL,
  `mes` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `fechaplanoficial` DATETIME NULL,
  `fechainiciofiscal` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idtasaafp` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idtasacns` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipocambio` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idtasaiva` DECIMAL(19, 0) NULL,
  `idregladescuento` DECIMAL(19, 0) NULL,
  `idtasaafpprohous` DECIMAL(19, 0) NULL,
  `idtasaafpprofrisk` DECIMAL(19, 0) NULL,
  `idtasasmn` DECIMAL(19, 0) NULL,
  `idtasaafpsolidario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ciudad`;
CREATE TABLE `eos`.`ciudad` (
  `idciudad` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddepartamento` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`clasifcuenta`;
CREATE TABLE `eos`.`clasifcuenta` (
  `idclasifcuenta` DECIMAL(19, 0) NULL,
  `codigocuenta` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idclasificador` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`clasificador`;
CREATE TABLE `eos`.`clasificador` (
  `idclasificador` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `tipo` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cliente`;
CREATE TABLE `eos`.`cliente` (
  `idcliente` DECIMAL(19, 0) NULL,
  `fechaprimeracompra` DATETIME NULL,
  `fechaultimacompra` DATETIME NULL,
  `nocliente` VARCHAR(100) BINARY NULL,
  `totalimporteadquirido` DECIMAL(13, 2) NULL,
  `totalarticulosadquiridos` BIGINT(10) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cobrofondorota`;
CREATE TABLE `eos`.`cobrofondorota` (
  `idcobro` DECIMAL(19, 0) NULL,
  `fechaaprobacion` DATETIME NULL,
  `cuentabanco` VARCHAR(20) BINARY NULL,
  `numerodeposito` VARCHAR(20) BINARY NULL,
  `nombrebeneficiario` VARCHAR(200) BINARY NULL,
  `tipobeneficiario` VARCHAR(255) BINARY NULL,
  `cuentaajuste` VARCHAR(20) BINARY NULL,
  `cuentacaja` VARCHAR(20) BINARY NULL,
  `codigo` BIGINT(10) NULL,
  `montocobro` DECIMAL(12, 2) NULL,
  `monedacobro` VARCHAR(255) BINARY NULL,
  `fechacobro` DATETIME NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `no_trans_dep` VARCHAR(10) BINARY NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `tipocambio` DECIMAL(12, 2) NULL,
  `observacion` VARCHAR(1000) BINARY NULL,
  `saldocuota` DECIMAL(13, 2) NULL,
  `tipocobro` VARCHAR(255) BINARY NULL,
  `montoorigen` DECIMAL(12, 2) NULL,
  `monedaorigen` VARCHAR(20) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `notrans` VARCHAR(10) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `anuladopor` DECIMAL(19, 0) NULL,
  `aprobadopor` DECIMAL(19, 0) NULL,
  `iddocumentocobro` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `idpagoordencompra` DECIMAL(19, 0) NULL,
  `idcuota` DECIMAL(19, 0) NULL,
  `entregadoa` DECIMAL(19, 0) NULL,
  `creadopor` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`comentariodesc`;
CREATE TABLE `eos`.`comentariodesc` (
  `idcomentariodesc` DECIMAL(19, 0) NULL,
  `motivo` VARCHAR(1000) BINARY NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `tipo` VARCHAR(30) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `creadopor` DECIMAL(19, 0) NULL,
  `idafvale` DECIMAL(19, 0) NULL,
  `id_com_encoc` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL,
  `actualizadopor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`compania`;
CREATE TABLE `eos`.`compania` (
  `idcompania` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(255) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`componentepanel`;
CREATE TABLE `eos`.`componentepanel` (
  `idcomponentepanel` DECIMAL(19, 0) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `nombrecomponente` VARCHAR(255) BINARY NULL,
  `funcion` VARCHAR(255) BINARY NULL,
  `modulo` VARCHAR(255) BINARY NULL,
  `titulo` VARCHAR(255) BINARY NULL,
  `unidad` VARCHAR(30) BINARY NULL,
  `verificacion` VARCHAR(30) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `xmlid` VARCHAR(50) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idresponsablenacional` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`composicionproducto`;
CREATE TABLE `eos`.`composicionproducto` (
  `idcomposicionproducto` DECIMAL(24, 0) NULL,
  `activo` BIGINT(10) NULL,
  `pesocontenedor` DECIMAL(24, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `cantidadproducir` DECIMAL(24, 0) NULL,
  `teoricoobtenido` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idproductoprocesado` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`configrupo`;
CREATE TABLE `eos`.`configrupo` (
  `idconfigrupo` DECIMAL(24, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `cod_gru` VARCHAR(255) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`confplanillafiscal`;
CREATE TABLE `eos`.`confplanillafiscal` (
  `idconfplanillafiscal` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `fechafin` DATETIME NULL,
  `tipocambiofinalufv` DECIMAL(16, 6) NULL,
  `tipocambioinicialufv` DECIMAL(16, 6) NULL,
  `mes` VARCHAR(20) BINARY NULL,
  `fechainicio` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idtasaafp` DECIMAL(19, 0) NULL,
  `idtasaafpprohous` DECIMAL(19, 0) NULL,
  `idtasaafpprofrisk` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idtasacns` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idtasaiva` DECIMAL(19, 0) NULL,
  `idtasasmn` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`contrato`;
CREATE TABLE `eos`.`contrato` (
  `idcontrato` DECIMAL(19, 0) NULL,
  `academico` BIGINT(10) NULL,
  `activogenplan` BIGINT(10) NULL,
  `activogenplanfis` BIGINT(10) NULL,
  `activofonpension` BIGINT(10) NULL,
  `controlasistencia` BIGINT(10) NULL,
  `respaldo` VARCHAR(200) BINARY NULL,
  `automodifcontrato` BIGINT(10) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `fechafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `codmodifcontrato` VARCHAR(6) BINARY NULL,
  `numerocontrato` BIGINT(10) NULL,
  `haberbasicolaboral` DECIMAL(16, 6) NULL,
  `montogloballaboral` DECIMAL(16, 6) NULL,
  `codregfonpension` VARCHAR(250) BINARY NULL,
  `codregsegsocial` VARCHAR(250) BINARY NULL,
  `especial` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmodalidadcontrato` DECIMAL(19, 0) NULL,
  `idestadocontrato` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL,
  `idinstfonpension` DECIMAL(19, 0) NULL,
  `idinstsegsocial` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`contratopuesto`;
CREATE TABLE `eos`.`contratopuesto` (
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `asignatura` VARCHAR(255) BINARY NULL,
  `edificio` VARCHAR(255) BINARY NULL,
  `ambiente` VARCHAR(255) BINARY NULL,
  `idcontrato` DECIMAL(19, 0) NULL,
  `plan_estudio` VARCHAR(255) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `tipo_grupo` VARCHAR(255) BINARY NULL,
  `idpuesto` DECIMAL(19, 0) NULL,
  `montolaboral` DECIMAL(16, 6) NULL,
  `periodo` BIGINT(10) NULL,
  `grupo_asignatura` VARCHAR(255) BINARY NULL,
  `sistema` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idbandahorariacontrato` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`costosindirectos`;
CREATE TABLE `eos`.`costosindirectos` (
  `idcostosindirectos` DECIMAL(19, 0) NULL,
  `montobs` DECIMAL(16, 2) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcostosindirectosconf` DECIMAL(19, 0) NULL,
  `idperiodocostoindirecto` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL,
  `idproductosimple` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`costosindirectosconf`;
CREATE TABLE `eos`.`costosindirectosconf` (
  `idcostosindirectosconf` DECIMAL(19, 0) NULL,
  `cuenta` VARCHAR(20) BINARY NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `cod_gru` VARCHAR(255) BINARY NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `predefinido` INT(1) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`credito`;
CREATE TABLE `eos`.`credito` (
  `idcredito` DECIMAL(19, 0) NULL,
  `importe` DECIMAL(13, 2) NULL,
  `fechacreacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `identidad` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`criterioevaluacion`;
CREATE TABLE `eos`.`criterioevaluacion` (
  `idcriterioevaluacion` DECIMAL(19, 0) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cronogramagp`;
CREATE TABLE `eos`.`cronogramagp` (
  `idcronogramagp` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `nombre` VARCHAR(50) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cuentabancaria`;
CREATE TABLE `eos`.`cuentabancaria` (
  `idcuentabancaria` DECIMAL(19, 0) NULL,
  `numerocuenta` VARCHAR(150) BINARY NULL,
  `codigocliente` VARCHAR(150) BINARY NULL,
  `cuentapordefecto` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `identidadbancaria` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`cuota`;
CREATE TABLE `eos`.`cuota` (
  `idcuota` DECIMAL(19, 0) NULL,
  `cantidad` DECIMAL(13, 2) NULL,
  `moneda` VARCHAR(20) BINARY NULL,
  `descripcion` VARCHAR(250) BINARY NULL,
  `porplanilla` BIGINT(10) NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `fechavencimiento` DATETIME NULL,
  `saldo` DECIMAL(13, 2) NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`departamento`;
CREATE TABLE `eos`.`departamento` (
  `iddepartamento` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpais` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`depositoproductoterminado`;
CREATE TABLE `eos`.`depositoproductoterminado` (
  `iddepositoproductoterminado` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(50) BINARY NULL,
  `descripcion` VARCHAR(1500) BINARY NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`derechoacceso`;
CREATE TABLE `eos`.`derechoacceso` (
  `idfuncionalidad` DECIMAL(19, 0) NULL,
  `idrol` DECIMAL(19, 0) NULL,
  `permiso` INT(3) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmodulo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentocliente`;
CREATE TABLE `eos`.`descuentocliente` (
  `idcliente` DECIMAL(19, 0) NULL,
  `iddescuentocliente` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentoempleado`;
CREATE TABLE `eos`.`descuentoempleado` (
  `iddescuentoempleado` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentofactura`;
CREATE TABLE `eos`.`descuentofactura` (
  `idfactura` DECIMAL(19, 0) NULL,
  `iddescuentocliente` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentofacturadetalle`;
CREATE TABLE `eos`.`descuentofacturadetalle` (
  `idfacturadetalle` DECIMAL(19, 0) NULL,
  `iddescuentoproducto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentoproducto`;
CREATE TABLE `eos`.`descuentoproducto` (
  `iddescuentoproducto` DECIMAL(19, 0) NULL,
  `idproducto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentoproductor`;
CREATE TABLE `eos`.`descuentoproductor` (
  `iddescuentoproductor` DECIMAL(24, 0) NULL,
  `montototalme` DECIMAL(16, 2) NULL,
  `montototalmn` DECIMAL(16, 2) NULL,
  `promedioleche` DECIMAL(16, 2) NULL,
  `fechafin` DATETIME NULL,
  `reserva` DECIMAL(8, 5) NULL,
  `reservaquicenta` DECIMAL(8, 5) NULL,
  `fechaini` DATETIME NULL,
  `estado` VARCHAR(10) BINARY NULL,
  `tc` DECIMAL(5, 2) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentoreserva`;
CREATE TABLE `eos`.`descuentoreserva` (
  `iddescuentoreserva` DECIMAL(24, 0) NULL,
  `monto` DECIMAL(16, 2) NULL,
  `fechafin` DATETIME NULL,
  `fechaini` DATETIME NULL,
  `iddescuentoproductor` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`descuentproductmateriaprima`;
CREATE TABLE `eos`.`descuentproductmateriaprima` (
  `iddescuentproductmateriaprima` DECIMAL(19, 0) NULL,
  `alcohol` DECIMAL(16, 2) NULL,
  `tachos` DECIMAL(16, 2) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `concentrados` DECIMAL(16, 2) NULL,
  `credito` DECIMAL(16, 2) NULL,
  `otrosdescuentos` DECIMAL(16, 2) NULL,
  `otrosingresos` DECIMAL(16, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `veterinario` DECIMAL(16, 2) NULL,
  `retencion` DECIMAL(16, 2) NULL,
  `yogurt` DECIMAL(16, 2) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idproductormateriaprima` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`detallebonoantiguedad`;
CREATE TABLE `eos`.`detallebonoantiguedad` (
  `iddetallebonoantiguedad` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `aniofin` BIGINT(10) NULL,
  `porcentaje` DECIMAL(13, 2) NULL,
  `anioinicio` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idbonoantiguedad` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`detalleretiro`;
CREATE TABLE `eos`.`detalleretiro` (
  `iddetalleretiro` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(16, 6) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(20) BINARY NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `motivoreversion` VARCHAR(1000) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `notrans` VARCHAR(10) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcausaretiro` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idretiro` DECIMAL(19, 0) NULL,
  `idarchivo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`detplanilladocentelaboral`;
CREATE TABLE `eos`.`detplanilladocentelaboral` (
  `iddetplanilladocentelaboral` DECIMAL(19, 0) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `minutosausenciabandas` BIGINT(10) NULL,
  `basicoganado` DECIMAL(13, 2) NULL,
  `sueldobasico` DECIMAL(13, 2) NULL,
  `categoria` VARCHAR(255) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `fechafincontrato` DATETIME NULL,
  `fechainiciocontrato` DATETIME NULL,
  `modalidadcontratacion` VARCHAR(255) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `diferencia` DECIMAL(13, 2) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `ingresofueraiva` DECIMAL(13, 2) NULL,
  `puesto` VARCHAR(255) BINARY NULL,
  `tipoempleado` VARCHAR(255) BINARY NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `numerominutosausenciabandas` BIGINT(10) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `atrasos` DECIMAL(13, 2) NULL,
  `minutosatraso` BIGINT(10) NULL,
  `descuentoporminutosatraso` DECIMAL(13, 2) NULL,
  `totaldescuento` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `unidad` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idbandahorariacontrato` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`detregcontable`;
CREATE TABLE `eos`.`detregcontable` (
  `iddetregcontable` DECIMAL(19, 0) NULL,
  `numctabanaria` VARCHAR(20) BINARY NULL,
  `numerocompania` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idregistrocontable` DECIMAL(19, 0) NULL,
  `idplanillaaguinaldo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idplanilladocentelaboral` DECIMAL(19, 0) NULL,
  `idplanillageneral` DECIMAL(19, 0) NULL,
  `idplanillaadministrativos` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`direccion`;
CREATE TABLE `eos`.`direccion` (
  `iddireccion` DECIMAL(19, 0) NULL,
  `numero` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcalle` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`distmesciclo`;
CREATE TABLE `eos`.`distmesciclo` (
  `iddistmesciclo` DECIMAL(19, 0) NULL,
  `diaslaborales` BIGINT(10) NULL,
  `mes` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`distpresdet`;
CREATE TABLE `eos`.`distpresdet` (
  `iddistpresdet` DECIMAL(19, 0) NULL,
  `mes` VARCHAR(10) BINARY NULL,
  `porcentajedist` DECIMAL(5, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `iddistpresupuesto` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`distpresupuesto`;
CREATE TABLE `eos`.`distpresupuesto` (
  `iddistpresupuesto` DECIMAL(19, 0) NULL,
  `tipodistribucion` VARCHAR(10) BINARY NULL,
  `porcentajedist` DECIMAL(5, 2) NULL,
  `tipo` VARCHAR(10) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`distribuciongasto`;
CREATE TABLE `eos`.`distribuciongasto` (
  `iddistribuciongasto` DECIMAL(19, 0) NULL,
  `cuenta` VARCHAR(20) BINARY NULL,
  `monto` DECIMAL(12, 2) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `porcentaje` DECIMAL(12, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`distribuciongastocobrofon`;
CREATE TABLE `eos`.`distribuciongastocobrofon` (
  `iddistribuciongastocobrofon` DECIMAL(19, 0) NULL,
  `cuenta` VARCHAR(20) BINARY NULL,
  `monto` DECIMAL(12, 2) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `porcentaje` DECIMAL(12, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcobro` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`docentesporcarrera`;
CREATE TABLE `eos`.`docentesporcarrera` (
  `iddocentesporcarrera` VARCHAR(255) BINARY NULL,
  `unidad_acad_adm` BIGINT(10) NULL,
  `carrera` VARCHAR(200) BINARY NULL,
  `sede` VARCHAR(200) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `cant_docentes` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL,
  `plan_estudio` VARCHAR(200) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`documentocobro`;
CREATE TABLE `eos`.`documentocobro` (
  `tipodocumentocobro` VARCHAR(25) BINARY NULL,
  `iddocumentocobro` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `identidad` VARCHAR(6) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`documentocompra`;
CREATE TABLE `eos`.`documentocompra` (
  `cuentaajuste` VARCHAR(20) BINARY NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `moneda` VARCHAR(255) BINARY NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `idordencompra` DECIMAL(19, 0) NULL,
  `estado` VARCHAR(25) BINARY NULL,
  `tipo` VARCHAR(25) BINARY NULL,
  `iddocumentocompra` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `identidad` VARCHAR(6) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`documentocontable`;
CREATE TABLE `eos`.`documentocontable` (
  `iddocumentocontable` DECIMAL(19, 0) NULL,
  `direccion` VARCHAR(50) BINARY NULL,
  `importe` DECIMAL(12, 2) NULL,
  `numeroautorizacion` VARCHAR(20) BINARY NULL,
  `codigocontrol` VARCHAR(20) BINARY NULL,
  `fecha` DATETIME NULL,
  `exento` DECIMAL(12, 2) NULL,
  `regcompro` BIGINT(10) NULL,
  `ice` DECIMAL(12, 2) NULL,
  `iva` DECIMAL(12, 2) NULL,
  `nombre` VARCHAR(50) BINARY NULL,
  `importeneto` DECIMAL(12, 2) NULL,
  `nit` VARCHAR(20) BINARY NULL,
  `numero` VARCHAR(20) BINARY NULL,
  `numerotransaccion` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`documentodescargo`;
CREATE TABLE `eos`.`documentodescargo` (
  `moneda` VARCHAR(255) BINARY NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `estado` VARCHAR(25) BINARY NULL,
  `tipo` VARCHAR(25) BINARY NULL,
  `iddocumentodescargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `identidad` VARCHAR(6) BINARY NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ejemplarencuesta`;
CREATE TABLE `eos`.`ejemplarencuesta` (
  `idejemplarencuesta` DECIMAL(19, 0) NULL,
  `fecharevision` DATETIME NULL,
  `numerorevision` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idperiodocad` DECIMAL(19, 0) NULL,
  `idcarrera` DECIMAL(19, 0) NULL,
  `idcomentario` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL,
  `idevaluador` DECIMAL(19, 0) NULL,
  `idfacultad` DECIMAL(19, 0) NULL,
  `idpersona` DECIMAL(19, 0) NULL,
  `idformularioencuesta` DECIMAL(19, 0) NULL,
  `idasignatura` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`emp`;
CREATE TABLE `eos`.`emp` (
  `identidad` DECIMAL(22, 0) NULL,
  `ci` VARCHAR(20) BINARY NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `apellidopaterno` VARCHAR(100) BINARY NULL,
  `apellidomaterno` VARCHAR(100) BINARY NULL,
  `nombres` VARCHAR(100) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`empleado`;
CREATE TABLE `eos`.`empleado` (
  `flagafp` BIGINT(10) NULL,
  `flagcontrol` BIGINT(10) NULL,
  `codigoempleado` VARCHAR(255) BINARY NULL,
  `fechaingreso` DATETIME NULL,
  `flagjubilado` BIGINT(10) NULL,
  `codigomarcacion` VARCHAR(100) BINARY NULL,
  `tipodepago` VARCHAR(20) BINARY NULL,
  `flagret` BIGINT(10) NULL,
  `fechasalida` DATETIME NULL,
  `salario` DECIMAL(13, 2) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`empleadosporcarr`;
CREATE TABLE `eos`.`empleadosporcarr` (
  `idempleadosporcarr` VARCHAR(255) BINARY NULL,
  `idcarrera` VARCHAR(10) BINARY NULL,
  `nombrecarrera` VARCHAR(100) BINARY NULL,
  `codigoempleado` BIGINT(10) NULL,
  `nombresemp` VARCHAR(40) BINARY NULL,
  `generoemp` VARCHAR(1) BINARY NULL,
  `identificacionemp` VARCHAR(30) BINARY NULL,
  `tipodocumentoemp` VARCHAR(30) BINARY NULL,
  `apellidopaternoemp` VARCHAR(25) BINARY NULL,
  `apellidomaternoemp` VARCHAR(25) BINARY NULL,
  `idfacultad` BIGINT(10) NULL,
  `nombrefac` VARCHAR(60) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL,
  `idsede` BIGINT(10) NULL,
  `nombresede` VARCHAR(60) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`entidad`;
CREATE TABLE `eos`.`entidad` (
  `identidad` DECIMAL(19, 0) NULL,
  `noidentificacion` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `iddireccion` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipodocumento` DECIMAL(19, 0) NULL,
  `idexttipodocumento` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`entidadbancaria`;
CREATE TABLE `eos`.`entidadbancaria` (
  `identidadbancaria` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`entidadbensocial`;
CREATE TABLE `eos`.`entidadbensocial` (
  `no_cia` VARCHAR(2) BINARY NULL,
  `cod_prov` VARCHAR(6) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `identidadbensocial` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`entradaordenproduccion`;
CREATE TABLE `eos`.`entradaordenproduccion` (
  `identradaordenproduccion` DECIMAL(19, 0) NULL,
  `cantidadentregada` DECIMAL(24, 0) NULL,
  `observacionentrega` VARCHAR(1500) BINARY NULL,
  `observacionrecepcion` VARCHAR(1500) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idinventarioproductoterminado` DECIMAL(19, 0) NULL,
  `idregistrotransferenciaproduct` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadoarticulo`;
CREATE TABLE `eos`.`estadoarticulo` (
  `idestadoarticulo` DECIMAL(24, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `cod_art` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadobandahoraria`;
CREATE TABLE `eos`.`estadobandahoraria` (
  `idestadobandahoraria` DECIMAL(19, 0) NULL,
  `despuesfin` BIGINT(10) NULL,
  `despuesinicio` BIGINT(10) NULL,
  `antesfin` BIGINT(10) NULL,
  `antesinicio` BIGINT(10) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `cod_cc` VARCHAR(6) BINARY NULL,
  `fecha` DATETIME NULL,
  `duracion` BIGINT(10) NULL,
  `horafin` DATETIME NULL,
  `horainicio` DATETIME NULL,
  `mindescuento` BIGINT(10) NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idbandahoraria` DECIMAL(19, 0) NULL,
  `idbandahorariac` DECIMAL(19, 0) NULL,
  `idunidadorganizacional` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadocivil`;
CREATE TABLE `eos`.`estadocivil` (
  `idestadocivil` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(10) BINARY NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadocontrato`;
CREATE TABLE `eos`.`estadocontrato` (
  `idestadocontrato` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(20) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadomarcado`;
CREATE TABLE `eos`.`estadomarcado` (
  `idestadomarcado` DECIMAL(19, 0) NULL,
  `identificado` BIGINT(10) NULL,
  `marfecha` DATETIME NULL,
  `marhora` DATETIME NULL,
  `codigomarcacion` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idrhmarcado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadomarestadobh`;
CREATE TABLE `eos`.`estadomarestadobh` (
  `idestadomarestadobh` DECIMAL(19, 0) NULL,
  `mindescuento` BIGINT(10) NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idestadobandahoraria` DECIMAL(19, 0) NULL,
  `idestadomarcado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadoproducto`;
CREATE TABLE `eos`.`estadoproducto` (
  `idestadoproducto` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estadorecepcion`;
CREATE TABLE `eos`.`estadorecepcion` (
  `idestadorecepcion` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `tipo` VARCHAR(30) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estudiante`;
CREATE TABLE `eos`.`estudiante` (
  `codigoestudiante` VARCHAR(20) BINARY NULL,
  `idestudiante` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`estudiantesporasig`;
CREATE TABLE `eos`.`estudiantesporasig` (
  `idestudientesporasig` VARCHAR(255) BINARY NULL,
  `idcarrera` VARCHAR(10) BINARY NULL,
  `nombrecarrera` VARCHAR(100) BINARY NULL,
  `codigoempleado` BIGINT(10) NULL,
  `nombresemp` VARCHAR(40) BINARY NULL,
  `generoemp` VARCHAR(1) BINARY NULL,
  `identificacionemp` VARCHAR(30) BINARY NULL,
  `tipodocumentoemp` VARCHAR(30) BINARY NULL,
  `apellidopaternoemp` VARCHAR(25) BINARY NULL,
  `apellidomaternoemp` VARCHAR(25) BINARY NULL,
  `idfacultad` BIGINT(10) NULL,
  `nombrefac` VARCHAR(60) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL,
  `idsede` BIGINT(10) NULL,
  `nombresede` VARCHAR(60) BINARY NULL,
  `codigoestudiante` BIGINT(10) NULL,
  `nombresest` VARCHAR(50) BINARY NULL,
  `generoest` VARCHAR(1) BINARY NULL,
  `identificacionest` VARCHAR(20) BINARY NULL,
  `tipoidentificacionest` VARCHAR(5) BINARY NULL,
  `apellidopaternoest` VARCHAR(30) BINARY NULL,
  `apellidomaternoest` VARCHAR(30) BINARY NULL,
  `idasignatura` VARCHAR(20) BINARY NULL,
  `nombreasig` VARCHAR(300) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`evaluaciondocente`;
CREATE TABLE `eos`.`evaluaciondocente` (
  `idevaluaciondocente` VARCHAR(255) BINARY NULL,
  `unidadacadadm` BIGINT(10) NULL,
  `sede` VARCHAR(255) BINARY NULL,
  `codempleado` DECIMAL(19, 0) NULL,
  `nombres` VARCHAR(255) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `documento` VARCHAR(255) BINARY NULL,
  `apellido_paterno` VARCHAR(255) BINARY NULL,
  `apellido_materno` VARCHAR(255) BINARY NULL,
  `cant_carreras` BIGINT(10) NULL,
  `cant_estudiantes` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`evaluacionprog`;
CREATE TABLE `eos`.`evaluacionprog` (
  `idevaluacionprog` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`experiencia`;
CREATE TABLE `eos`.`experiencia` (
  `idexperiencia` DECIMAL(19, 0) NULL,
  `duracion` VARCHAR(255) BINARY NULL,
  `fechafin` DATETIME NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `fechainicio` DATETIME NULL,
  `lugar` VARCHAR(250) BINARY NULL,
  `cargo` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpostulante` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`exttipodocumento`;
CREATE TABLE `eos`.`exttipodocumento` (
  `idexttipodocumento` DECIMAL(19, 0) NULL,
  `extension` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipodocumento` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`factura`;
CREATE TABLE `eos`.`factura` (
  `idfactura` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `nombres` VARCHAR(200) BINARY NULL,
  `apellidopaterno` VARCHAR(200) BINARY NULL,
  `apellidomaterno` VARCHAR(200) BINARY NULL,
  `numerofactura` VARCHAR(50) BINARY NULL,
  `razonsocial` VARCHAR(200) BINARY NULL,
  `formapago` VARCHAR(50) BINARY NULL,
  `estado` VARCHAR(50) BINARY NULL,
  `nodoctributario` VARCHAR(100) BINARY NULL,
  `tipodoctibutario` VARCHAR(50) BINARY NULL,
  `importetotal` DECIMAL(13, 2) NULL,
  `totaldescuento` DECIMAL(13, 2) NULL,
  `idcaja` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcliente` DECIMAL(19, 0) NULL,
  `idreglatributaria` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`facturadetalle`;
CREATE TABLE `eos`.`facturadetalle` (
  `idfacturadetalle` DECIMAL(19, 0) NULL,
  `descuento` DECIMAL(13, 2) NULL,
  `porcentajedescuento` DECIMAL(13, 2) NULL,
  `preciounitario` DECIMAL(13, 2) NULL,
  `cantidad` BIGINT(10) NULL,
  `importe` DECIMAL(13, 2) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idproducto` DECIMAL(19, 0) NULL,
  `idfactura` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`facultad`;
CREATE TABLE `eos`.`facultad` (
  `idfacultad` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `idreferencia` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idsede` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`fechaespecial`;
CREATE TABLE `eos`.`fechaespecial` (
  `idfechaespecial` DECIMAL(19, 0) NULL,
  `allday` BIGINT(10) NULL,
  `gocedehaber` VARCHAR(255) BINARY NULL,
  `dia` BIGINT(10) NULL,
  `fechafin` DATETIME NULL,
  `horafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `mes` BIGINT(10) NULL,
  `moveralunes` BIGINT(10) NULL,
  `ocurrencia` BIGINT(10) NULL,
  `tiporol` VARCHAR(15) BINARY NULL,
  `destino` VARCHAR(20) BINARY NULL,
  `horainicio` DATETIME NULL,
  `titulo` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcontrato` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idunidadorganizacional` DECIMAL(19, 0) NULL,
  `idvacacion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`filtrocomppnl`;
CREATE TABLE `eos`.`filtrocomppnl` (
  `idfiltrocomppnl` DECIMAL(19, 0) NULL,
  `color` BIGINT(10) NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `indice` BIGINT(10) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcomponentepanel` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`fondorotatorio`;
CREATE TABLE `eos`.`fondorotatorio` (
  `idfondorotatorio` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(12, 2) NULL,
  `cuentactb` VARCHAR(20) BINARY NULL,
  `codigo` BIGINT(10) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `cod_cc` VARCHAR(6) BINARY NULL,
  `fecha` DATETIME NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `porplanilla` BIGINT(10) NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `fechavencimiento` DATETIME NULL,
  `monedapago` VARCHAR(255) BINARY NULL,
  `residuoporpagar` DECIMAL(12, 2) NULL,
  `cuotas` BIGINT(10) NULL,
  `cod_prov` VARCHAR(6) BINARY NULL,
  `residuoporcobrar` DECIMAL(12, 2) NULL,
  `fechainicio` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `anuladopor` DECIMAL(19, 0) NULL,
  `aprobadopor` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipodocfondorota` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `creadopor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formacionacademica`;
CREATE TABLE `eos`.`formacionacademica` (
  `idformacionacademica` DECIMAL(19, 0) NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `universidad` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formacionacademp`;
CREATE TABLE `eos`.`formacionacademp` (
  `idformacionacademp` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formacionacadpost`;
CREATE TABLE `eos`.`formacionacadpost` (
  `idformacionacadpost` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpostulante` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formevalfinal`;
CREATE TABLE `eos`.`formevalfinal` (
  `idformevalfinal` DECIMAL(19, 0) NULL,
  `fechaaprob` DATETIME NULL,
  `codigo` VARCHAR(50) BINARY NULL,
  `revision` BIGINT(10) NULL,
  `subtitulo` VARCHAR(250) BINARY NULL,
  `titulo` VARCHAR(250) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL,
  `idmetodologia` DECIMAL(19, 0) NULL,
  `idobjetivo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formevaluacionprog`;
CREATE TABLE `eos`.`formevaluacionprog` (
  `idformevaluacionprog` DECIMAL(19, 0) NULL,
  `fechafin` DATETIME NULL,
  `muestra` BIGINT(10) NULL,
  `fechainicio` DATETIME NULL,
  `tipo` VARCHAR(30) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idformularioencuesta` DECIMAL(19, 0) NULL,
  `idevaluacionprog` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formfactura`;
CREATE TABLE `eos`.`formfactura` (
  `idformfactura` DECIMAL(19, 0) NULL,
  `creditofiscal` BIGINT(10) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `fechapresentacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`formularioencuesta`;
CREATE TABLE `eos`.`formularioencuesta` (
  `idformularioencuesta` DECIMAL(19, 0) NULL,
  `restricperiodaca` VARCHAR(30) BINARY NULL,
  `fechaaprobacion` DATETIME NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `restricciclo` VARCHAR(30) BINARY NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `porcentajeequiva` BIGINT(10) NULL,
  `restricagrupa` VARCHAR(30) BINARY NULL,
  `restricpersona` VARCHAR(30) BINARY NULL,
  `tipoagrupacion` VARCHAR(30) BINARY NULL,
  `revision` BIGINT(10) NULL,
  `porcentajemuestra` BIGINT(10) NULL,
  `subtitulo` VARCHAR(250) BINARY NULL,
  `titulo` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`funcionalidad`;
CREATE TABLE `eos`.`funcionalidad` (
  `idfuncionalidad` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(40) BINARY NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `idmodulo` DECIMAL(19, 0) NULL,
  `permiso` INT(3) NULL,
  `nombrerecurso` VARCHAR(100) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gensecuencia`;
CREATE TABLE `eos`.`gensecuencia` (
  `idgensecuencia` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `valor` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gestion`;
CREATE TABLE `eos`.`gestion` (
  `idgestion` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `anio` BIGINT(10) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gestionimpuesto`;
CREATE TABLE `eos`.`gestionimpuesto` (
  `idgestionimpuesto` DECIMAL(24, 0) NULL,
  `fechafin` DATETIME NULL,
  `fechainicio` DATETIME NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gestionplanilla`;
CREATE TABLE `eos`.`gestionplanilla` (
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `fechafin` DATETIME NULL,
  `fechaaperturagen` DATETIME NULL,
  `fechalimitegen` DATETIME NULL,
  `nombregestion` VARCHAR(200) BINARY NULL,
  `tipo` VARCHAR(20) BINARY NULL,
  `fechainicio` DATETIME NULL,
  `mes` VARCHAR(20) BINARY NULL,
  `fechaplanoficial` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipocambio` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gestionplanillaadm`;
CREATE TABLE `eos`.`gestionplanillaadm` (
  `idgestionplanillaadm` DECIMAL(19, 0) NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `idconfplanillafiscal` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`gestionvacacion`;
CREATE TABLE `eos`.`gestionvacacion` (
  `idgestionvacacion` DECIMAL(19, 0) NULL,
  `diaslibres` BIGINT(10) NULL,
  `diasusados` BIGINT(10) NULL,
  `gestion` BIGINT(10) NULL,
  `diasvacacion` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idplanvacacion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`grupoasignatura`;
CREATE TABLE `eos`.`grupoasignatura` (
  `idgrupoasignatura` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idunidadorganizacional` DECIMAL(19, 0) NULL,
  `idasignatura` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`historialarticuloprov`;
CREATE TABLE `eos`.`historialarticuloprov` (
  `idhistorialarticuloprov` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `costo_uni` DECIMAL(16, 6) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `id_articulo_por_proveedor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`historialcaja`;
CREATE TABLE `eos`.`historialcaja` (
  `idcaja` DECIMAL(19, 0) NULL,
  `fechaestado` DATETIME NULL,
  `fechacreacion` DATETIME NULL,
  `descripcion` VARCHAR(150) BINARY NULL,
  `autorizacionrequerida` BIGINT(10) NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipocaja` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`historialestadosolmant`;
CREATE TABLE `eos`.`historialestadosolmant` (
  `idhisestsolmant` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddescripcion` DECIMAL(19, 0) NULL,
  `idsolmant` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`historialsueldos`;
CREATE TABLE `eos`.`historialsueldos` (
  `idhistorialsueldos` DECIMAL(19, 0) NULL,
  `fechafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `estado` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`horadisponible`;
CREATE TABLE `eos`.`horadisponible` (
  `idhoradisponible` DECIMAL(19, 0) NULL,
  `dia` VARCHAR(255) BINARY NULL,
  `fechafin` DATETIME NULL,
  `horafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `horainicio` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpostulante` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`horasextra`;
CREATE TABLE `eos`.`horasextra` (
  `idhorasextra` DECIMAL(19, 0) NULL,
  `horasextra` DECIMAL(13, 2) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `totalpagado` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`impuestoproductor`;
CREATE TABLE `eos`.`impuestoproductor` (
  `idimpuestoproductor` DECIMAL(24, 0) NULL,
  `numeroformulario` VARCHAR(255) BINARY NULL,
  `idgestionimpuesto` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ingredienteproduccion`;
CREATE TABLE `eos`.`ingredienteproduccion` (
  `idingredienteproduccion` DECIMAL(24, 0) NULL,
  `ingredienteverificable` VARCHAR(20) BINARY NULL,
  `formulamatematica` VARCHAR(500) BINARY NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idcomposicionproducto` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`institucion`;
CREATE TABLE `eos`.`institucion` (
  `aniversario` DATETIME NULL,
  `razonsocial` VARCHAR(200) BINARY NULL,
  `idinstitucion` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`insumoproduccion`;
CREATE TABLE `eos`.`insumoproduccion` (
  `idinsumoproduccion` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`intervalocomppnl`;
CREATE TABLE `eos`.`intervalocomppnl` (
  `valormax` BIGINT(10) NULL,
  `valormin` BIGINT(10) NULL,
  `idintervalocomppnl` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`inventarioproductoterminado`;
CREATE TABLE `eos`.`inventarioproductoterminado` (
  `idinventarioproductoterminado` DECIMAL(19, 0) NULL,
  `cantidad` DECIMAL(24, 0) NULL,
  `fecha` DATETIME NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idambientedeposito` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`jefesporcarr`;
CREATE TABLE `eos`.`jefesporcarr` (
  `idjefesporcarr` VARCHAR(255) BINARY NULL,
  `idcarrera` VARCHAR(10) BINARY NULL,
  `nombrecarrera` VARCHAR(100) BINARY NULL,
  `codigoempleado` BIGINT(10) NULL,
  `nombresemp` VARCHAR(40) BINARY NULL,
  `generoemp` VARCHAR(1) BINARY NULL,
  `identificacionemp` VARCHAR(30) BINARY NULL,
  `tipodocumentoemp` VARCHAR(30) BINARY NULL,
  `apellidopaternoemp` VARCHAR(25) BINARY NULL,
  `apellidomaternoemp` VARCHAR(25) BINARY NULL,
  `idfacultad` BIGINT(10) NULL,
  `nombrefac` VARCHAR(60) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL,
  `idsede` BIGINT(10) NULL,
  `nombresede` VARCHAR(60) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`libroventas`;
CREATE TABLE `eos`.`libroventas` (
  `idlibroventa` VARCHAR(255) BINARY NULL,
  `total_factura` DECIMAL(16, 2) NULL,
  `nro_de_autorizacion` VARCHAR(6) BINARY NULL,
  `codigo_de_control` VARCHAR(20) BINARY NULL,
  `fecha` DATETIME NULL,
  `importes_exentos` DECIMAL(16, 2) NULL,
  `total_ice` DECIMAL(16, 2) NULL,
  `nro_de_factura` VARCHAR(20) BINARY NULL,
  `importe_neto` DECIMAL(16, 2) NULL,
  `nro_nit_cliente` VARCHAR(20) BINARY NULL,
  `nombre_razon_social_cliente` VARCHAR(100) BINARY NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `debito_fiscal` DECIMAL(16, 2) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`limite`;
CREATE TABLE `eos`.`limite` (
  `idlimite` DECIMAL(19, 0) NULL,
  `despuesfin` BIGINT(10) NULL,
  `despuesinicio` BIGINT(10) NULL,
  `antesfin` BIGINT(10) NULL,
  `antesinicio` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`logzonaproductiva`;
CREATE TABLE `eos`.`logzonaproductiva` (
  `idlogzonaproductiva` DECIMAL(24, 0) NULL,
  `fecha` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`mantenimiento`;
CREATE TABLE `eos`.`mantenimiento` (
  `idmant` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(16, 6) NULL,
  `fechaentrega` DATETIME NULL,
  `fechaestimadarecepcion` DATETIME NULL,
  `fecharecepcion` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `iddescripentrega` DECIMAL(19, 0) NULL,
  `iddescriprecepcion` DECIMAL(19, 0) NULL,
  `idestadorecepcion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`marca`;
CREATE TABLE `eos`.`marca` (
  `idmarca` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`materialproduccion`;
CREATE TABLE `eos`.`materialproduccion` (
  `idmaterialproduccion` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`metaproductoproduccion`;
CREATE TABLE `eos`.`metaproductoproduccion` (
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `codigo` VARCHAR(50) BINARY NULL,
  `esacopiable` BIGINT(10) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `descripcion` VARCHAR(500) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `cod_art` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idunidadmedidaproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`modalidadcontrato`;
CREATE TABLE `eos`.`modalidadcontrato` (
  `idmodalidadcontrato` DECIMAL(19, 0) NULL,
  `duraciondias` BIGINT(10) NULL,
  `definition` VARCHAR(150) BINARY NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`modelo`;
CREATE TABLE `eos`.`modelo` (
  `idmodelo` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`modulo`;
CREATE TABLE `eos`.`modulo` (
  `idmodulo` DECIMAL(19, 0) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `nombrerecurso` VARCHAR(150) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`modulocompania`;
CREATE TABLE `eos`.`modulocompania` (
  `idcompania` DECIMAL(19, 0) NULL,
  `idmodulo` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`moneda`;
CREATE TABLE `eos`.`moneda` (
  `idmoneda` DECIMAL(19, 0) NULL,
  `codigomoneda` VARCHAR(200) BINARY NULL,
  `descripcion` VARCHAR(50) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `simbolo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`motivoocestadoaf`;
CREATE TABLE `eos`.`motivoocestadoaf` (
  `idmotivoocestadoaf` DECIMAL(19, 0) NULL,
  `estadoaf` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmotivoordenc` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`motivoordencomp`;
CREATE TABLE `eos`.`motivoordencomp` (
  `idmotivoordenc` DECIMAL(19, 0) NULL,
  `codigo` BIGINT(10) NULL,
  `descripcion` VARCHAR(250) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `requiereactivos` BIGINT(10) NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`movfondorota`;
CREATE TABLE `eos`.`movfondorota` (
  `idmovimiento` DECIMAL(19, 0) NULL,
  `pagodocbannodoc` VARCHAR(255) BINARY NULL,
  `pagodocbantipodoc` VARCHAR(255) BINARY NULL,
  `cobroajtctactbcuenta` VARCHAR(255) BINARY NULL,
  `cobroajtctactbnombre` VARCHAR(255) BINARY NULL,
  `cobroctacajanombre` VARCHAR(255) BINARY NULL,
  `cobroctacajacuenta` VARCHAR(255) BINARY NULL,
  `pagocajanombre` VARCHAR(255) BINARY NULL,
  `pagocajacuenta` VARCHAR(255) BINARY NULL,
  `pagocajanodoc` VARCHAR(255) BINARY NULL,
  `codigo` BIGINT(10) NULL,
  `montocobro` DECIMAL(12, 2) NULL,
  `monedacobro` VARCHAR(255) BINARY NULL,
  `fecha` DATETIME NULL,
  `cobroajtdepnodoc` VARCHAR(255) BINARY NULL,
  `cobroajtdeptipodoc` VARCHAR(255) BINARY NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `cobrodocbannodoc` VARCHAR(255) BINARY NULL,
  `cobrodocbantipodoc` VARCHAR(255) BINARY NULL,
  `cobrodocnodoc` VARCHAR(255) BINARY NULL,
  `cobrodoctipodoc` VARCHAR(255) BINARY NULL,
  `tipocambio` DECIMAL(12, 2) NULL,
  `clasemov` VARCHAR(255) BINARY NULL,
  `tipomov` VARCHAR(255) BINARY NULL,
  `observacion` VARCHAR(255) BINARY NULL,
  `montopago` DECIMAL(12, 2) NULL,
  `monedapago` VARCHAR(255) BINARY NULL,
  `cobroplanombreges` VARCHAR(255) BINARY NULL,
  `cobroocnoorden` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `notrans` VARCHAR(255) BINARY NULL,
  `fechacompro` DATETIME NULL,
  `nocompro` VARCHAR(255) BINARY NULL,
  `tipocompro` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`movimientosalariogab`;
CREATE TABLE `eos`.`movimientosalariogab` (
  `idmovimientosalariogab` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `valor` DECIMAL(16, 2) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL,
  `idtipomovimientogab` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`movimientosalarioproductor`;
CREATE TABLE `eos`.`movimientosalarioproductor` (
  `idmovimientosalarioproductor` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `valor` DECIMAL(16, 2) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(19, 0) NULL,
  `idtipomovimientoproductor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`movimientosueldo`;
CREATE TABLE `eos`.`movimientosueldo` (
  `idmovimientosueldo` DECIMAL(19, 0) NULL,
  `cantidad` DECIMAL(13, 2) NULL,
  `fechacreacion` DATETIME NULL,
  `fecha` DATETIME NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `idtipomovimientosueldo` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`nivelorganizacional`;
CREATE TABLE `eos`.`nivelorganizacional` (
  `idnivelorganizacional` DECIMAL(19, 0) NULL,
  `sigla` VARCHAR(200) BINARY NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `nivelorganizacionalraiz` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`notarechazomateriaprima`;
CREATE TABLE `eos`.`notarechazomateriaprima` (
  `idnotarechazomateriaprima` DECIMAL(19, 0) NULL,
  `acida` VARCHAR(1000) BINARY NULL,
  `calostro` VARCHAR(1000) BINARY NULL,
  `fecha` DATETIME NULL,
  `sucia` VARCHAR(1000) BINARY NULL,
  `tachomalestado` VARCHAR(1000) BINARY NULL,
  `observaciones` VARCHAR(1000) BINARY NULL,
  `otros` VARCHAR(1000) BINARY NULL,
  `cantidadrechazada` BIGINT(15) NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `aguadabajosng` VARCHAR(1000) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idproductormateriaprima` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ordencomactivo`;
CREATE TABLE `eos`.`ordencomactivo` (
  `idordencomactivo` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idactivo` DECIMAL(19, 0) NULL,
  `idordencompra` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ordeninsumo`;
CREATE TABLE `eos`.`ordeninsumo` (
  `idordeninsumo` DECIMAL(24, 0) NULL,
  `cantidad` DECIMAL(24, 0) NULL,
  `cantidadstock` DECIMAL(24, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `costototal` DECIMAL(16, 6) NULL,
  `costounitario` DECIMAL(16, 6) NULL,
  `formulamatematica` VARCHAR(500) BINARY NULL,
  `cod_art` VARCHAR(255) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `idproductobase` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ordenmaterial`;
CREATE TABLE `eos`.`ordenmaterial` (
  `idordenmaterial` DECIMAL(24, 0) NULL,
  `cantidadpesosolicitada` DECIMAL(16, 2) NULL,
  `cantidadunidadsolicitada` DECIMAL(16, 2) NULL,
  `cantidadpesoretornada` DECIMAL(16, 2) NULL,
  `cantidadpesousada` DECIMAL(16, 2) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `costototal` DECIMAL(16, 6) NULL,
  `costounitario` DECIMAL(16, 6) NULL,
  `cod_art` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL,
  `idproductosimple` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`ordenproduccion`;
CREATE TABLE `eos`.`ordenproduccion` (
  `idordenproduccion` DECIMAL(24, 0) NULL,
  `codigo` VARCHAR(50) BINARY NULL,
  `pesocontenedor` DECIMAL(24, 0) NULL,
  `estadoorden` VARCHAR(20) BINARY NULL,
  `cantidadesperada` DECIMAL(24, 0) NULL,
  `porcentajegrasa` DECIMAL(16, 2) NULL,
  `no_trans` VARCHAR(255) BINARY NULL,
  `no_vale` VARCHAR(255) BINARY NULL,
  `cantidadproducida` DECIMAL(24, 0) NULL,
  `cantidadproducidaresponsable` DECIMAL(24, 0) NULL,
  `costinsumoprincipal` DECIMAL(16, 2) NULL,
  `costotoalproduccion` DECIMAL(16, 2) NULL,
  `totalcostoindirecto` DECIMAL(16, 2) NULL,
  `preciototalinsumo` DECIMAL(16, 2) NULL,
  `preciototalmanoobra` DECIMAL(16, 2) NULL,
  `preciototalmaterial` DECIMAL(16, 2) NULL,
  `costounitario` DECIMAL(16, 6) NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idcomposicionproducto` DECIMAL(24, 0) NULL,
  `productopadre` DECIMAL(24, 0) NULL,
  `idplanificacionproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`pagofondorota`;
CREATE TABLE `eos`.`pagofondorota` (
  `idpago` DECIMAL(19, 0) NULL,
  `fechaaprobacion` DATETIME NULL,
  `cuentabanco` VARCHAR(20) BINARY NULL,
  `nombrebeneficiario` VARCHAR(200) BINARY NULL,
  `tipobeneficiario` VARCHAR(255) BINARY NULL,
  `cuentaajuste` VARCHAR(20) BINARY NULL,
  `cuentacaja` VARCHAR(20) BINARY NULL,
  `codigo` BIGINT(10) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `tipocambio` DECIMAL(12, 2) NULL,
  `montopago` DECIMAL(12, 2) NULL,
  `monedapago` VARCHAR(255) BINARY NULL,
  `fechapago` DATETIME NULL,
  `motivoreversion` VARCHAR(1000) BINARY NULL,
  `tipopago` VARCHAR(255) BINARY NULL,
  `montoorigen` DECIMAL(12, 2) NULL,
  `monedaorigen` VARCHAR(20) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `notrans` VARCHAR(10) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `anuladopor` DECIMAL(19, 0) NULL,
  `aprobadopor` DECIMAL(19, 0) NULL,
  `idsededestinocheque` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `creadopor` DECIMAL(19, 0) NULL,
  `idfondorotatorio` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`pais`;
CREATE TABLE `eos`.`pais` (
  `idpais` DECIMAL(19, 0) NULL,
  `codigoarea` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `prefijo` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`parteactfijo`;
CREATE TABLE `eos`.`parteactfijo` (
  `idparteactfijo` DECIMAL(19, 0) NULL,
  `descripcion` VARCHAR(250) BINARY NULL,
  `numero` DECIMAL(19, 0) NULL,
  `serie` VARCHAR(250) BINARY NULL,
  `preciouni` DECIMAL(16, 6) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idactivofijo` DECIMAL(19, 0) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `unidadmedida` VARCHAR(6) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`parteafoc`;
CREATE TABLE `eos`.`parteafoc` (
  `idparteafoc` DECIMAL(19, 0) NULL,
  `descripcion` VARCHAR(250) BINARY NULL,
  `serie` VARCHAR(250) BINARY NULL,
  `preciouni` DECIMAL(16, 6) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idactivofijo` DECIMAL(19, 0) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `unidadmedida` VARCHAR(6) BINARY NULL,
  `id_com_encoc` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`partedetoc`;
CREATE TABLE `eos`.`partedetoc` (
  `idpartedetoc` DECIMAL(19, 0) NULL,
  `descripcion` VARCHAR(250) BINARY NULL,
  `numero` DECIMAL(19, 0) NULL,
  `total` DECIMAL(16, 6) NULL,
  `preciouni` DECIMAL(16, 6) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddetalleafoc` DECIMAL(19, 0) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `unidadmedida` VARCHAR(6) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`periodoacademico`;
CREATE TABLE `eos`.`periodoacademico` (
  `idperiodocad` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `idreferencia` VARCHAR(100) BINARY NULL,
  `indice` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`periodocostoindirecto`;
CREATE TABLE `eos`.`periodocostoindirecto` (
  `idperiodocostoindirecto` DECIMAL(24, 0) NULL,
  `mes` INT(2) NULL,
  `dia` INT(2) NULL,
  `idgestion` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`persona`;
CREATE TABLE `eos`.`persona` (
  `fechanacimiento` DATETIME NULL,
  `nombres` VARCHAR(255) BINARY NULL,
  `genero` VARCHAR(255) BINARY NULL,
  `domicilio` VARCHAR(500) BINARY NULL,
  `apellidopaterno` VARCHAR(200) BINARY NULL,
  `apellidomaterno` VARCHAR(200) BINARY NULL,
  `profesion` VARCHAR(100) BINARY NULL,
  `idpersona` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpais` DECIMAL(19, 0) NULL,
  `idestadocivil` DECIMAL(19, 0) NULL,
  `idsaludo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planificacionproduccion`;
CREATE TABLE `eos`.`planificacionproduccion` (
  `idplanificacionproduccion` DECIMAL(24, 0) NULL,
  `fecha` DATETIME NULL,
  `observaciones` VARCHAR(1000) BINARY NULL,
  `estado` VARCHAR(50) BINARY NULL,
  `totallecheproducida` INT(9) NULL,
  `totallechequeso` INT(9) NULL,
  `totallechereproceso` INT(9) NULL,
  `totallecheuht` INT(9) NULL,
  `totallecheyogurt` INT(9) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillaacopio`;
CREATE TABLE `eos`.`planillaacopio` (
  `idplanillaacopio` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `porcentajegrasa` DECIMAL(16, 2) NULL,
  `estado` VARCHAR(3) BINARY NULL,
  `totalpesado` DECIMAL(16, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillaadministrativos`;
CREATE TABLE `eos`.`planillaadministrativos` (
  `idplanillaadministrativos` DECIMAL(19, 0) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `activogenplanfis` BIGINT(10) NULL,
  `anticipo` DECIMAL(13, 2) NULL,
  `afps` DECIMAL(13, 2) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `minutosausenciabandas` BIGINT(10) NULL,
  `basicoganado` DECIMAL(13, 2) NULL,
  `categoria` VARCHAR(255) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `fechafincontrato` DATETIME NULL,
  `fechainiciocontrato` DATETIME NULL,
  `modalidadcontratacion` VARCHAR(255) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `diferencia` DECIMAL(13, 2) NULL,
  `descuentossinretencion` DECIMAL(13, 2) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `registrocontable` BIGINT(10) NULL,
  `pagoactivo` BIGINT(10) NULL,
  `ingresofueraiva` DECIMAL(13, 2) NULL,
  `seguro` DECIMAL(13, 2) NULL,
  `saldoiva` DECIMAL(13, 2) NULL,
  `retencioniva` DECIMAL(13, 2) NULL,
  `puesto` VARCHAR(255) BINARY NULL,
  `tipoempleado` VARCHAR(255) BINARY NULL,
  `totallaboral` DECIMAL(13, 2) NULL,
  `saldoivaanterior` DECIMAL(13, 2) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `prestamo` DECIMAL(13, 2) NULL,
  `numerominutosausenciabandas` BIGINT(10) NULL,
  `otrosdescuentos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `totalpatronal` DECIMAL(13, 2) NULL,
  `provivienda` DECIMAL(13, 2) NULL,
  `rciva` DECIMAL(13, 2) NULL,
  `sueldo` DECIMAL(13, 2) NULL,
  `atrasos` DECIMAL(13, 2) NULL,
  `minutosatraso` BIGINT(10) NULL,
  `descuentoporminutosatraso` DECIMAL(13, 2) NULL,
  `totaldescuento` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `unidad` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `win` DECIMAL(13, 2) NULL,
  `diastrabajados` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillaaguinaldo`;
CREATE TABLE `eos`.`planillaaguinaldo` (
  `idplanillaaguinaldo` DECIMAL(19, 0) NULL,
  `activogenplanfis` BIGINT(10) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `sueldopromedio` DECIMAL(13, 2) NULL,
  `cuentabancaria` VARCHAR(255) BINARY NULL,
  `monedactabancaria` VARCHAR(100) BINARY NULL,
  `codigocliente` VARCHAR(150) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `fechafincontrato` DATETIME NULL,
  `fechainiciocontrato` DATETIME NULL,
  `sueldocotizable` DECIMAL(13, 2) NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `registrocontable` BIGINT(10) NULL,
  `pagoactivo` BIGINT(10) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `totalganadonoviembre` DECIMAL(13, 2) NULL,
  `totalganadooctubre` DECIMAL(13, 2) NULL,
  `sueldo` DECIMAL(13, 2) NULL,
  `totalganadoseptiembre` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `diastrabajados` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planilladocentelaboral`;
CREATE TABLE `eos`.`planilladocentelaboral` (
  `idplanilladocentelaboral` DECIMAL(19, 0) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `numerocuenta` VARCHAR(150) BINARY NULL,
  `activogenplanfis` BIGINT(10) NULL,
  `anticipo` DECIMAL(13, 2) NULL,
  `afps` DECIMAL(13, 2) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `minutosausenciabandas` BIGINT(10) NULL,
  `basicoganado` DECIMAL(13, 2) NULL,
  `sueldobasico` DECIMAL(13, 2) NULL,
  `categoria` VARCHAR(255) BINARY NULL,
  `codigocliente` VARCHAR(150) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `fechafincontrato` DATETIME NULL,
  `fechainiciocontrato` DATETIME NULL,
  `modalidadcontratacion` VARCHAR(255) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `diferencia` DECIMAL(13, 2) NULL,
  `descuentossinretencion` DECIMAL(13, 2) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `registrocontable` BIGINT(10) NULL,
  `pagoactivo` BIGINT(10) NULL,
  `ingresofueraiva` DECIMAL(13, 2) NULL,
  `seguro` DECIMAL(13, 2) NULL,
  `saldoiva` DECIMAL(13, 2) NULL,
  `retencioniva` DECIMAL(13, 2) NULL,
  `puesto` VARCHAR(255) BINARY NULL,
  `tipoempleado` VARCHAR(255) BINARY NULL,
  `totallaboral` DECIMAL(13, 2) NULL,
  `saldoivaanterior` DECIMAL(13, 2) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `prestamo` DECIMAL(13, 2) NULL,
  `numerominutosausenciabandas` BIGINT(10) NULL,
  `otrosdescuentos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `totalpatronal` DECIMAL(13, 2) NULL,
  `tipodepago` VARCHAR(20) BINARY NULL,
  `provivienda` DECIMAL(13, 2) NULL,
  `rciva` DECIMAL(13, 2) NULL,
  `atrasos` DECIMAL(13, 2) NULL,
  `minutosatraso` BIGINT(10) NULL,
  `descuentoporminutosatraso` DECIMAL(13, 2) NULL,
  `totaldescuento` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `unidad` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `win` DECIMAL(13, 2) NULL,
  `diastrabajados` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmonedacuenta` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillafiscal`;
CREATE TABLE `eos`.`planillafiscal` (
  `idplanillafiscal` DECIMAL(19, 0) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `anticipo` DECIMAL(13, 2) NULL,
  `haberbasico` DECIMAL(13, 2) NULL,
  `fechanacimiento` DATETIME NULL,
  `fechaingreso` DATETIME NULL,
  `horasextra` DECIMAL(13, 2) NULL,
  `costohorasextra` DECIMAL(13, 2) NULL,
  `genero` VARCHAR(10) BINARY NULL,
  `horasdiapagado` DECIMAL(13, 2) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `prestamo` DECIMAL(13, 2) NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `nacionalidad` VARCHAR(250) BINARY NULL,
  `novedad` VARCHAR(10) BINARY NULL,
  `numero` DECIMAL(19, 0) NULL,
  `ocupacion` VARCHAR(250) BINARY NULL,
  `otrosbonos` DECIMAL(13, 2) NULL,
  `otrosdescuentos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `otrosdescuentosmovsal` DECIMAL(13, 2) NULL,
  `diaspagados` DECIMAL(13, 2) NULL,
  `ci` VARCHAR(255) BINARY NULL,
  `bonoproduccion` DECIMAL(13, 2) NULL,
  `retencionafp` DECIMAL(13, 2) NULL,
  `liquidacionretencion` DECIMAL(13, 2) NULL,
  `bonoantiguedad` DECIMAL(13, 2) NULL,
  `aniosantiguedad` BIGINT(10) NULL,
  `bonodominical` DECIMAL(13, 2) NULL,
  `descuentoporminutosatraso` DECIMAL(13, 2) NULL,
  `totaldescuentos` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `win` DECIMAL(13, 2) NULL,
  `diastrabajados` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL,
  `idplanillatributaria` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillafiscalgenerada`;
CREATE TABLE `eos`.`planillafiscalgenerada` (
  `idplanillafiscalgenerada` DECIMAL(19, 0) NULL,
  `estadovalidacion` VARCHAR(255) BINARY NULL,
  `fechageneracion` DATETIME NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idconfplanillafiscal` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillafiscalporcategoria`;
CREATE TABLE `eos`.`planillafiscalporcategoria` (
  `idplanillafiscalporcategoria` DECIMAL(19, 0) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `anticipo` DECIMAL(13, 2) NULL,
  `haberbasico` DECIMAL(13, 2) NULL,
  `fechanacimiento` DATETIME NULL,
  `fechaingreso` DATETIME NULL,
  `horasextra` DECIMAL(13, 2) NULL,
  `costohorasextra` DECIMAL(13, 2) NULL,
  `genero` VARCHAR(10) BINARY NULL,
  `horasdiapagado` DECIMAL(13, 2) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `prestamo` DECIMAL(13, 2) NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `nacionalidad` VARCHAR(250) BINARY NULL,
  `novedad` VARCHAR(10) BINARY NULL,
  `numero` DECIMAL(19, 0) NULL,
  `ocupacion` VARCHAR(250) BINARY NULL,
  `otrosbonos` DECIMAL(13, 2) NULL,
  `otrosdescuentos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `otrosdescuentosmovsal` DECIMAL(13, 2) NULL,
  `diaspagados` DECIMAL(13, 2) NULL,
  `ci` VARCHAR(255) BINARY NULL,
  `bonoproduccion` DECIMAL(13, 2) NULL,
  `retencionafp` DECIMAL(13, 2) NULL,
  `liquidacionretencion` DECIMAL(13, 2) NULL,
  `bonoantiguedad` DECIMAL(13, 2) NULL,
  `aniosantiguedad` BIGINT(10) NULL,
  `bonodominical` DECIMAL(13, 2) NULL,
  `descuentoporminutosatraso` DECIMAL(13, 2) NULL,
  `totaldescuentos` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `win` DECIMAL(13, 2) NULL,
  `diastrabajados` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idplanillatributariaporcat` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillagenerada`;
CREATE TABLE `eos`.`planillagenerada` (
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `tipoplanillagen` VARCHAR(20) BINARY NULL,
  `fechageneracion` DATETIME NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipocambio` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillageneral`;
CREATE TABLE `eos`.`planillageneral` (
  `idplanillageneral` DECIMAL(19, 0) NULL,
  `minutosausencia` BIGINT(10) NULL,
  `descuentoporminutosausencia` DECIMAL(13, 2) NULL,
  `descuentototalporausencias` DECIMAL(13, 2) NULL,
  `descuentoausencia` DECIMAL(13, 2) NULL,
  `minausencia` BIGINT(10) NULL,
  `activogenplanfis` BIGINT(10) NULL,
  `afps` DECIMAL(13, 2) NULL,
  `area` VARCHAR(255) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `modalidadcontratacion` VARCHAR(255) BINARY NULL,
  `tipocontrol` BIGINT(10) NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `diferencia` DECIMAL(13, 2) NULL,
  `descuentossinretencion` DECIMAL(13, 2) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `registrocontable` BIGINT(10) NULL,
  `pagoactivo` BIGINT(10) NULL,
  `ingresofueraiva` DECIMAL(13, 2) NULL,
  `seguro` DECIMAL(13, 2) NULL,
  `saldoiva` DECIMAL(13, 2) NULL,
  `retencioniva` DECIMAL(13, 2) NULL,
  `puesto` VARCHAR(255) BINARY NULL,
  `tipoempleado` VARCHAR(255) BINARY NULL,
  `totallaboral` DECIMAL(13, 2) NULL,
  `saldoivaanterior` DECIMAL(13, 2) NULL,
  `liquidopagable` DECIMAL(13, 2) NULL,
  `otrosdescuentos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `totalpatrimonial` DECIMAL(13, 2) NULL,
  `provivienda` DECIMAL(13, 2) NULL,
  `sueldo` DECIMAL(13, 2) NULL,
  `atrasos` DECIMAL(13, 2) NULL,
  `totaldescuentos` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `totalperiodosganado` DECIMAL(13, 2) NULL,
  `totalperiodostrabajado` DECIMAL(13, 2) NULL,
  `unidad` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `diastrabajados` BIGINT(10) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillapagomateriaprima`;
CREATE TABLE `eos`.`planillapagomateriaprima` (
  `idplanillapagomateriaprima` DECIMAL(19, 0) NULL,
  `fechafin` DATETIME NULL,
  `it` DECIMAL(3, 2) NULL,
  `iue` DECIMAL(3, 2) NULL,
  `fechainicio` DATETIME NULL,
  `estado` VARCHAR(50) BINARY NULL,
  `tasaimpuesto` DECIMAL(3, 2) NULL,
  `totalajustexgab` DECIMAL(16, 2) NULL,
  `totalalcoholxgab` DECIMAL(16, 2) NULL,
  `totalpesadoxgab` DECIMAL(16, 2) NULL,
  `totalconcentradosxgab` DECIMAL(16, 2) NULL,
  `totalcreditoxgab` DECIMAL(16, 2) NULL,
  `totadescuentosxgab` DECIMAL(16, 2) NULL,
  `totaliquidoxgab` DECIMAL(16, 2) NULL,
  `totalmontoacopioadoxgab` DECIMAL(16, 2) NULL,
  `totalotrosdecuentosxgab` DECIMAL(16, 2) NULL,
  `totalotrosingresosxgab` DECIMAL(16, 2) NULL,
  `totaltachosxgab` DECIMAL(16, 2) NULL,
  `totaldescuentoreserva` DECIMAL(16, 2) NULL,
  `totalretencionesxgab` DECIMAL(16, 2) NULL,
  `totalveterinarioxgab` DECIMAL(16, 2) NULL,
  `totalacopiadoxgab` DECIMAL(16, 2) NULL,
  `totalyogurdxgab` DECIMAL(16, 2) NULL,
  `preciounitario` DECIMAL(9, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillatributaria`;
CREATE TABLE `eos`.`planillatributaria` (
  `idplanillatributaria` DECIMAL(19, 0) NULL,
  `haberbasico` DECIMAL(13, 2) NULL,
  `cns` DECIMAL(13, 2) NULL,
  `codigo` VARCHAR(255) BINARY NULL,
  `saldodependiente` DECIMAL(13, 2) NULL,
  `saldodependientemessgute` DECIMAL(13, 2) NULL,
  `saldototaldependiente` DECIMAL(13, 2) NULL,
  `fechaingreso` DATETIME NULL,
  `horasextra` DECIMAL(13, 2) NULL,
  `costohorasextra` DECIMAL(13, 2) NULL,
  `creditofiscal` DECIMAL(13, 2) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `saldoanterioractualizado` DECIMAL(13, 2) NULL,
  `saldomesanterior` DECIMAL(13, 2) NULL,
  `mantenimientovalor` DECIMAL(13, 2) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `sueldoneto` DECIMAL(13, 2) NULL,
  `numero` DECIMAL(19, 0) NULL,
  `otrosbonos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `retpatrproviviendaafp` DECIMAL(13, 2) NULL,
  `retpatrriesgoprofafp` DECIMAL(13, 2) NULL,
  `retencionpatronalafp` DECIMAL(13, 2) NULL,
  `retpatrsolidarioafp` DECIMAL(13, 2) NULL,
  `saldofisco` DECIMAL(13, 2) NULL,
  `bonoproduccion` DECIMAL(13, 2) NULL,
  `retencionafp` DECIMAL(13, 2) NULL,
  `liquidacionretencion` DECIMAL(13, 2) NULL,
  `sueldonoimpdossmn` DECIMAL(13, 2) NULL,
  `bonoantiguedad` DECIMAL(13, 2) NULL,
  `aniosantiguedad` BIGINT(10) NULL,
  `afpsolidario` DECIMAL(13, 2) NULL,
  `bonodominical` DECIMAL(13, 2) NULL,
  `impuesto` DECIMAL(13, 2) NULL,
  `impsobredossmn` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `totalotrosingresos` DECIMAL(13, 2) NULL,
  `difsujetaimpuesto` DECIMAL(13, 2) NULL,
  `saldoutilizado` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planillatributariaporcategoria`;
CREATE TABLE `eos`.`planillatributariaporcategoria` (
  `idplanillatributariaporcat` DECIMAL(19, 0) NULL,
  `haberbasico` DECIMAL(13, 2) NULL,
  `cns` DECIMAL(13, 2) NULL,
  `codigo` VARCHAR(255) BINARY NULL,
  `saldodependiente` DECIMAL(13, 2) NULL,
  `saldodependientemessgute` DECIMAL(13, 2) NULL,
  `saldototaldependiente` DECIMAL(13, 2) NULL,
  `fechaingreso` DATETIME NULL,
  `horasextra` DECIMAL(13, 2) NULL,
  `costohorasextra` DECIMAL(13, 2) NULL,
  `creditofiscal` DECIMAL(13, 2) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `saldoanterioractualizado` DECIMAL(13, 2) NULL,
  `saldomesanterior` DECIMAL(13, 2) NULL,
  `mantenimientovalor` DECIMAL(13, 2) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `sueldoneto` DECIMAL(13, 2) NULL,
  `numero` DECIMAL(19, 0) NULL,
  `otrosbonos` DECIMAL(13, 2) NULL,
  `otrosingresos` DECIMAL(13, 2) NULL,
  `retpatrproviviendaafp` DECIMAL(13, 2) NULL,
  `retpatrriesgoprofafp` DECIMAL(13, 2) NULL,
  `retencionpatronalafp` DECIMAL(13, 2) NULL,
  `retpatrsolidarioafp` DECIMAL(13, 2) NULL,
  `saldofisco` DECIMAL(13, 2) NULL,
  `bonoproduccion` DECIMAL(13, 2) NULL,
  `retencionafp` DECIMAL(13, 2) NULL,
  `liquidacionretencion` DECIMAL(13, 2) NULL,
  `sueldonoimpdossmn` DECIMAL(13, 2) NULL,
  `bonoantiguedad` DECIMAL(13, 2) NULL,
  `aniosantiguedad` BIGINT(10) NULL,
  `afpsolidario` DECIMAL(13, 2) NULL,
  `bonodominical` DECIMAL(13, 2) NULL,
  `impuesto` DECIMAL(13, 2) NULL,
  `impsobredossmn` DECIMAL(13, 2) NULL,
  `totalganado` DECIMAL(13, 2) NULL,
  `totalotrosingresos` DECIMAL(13, 2) NULL,
  `difsujetaimpuesto` DECIMAL(13, 2) NULL,
  `saldoutilizado` DECIMAL(13, 2) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`plantilla`;
CREATE TABLE `eos`.`plantilla` (
  `idplantilla` DECIMAL(19, 0) NULL,
  `formato` VARCHAR(50) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `tipo` VARCHAR(50) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idarchivo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`planvacacion`;
CREATE TABLE `eos`.`planvacacion` (
  `idplanvacacion` DECIMAL(19, 0) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `diaslibres` BIGINT(10) NULL,
  `diasusados` BIGINT(10) NULL,
  `fechainicio` DATETIME NULL,
  `aniosantiguedad` BIGINT(10) NULL,
  `diasvacacion` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcontractopuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`politicadescuento`;
CREATE TABLE `eos`.`politicadescuento` (
  `idpoliticadescuento` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idacreedor` DECIMAL(19, 0) NULL,
  `idtipopoliticadescuento` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`porcentajetributario`;
CREATE TABLE `eos`.`porcentajetributario` (
  `idporcentajetributario` DECIMAL(19, 0) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `porcentaje` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipoporcentajetrib` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`postulante`;
CREATE TABLE `eos`.`postulante` (
  `idpostulante` DECIMAL(19, 0) NULL,
  `fechanacimiento` DATETIME NULL,
  `lugarnacimiento` VARCHAR(250) BINARY NULL,
  `celular` BIGINT(10) NULL,
  `email` VARCHAR(100) BINARY NULL,
  `lugarextension` VARCHAR(250) BINARY NULL,
  `nombres` VARCHAR(250) BINARY NULL,
  `genero` VARCHAR(255) BINARY NULL,
  `noidentificacion` BIGINT(10) NULL,
  `apellidopaterno` VARCHAR(200) BINARY NULL,
  `apellidomaterno` VARCHAR(200) BINARY NULL,
  `telefono` BIGINT(10) NULL,
  `tipo` VARCHAR(20) BINARY NULL,
  `fecharegistro` DATETIME NULL,
  `salariotiempocompleto` DECIMAL(13, 2) NULL,
  `salariomediotiempo` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idlibros` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idarticulosinternacional` DECIMAL(19, 0) NULL,
  `idpremiosinternacionales` DECIMAL(19, 0) NULL,
  `idarticulosnacional` DECIMAL(19, 0) NULL,
  `idpremiosnacionales` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`postulanteasigna`;
CREATE TABLE `eos`.`postulanteasigna` (
  `idpostulante` DECIMAL(19, 0) NULL,
  `idasignatura` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`postulantecargo`;
CREATE TABLE `eos`.`postulantecargo` (
  `idpostulantecargo` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpostulante` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`pregunta`;
CREATE TABLE `eos`.`pregunta` (
  `idpregunta` DECIMAL(19, 0) NULL,
  `contenido` LONGTEXT BINARY NULL,
  `indice` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcriterioevaluacion` DECIMAL(19, 0) NULL,
  `idseccion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`presupuestogasto`;
CREATE TABLE `eos`.`presupuestogasto` (
  `idpresupuesto` DECIMAL(19, 0) NULL,
  `importe` DECIMAL(13, 2) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `editable` BIGINT(10) NULL,
  `estado` VARCHAR(30) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idactividad` DECIMAL(19, 0) NULL,
  `iddistpresupuesto` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idclasificador` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`presupuestoingreso`;
CREATE TABLE `eos`.`presupuestoingreso` (
  `idpresupuestoingreso` DECIMAL(19, 0) NULL,
  `importe` DECIMAL(13, 2) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `editable` BIGINT(10) NULL,
  `estado` VARCHAR(30) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `iddistpresupuesto` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idclasificador` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`previsionretiro`;
CREATE TABLE `eos`.`previsionretiro` (
  `idprevisionretiro` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(16, 6) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(20) BINARY NULL,
  `tipocambio` DECIMAL(16, 6) NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `notrans` VARCHAR(10) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `numerocompania` VARCHAR(255) BINARY NULL,
  `idretiro` DECIMAL(19, 0) NULL,
  `idgestionplanilla` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`producto`;
CREATE TABLE `eos`.`producto` (
  `idproducto` DECIMAL(19, 0) NULL,
  `cuentaactivo` VARCHAR(200) BINARY NULL,
  `preciocompra` DECIMAL(13, 2) NULL,
  `codigoproducto` VARCHAR(100) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `cuentapasivo` VARCHAR(200) BINARY NULL,
  `nombreproducto` VARCHAR(150) BINARY NULL,
  `precioventa` DECIMAL(13, 2) NULL,
  `fechaestado` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipoproducto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productobase`;
CREATE TABLE `eos`.`productobase` (
  `idproductobase` DECIMAL(24, 0) NULL,
  `codigo` VARCHAR(50) BINARY NULL,
  `no_trans` VARCHAR(255) BINARY NULL,
  `no_vale` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `costototalinsumos` DECIMAL(16, 6) NULL,
  `unidades` BIGINT(10) NULL,
  `volumen` DECIMAL(8, 2) NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idplanificacionproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productoorden`;
CREATE TABLE `eos`.`productoorden` (
  `idproductoorden` DECIMAL(24, 0) NULL,
  `nombreproducto` VARCHAR(100) BINARY NULL,
  `idproductoprocesado` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productoprocesado`;
CREATE TABLE `eos`.`productoprocesado` (
  `cantidad` DECIMAL(7, 2) NULL,
  `unidadmedidate` VARCHAR(4) BINARY NULL,
  `idproductoprocesado` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productoreprocesado`;
CREATE TABLE `eos`.`productoreprocesado` (
  `idproductoreprocesado` DECIMAL(24, 0) NULL,
  `unidades` BIGINT(10) NULL,
  `volumen` DECIMAL(8, 2) NULL,
  `idproductobase` DECIMAL(24, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productormateriaprima`;
CREATE TABLE `eos`.`productormateriaprima` (
  `licenciaimpuestos` VARCHAR(200) BINARY NULL,
  `licenciaimpuestos2011` VARCHAR(200) BINARY NULL,
  `fechaexpiralicenciaimpuesto` DATETIME NULL,
  `fechafinimpuesto2011` DATETIME NULL,
  `esresponsable` BIGINT(10) NULL,
  `fechainicialicenciaimpuesto` DATETIME NULL,
  `fechainiimpuesto2011` DATETIME NULL,
  `idproductormateriaprima` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productosimple`;
CREATE TABLE `eos`.`productosimple` (
  `idproductosimple` DECIMAL(24, 0) NULL,
  `cantidad` BIGINT(10) NULL,
  `cantidadproducidaresponsable` BIGINT(10) NULL,
  `costototalmanoobra` DECIMAL(16, 6) NULL,
  `porcentajegrasa` DECIMAL(16, 6) NULL,
  `no_trans` VARCHAR(255) BINARY NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `costototalproduccion` DECIMAL(16, 6) NULL,
  `costototalindirecto` DECIMAL(16, 6) NULL,
  `costototalinsumos` DECIMAL(16, 6) NULL,
  `costototalmateriales` DECIMAL(16, 6) NULL,
  `costounitario` DECIMAL(16, 6) NULL,
  `idproductobase` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`productosimpleprocesado`;
CREATE TABLE `eos`.`productosimpleprocesado` (
  `idproductosimpleprocesado` DECIMAL(24, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idproductosimple` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`programa`;
CREATE TABLE `eos`.`programa` (
  `idprograma` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(30) BINARY NULL,
  `fechacreacion` DATETIME NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `fechamodificacion` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`puesto`;
CREATE TABLE `eos`.`puesto` (
  `idpuesto` DECIMAL(19, 0) NULL,
  `idcargo` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL,
  `idunidadorganizacional` DECIMAL(19, 0) NULL,
  `idsueldo` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`puntuacion`;
CREATE TABLE `eos`.`puntuacion` (
  `idpuntuacion` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idvalorcriterioevaluacion` DECIMAL(19, 0) NULL,
  `idejemplarencuesta` DECIMAL(19, 0) NULL,
  `idpregunta` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rangopuntua`;
CREATE TABLE `eos`.`rangopuntua` (
  `idrangopuntua` DECIMAL(19, 0) NULL,
  `finrango` BIGINT(10) NULL,
  `interpretacion` VARCHAR(250) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `posicion` BIGINT(10) NULL,
  `iniciorango` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idformevalfinal` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rangoregladescuento`;
CREATE TABLE `eos`.`rangoregladescuento` (
  `idrangoregladescuento` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `rangofinal` BIGINT(10) NULL,
  `rangoinicial` BIGINT(10) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `secuencia` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idregladescuento` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rdescuentocliente`;
CREATE TABLE `eos`.`rdescuentocliente` (
  `iddescuentocliente` DECIMAL(19, 0) NULL,
  `fechaactivacion` DATETIME NULL,
  `monto` DECIMAL(13, 2) NULL,
  `estadoregladescuento` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `notas` LONGTEXT BINARY NULL,
  `fechaestado` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpoliticadescuento` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rdescuentoempleado`;
CREATE TABLE `eos`.`rdescuentoempleado` (
  `iddescuentoempleado` DECIMAL(19, 0) NULL,
  `fechaactivacion` DATETIME NULL,
  `monto` DECIMAL(13, 2) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `estadoregladescuento` VARCHAR(255) BINARY NULL,
  `notas` LONGTEXT BINARY NULL,
  `cantidad` BIGINT(10) NULL,
  `fechaestado` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpoliticadescuento` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rdescuentoproducto`;
CREATE TABLE `eos`.`rdescuentoproducto` (
  `iddescuentoproducto` DECIMAL(19, 0) NULL,
  `fechaactivacion` DATETIME NULL,
  `monto` DECIMAL(13, 2) NULL,
  `estadoregladescuento` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `notas` LONGTEXT BINARY NULL,
  `fechaestado` DATETIME NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idpoliticadescuento` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reembolso`;
CREATE TABLE `eos`.`reembolso` (
  `idreembolso` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idtiporeembolso` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`regaporgenplan`;
CREATE TABLE `eos`.`regaporgenplan` (
  `idregaporgenplan` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(18, 2) NULL,
  `nocia` VARCHAR(255) BINARY NULL,
  `tipodoc` VARCHAR(255) BINARY NULL,
  `notrans` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `iddescripcion` DECIMAL(19, 0) NULL,
  `idciclogeneracionplanilla` DECIMAL(19, 0) NULL,
  `identidadbensocial` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`registroacopio`;
CREATE TABLE `eos`.`registroacopio` (
  `idregistroacopio` DECIMAL(19, 0) NULL,
  `cantidadrecibida` DECIMAL(16, 2) NULL,
  `cantidadrechazada` DECIMAL(16, 2) NULL,
  `cantidadpesada` DECIMAL(16, 2) NULL,
  `idplanillaacopio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`registrocontable`;
CREATE TABLE `eos`.`registrocontable` (
  `idregistrocontable` DECIMAL(19, 0) NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `tipodocumentocxp` VARCHAR(255) BINARY NULL,
  `impmonextbanco` DECIMAL(13, 2) NULL,
  `impmonextcheque` DECIMAL(13, 2) NULL,
  `tipo` VARCHAR(20) BINARY NULL,
  `montomaxino` DECIMAL(13, 2) NULL,
  `noidentificacion` VARCHAR(100) BINARY NULL,
  `montominimo` DECIMAL(13, 2) NULL,
  `mes` VARCHAR(20) BINARY NULL,
  `impmonnacbanco` DECIMAL(13, 2) NULL,
  `impmonnaccheque` DECIMAL(13, 2) NULL,
  `cuentaxpagar` VARCHAR(31) BINARY NULL,
  `codigoproveedor` VARCHAR(255) BINARY NULL,
  `fecharegistro` DATETIME NULL,
  `notrans` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `iddescripcion` DECIMAL(19, 0) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`registropagomateriaprima`;
CREATE TABLE `eos`.`registropagomateriaprima` (
  `idregistropagomateriaprima` DECIMAL(19, 0) NULL,
  `descuentoreserva` DECIMAL(16, 2) NULL,
  `totalganado` DECIMAL(16, 2) NULL,
  `fechaexpiralicenciaimpuesto` DATETIME NULL,
  `liquidopagable` DECIMAL(16, 2) NULL,
  `ajustezonaproductiva` DECIMAL(16, 2) NULL,
  `fechainicialicenciaimpuesto` DATETIME NULL,
  `licenciaimpuestos` VARCHAR(200) BINARY NULL,
  `cantidadtotal` DECIMAL(24, 2) NULL,
  `totalpagoacopio` DECIMAL(16, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idplanillapagomateriaprima` DECIMAL(19, 0) NULL,
  `iddescuentproductmateriaprima` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`registrotransferenciaproduct`;
CREATE TABLE `eos`.`registrotransferenciaproduct` (
  `idregistrotransferenciaproduct` DECIMAL(19, 0) NULL,
  `fechaentrega` DATETIME NULL,
  `fecharecepcion` DATETIME NULL,
  `estado` VARCHAR(50) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`regladescuento`;
CREATE TABLE `eos`.`regladescuento` (
  `idregladescuento` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `tiporango` VARCHAR(30) BINARY NULL,
  `tipodescuento` VARCHAR(20) BINARY NULL,
  `tipounidaddescuento` VARCHAR(30) BINARY NULL,
  `tipointervalo` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `idgestion` DECIMAL(19, 0) NULL,
  `idcategoriapuesto` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reglaretiro`;
CREATE TABLE `eos`.`reglaretiro` (
  `idreglaretiro` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `monto` DECIMAL(13, 2) NULL,
  `tipomonto` VARCHAR(20) BINARY NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(255) BINARY NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `tipo` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `ocurrencia` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reglatributaria`;
CREATE TABLE `eos`.`reglatributaria` (
  `idreglatributaria` DECIMAL(19, 0) NULL,
  `cantidadasignada` BIGINT(10) NULL,
  `numerofacturaactual` DECIMAL(19, 0) NULL,
  `fechadosificacion` DATETIME NULL,
  `fechapedido` DATETIME NULL,
  `numerofacturafin` DECIMAL(19, 0) NULL,
  `cantidadminima` BIGINT(10) NULL,
  `notas` LONGTEXT BINARY NULL,
  `numeroorden` VARCHAR(50) BINARY NULL,
  `periododosificacion` VARCHAR(150) BINARY NULL,
  `numeroserie` VARCHAR(50) BINARY NULL,
  `numerofacturainicio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idtipodosificacion` DECIMAL(19, 0) NULL,
  `idporcentajetributario` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reglavacacion`;
CREATE TABLE `eos`.`reglavacacion` (
  `idreglavacacion` DECIMAL(19, 0) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `aniosinicio` BIGINT(10) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `aniosfin` BIGINT(10) NULL,
  `diasvacacion` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reltransregctb`;
CREATE TABLE `eos`.`reltransregctb` (
  `idreltransregctb` DECIMAL(19, 0) NULL,
  `notrans` VARCHAR(10) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idregistrocontable` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reportecontrol`;
CREATE TABLE `eos`.`reportecontrol` (
  `idreportecontrol` DECIMAL(19, 0) NULL,
  `faltabanda` BIGINT(10) NULL,
  `descuentofaltabanda` DECIMAL(13, 2) NULL,
  `tipocontrol` BIGINT(10) NULL,
  `fecha` DATETIME NULL,
  `importedescuento` DECIMAL(13, 2) NULL,
  `marcfin` DATETIME NULL,
  `marcinicio` DATETIME NULL,
  `marcaciones` LONGTEXT BINARY NULL,
  `mindescuento` BIGINT(10) NULL,
  `numerofaltabandas` BIGINT(10) NULL,
  `sueldoporbanda` DECIMAL(13, 2) NULL,
  `sueldoporfin` DECIMAL(13, 2) NULL,
  `importeminutostrabajo` DECIMAL(13, 2) NULL,
  `minutostrabajados` BIGINT(10) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idplanillagenerada` DECIMAL(19, 0) NULL,
  `idbandahorariac` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`reportemarcacion`;
CREATE TABLE `eos`.`reportemarcacion` (
  `idreportemarcacion` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idbandahorariacontrato` DECIMAL(19, 0) NULL,
  `idtipomarcacion` DECIMAL(19, 0) NULL,
  `idrhmarcado` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`responsablecomppnl`;
CREATE TABLE `eos`.`responsablecomppnl` (
  `idresponsablecomppnl` DECIMAL(19, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcontratopuesto` DECIMAL(19, 0) NULL,
  `idcomponentepanel` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`resumenplanificacionacademica`;
CREATE TABLE `eos`.`resumenplanificacionacademica` (
  `idresumenplanacad` VARCHAR(255) BINARY NULL,
  `sigla` VARCHAR(255) BINARY NULL,
  `unidad_acad_adm` BIGINT(10) NULL,
  `cod_asignatura` VARCHAR(255) BINARY NULL,
  `grupo_asignatura` VARCHAR(255) BINARY NULL,
  `nombre_asignatura` VARCHAR(255) BINARY NULL,
  `carrera` VARCHAR(255) BINARY NULL,
  `sede` VARCHAR(200) BINARY NULL,
  `codempleado` DECIMAL(19, 0) NULL,
  `nombres` VARCHAR(255) BINARY NULL,
  `gestion` BIGINT(10) NULL,
  `tipo_grupo` VARCHAR(255) BINARY NULL,
  `documento` VARCHAR(255) BINARY NULL,
  `apellido_paterno` VARCHAR(255) BINARY NULL,
  `apellido_materno` VARCHAR(255) BINARY NULL,
  `cant_estudiantes` BIGINT(10) NULL,
  `periodo` BIGINT(10) NULL,
  `carga_practica` BIGINT(10) NULL,
  `carga_horaria` BIGINT(10) NULL,
  `semestre` VARCHAR(255) BINARY NULL,
  `plan_estudio` VARCHAR(255) BINARY NULL,
  `carga_teorica` BIGINT(10) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`retiro`;
CREATE TABLE `eos`.`retiro` (
  `idretiro` DECIMAL(19, 0) NULL,
  `monto` DECIMAL(16, 6) NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(255) BINARY NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `fecharetiro` DATETIME NULL,
  `estado` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `diastrabajados` BIGINT(10) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcontrato` DECIMAL(19, 0) NULL,
  `idarchivo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`revisionentidad`;
CREATE TABLE `eos`.`revisionentidad` (
  `idreventidad` DECIMAL(19, 0) NULL,
  `nrorevision` DECIMAL(19, 0) NULL,
  `almacenadoen` DATETIME NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `almacenadopor` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rhmarcado`;
CREATE TABLE `eos`.`rhmarcado` (
  `idrhmarcado` DECIMAL(19, 0) NULL,
  `control` BIGINT(10) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `marfecha` DATETIME NULL,
  `marippc` VARCHAR(200) BINARY NULL,
  `marperid` BIGINT(10) NULL,
  `marreftarjeta` VARCHAR(200) BINARY NULL,
  `marestado` VARCHAR(200) BINARY NULL,
  `marhora` DATETIME NULL,
  `sede` VARCHAR(200) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `mar_in_out` DECIMAL(22, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`rol`;
CREATE TABLE `eos`.`rol` (
  `idrol` DECIMAL(19, 0) NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`saludo`;
CREATE TABLE `eos`.`saludo` (
  `idsaludo` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`seccion`;
CREATE TABLE `eos`.`seccion` (
  `idseccion` DECIMAL(19, 0) NULL,
  `indice` BIGINT(10) NULL,
  `titulo` VARCHAR(250) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idformularioencuesta` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`sector`;
CREATE TABLE `eos`.`sector` (
  `idsector` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`secuencia`;
CREATE TABLE `eos`.`secuencia` (
  `tabla` VARCHAR(255) BINARY NULL,
  `valor` BIGINT(10) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`sede`;
CREATE TABLE `eos`.`sede` (
  `idsede` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `idreferencia` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`sesionacopio`;
CREATE TABLE `eos`.`sesionacopio` (
  `idsesionacopio` DECIMAL(24, 0) NULL,
  `fecha` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idzonaproductiva` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`solicitudmantenimiento`;
CREATE TABLE `eos`.`solicitudmantenimiento` (
  `idsolmant` DECIMAL(19, 0) NULL,
  `codigo` VARCHAR(150) BINARY NULL,
  `fechasolmant` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `tipo` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `numerocompania` VARCHAR(255) BINARY NULL,
  `idunidadejecutora` DECIMAL(19, 0) NULL,
  `idmantenimiento` DECIMAL(19, 0) NULL,
  `idmotivosolicitud` DECIMAL(19, 0) NULL,
  `idsolicitante` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`solmantactivofijo`;
CREATE TABLE `eos`.`solmantactivofijo` (
  `idsolmant` DECIMAL(19, 0) NULL,
  `idactivo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`sueldo`;
CREATE TABLE `eos`.`sueldo` (
  `idsueldo` DECIMAL(19, 0) NULL,
  `cantidad` DECIMAL(15, 2) NULL,
  `haberbasico` DECIMAL(15, 2) NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmoneda` DECIMAL(19, 0) NULL,
  `idtiposueldo` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tarjetatiempoempleado`;
CREATE TABLE `eos`.`tarjetatiempoempleado` (
  `idtarjetatiempoempleado` DECIMAL(19, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `costoporhora` DECIMAL(16, 2) NULL,
  `fecha` DATETIME NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `finjornada` DATETIME NULL,
  `horafin` DATETIME NULL,
  `cod_gru` VARCHAR(3) BINARY NULL,
  `horainicio` DATETIME NULL,
  `cod_sub` VARCHAR(3) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idempleado` DECIMAL(19, 0) NULL,
  `idtipotareaprod` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tasaafp`;
CREATE TABLE `eos`.`tasaafp` (
  `idtasaafp` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `tipotasaafp` VARCHAR(30) BINARY NULL,
  `tasa` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tasacns`;
CREATE TABLE `eos`.`tasacns` (
  `idtasacns` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `tasa` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tasaiva`;
CREATE TABLE `eos`.`tasaiva` (
  `idtasaiva` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `tasa` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tasasmn`;
CREATE TABLE `eos`.`tasasmn` (
  `idtasasmn` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `tasa` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`texto`;
CREATE TABLE `eos`.`texto` (
  `idtexto` DECIMAL(19, 0) NULL,
  `valor` LONGTEXT BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipobandahoraria`;
CREATE TABLE `eos`.`tipobandahoraria` (
  `idtipobandahoraria` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipocaja`;
CREATE TABLE `eos`.`tipocaja` (
  `idtipocaja` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipocambio`;
CREATE TABLE `eos`.`tipocambio` (
  `idtipocambio` DECIMAL(19, 0) NULL,
  `fecha` DATETIME NULL,
  `compra` DECIMAL(13, 2) NULL,
  `tasa` DECIMAL(13, 2) NULL,
  `venta` DECIMAL(13, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipociclo`;
CREATE TABLE `eos`.`tipociclo` (
  `idtipociclo` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `periodo` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idsector` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipodocfondorota`;
CREATE TABLE `eos`.`tipodocfondorota` (
  `idtipodocfondorota` DECIMAL(19, 0) NULL,
  `activo` BIGINT(10) NULL,
  `cuentactbajme` VARCHAR(20) BINARY NULL,
  `cuentactbajmn` VARCHAR(20) BINARY NULL,
  `codigo` DECIMAL(19, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `descripcion` VARCHAR(1000) BINARY NULL,
  `restriccioncampo` VARCHAR(100) BINARY NULL,
  `cuentactbme` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(250) BINARY NULL,
  `cuentactbmn` VARCHAR(20) BINARY NULL,
  `columnaplanilla` VARCHAR(20) BINARY NULL,
  `tipofondorotatorio` VARCHAR(25) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `no_usr` VARCHAR(4) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipodocumento`;
CREATE TABLE `eos`.`tipodocumento` (
  `idtipodocumento` DECIMAL(19, 0) NULL,
  `aplicablea` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipodosificacion`;
CREATE TABLE `eos`.`tipodosificacion` (
  `idtipodosificacion` DECIMAL(19, 0) NULL,
  `nombretipo` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipoestadocaja`;
CREATE TABLE `eos`.`tipoestadocaja` (
  `idtipoestadocaja` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipoestadocontabilidad`;
CREATE TABLE `eos`.`tipoestadocontabilidad` (
  `idtipoestadocontabilidad` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipomarcacion`;
CREATE TABLE `eos`.`tipomarcacion` (
  `idtipomarcacion` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipomovimientogab`;
CREATE TABLE `eos`.`tipomovimientogab` (
  `idtipomovimientogab` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `tipomovimiento` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipomovimientoproductor`;
CREATE TABLE `eos`.`tipomovimientoproductor` (
  `idtipomovimientoproductor` DECIMAL(19, 0) NULL,
  `moneda` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `tipomovimiento` VARCHAR(255) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipomovsueldo`;
CREATE TABLE `eos`.`tipomovsueldo` (
  `idtipomovsueldo` DECIMAL(19, 0) NULL,
  `pordefecto` BIGINT(10) NULL,
  `cuentactb` VARCHAR(20) BINARY NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `tipo` VARCHAR(100) BINARY NULL,
  `nombre` VARCHAR(255) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipoperiodopreasiento`;
CREATE TABLE `eos`.`tipoperiodopreasiento` (
  `idtiporeglapreasiento` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipopoliticadescuento`;
CREATE TABLE `eos`.`tipopoliticadescuento` (
  `idtipopoliticadescuento` DECIMAL(19, 0) NULL,
  `medicion` VARCHAR(25) BINARY NULL,
  `recurso` VARCHAR(50) BINARY NULL,
  `destino` VARCHAR(15) BINARY NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipoporcentajetributario`;
CREATE TABLE `eos`.`tipoporcentajetributario` (
  `idtipoporcentajetrib` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipoproducto`;
CREATE TABLE `eos`.`tipoproducto` (
  `idtipoproducto` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tiporeembolso`;
CREATE TABLE `eos`.`tiporeembolso` (
  `idtiporeembolso` DECIMAL(19, 0) NULL,
  `detalle` LONGTEXT BINARY NULL,
  `cantidad` BIGINT(10) NULL,
  `preciototal` DECIMAL(13, 2) NULL,
  `preciounitario` DECIMAL(13, 2) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tiposueldo`;
CREATE TABLE `eos`.`tiposueldo` (
  `idtiposueldo` DECIMAL(19, 0) NULL,
  `descripcion` VARCHAR(255) BINARY NULL,
  `tipo` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idsector` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipotareaprod`;
CREATE TABLE `eos`.`tipotareaprod` (
  `idtipotareaprod` DECIMAL(19, 0) NULL,
  `no_cia` VARCHAR(2) BINARY NULL,
  `cod_gru` VARCHAR(255) BINARY NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tipounidadnegocio`;
CREATE TABLE `eos`.`tipounidadnegocio` (
  `idtipounidadnegocio` DECIMAL(19, 0) NULL,
  `principal` BIGINT(10) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`titulo`;
CREATE TABLE `eos`.`titulo` (
  `idtitulo` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(100) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`tolerancia`;
CREATE TABLE `eos`.`tolerancia` (
  `idtolerancia` DECIMAL(19, 0) NULL,
  `despuesfin` BIGINT(10) NULL,
  `despuesinicio` BIGINT(10) NULL,
  `antesfin` BIGINT(10) NULL,
  `antesinicio` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`transaccioncaja`;
CREATE TABLE `eos`.`transaccioncaja` (
  `idtransaccion` DECIMAL(19, 0) NULL,
  `fechacierre` DATETIME NULL,
  `importefalla` DECIMAL(13, 2) NULL,
  `descripcionfalla` LONGTEXT BINARY NULL,
  `importemodificado` DECIMAL(13, 2) NULL,
  `fechaapertura` DATETIME NULL,
  `importetotal` DECIMAL(13, 2) NULL,
  `idcaja` DECIMAL(19, 0) NULL,
  `idusuariocaja` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocontrol` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`transaccioncredito`;
CREATE TABLE `eos`.`transaccioncredito` (
  `idtransaccioncredito` DECIMAL(19, 0) NULL,
  `importe` DECIMAL(13, 2) NULL,
  `fechatransaccion` DATETIME NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcredito` DECIMAL(19, 0) NULL,
  `idfactura` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`unidadmedidaproduccion`;
CREATE TABLE `eos`.`unidadmedidaproduccion` (
  `idunidadmedidaproduccion` DECIMAL(24, 0) NULL,
  `descripcion` VARCHAR(500) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`unidadnegocio`;
CREATE TABLE `eos`.`unidadnegocio` (
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `sigla` VARCHAR(10) BINARY NULL,
  `direccion` VARCHAR(250) BINARY NULL,
  `nomatricomercial` VARCHAR(100) BINARY NULL,
  `descripcion` LONGTEXT BINARY NULL,
  `codunidadejecutora` VARCHAR(10) BINARY NULL,
  `posicion` BIGINT(10) NULL,
  `publicidad` VARCHAR(80) BINARY NULL,
  `cantidaddepartamentos` BIGINT(10) NULL,
  `cantidadempleados` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idtipounidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idresponsablerh` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`unidadorganizacional`;
CREATE TABLE `eos`.`unidadorganizacional` (
  `idunidadorganizacional` DECIMAL(19, 0) NULL,
  `sigla` VARCHAR(200) BINARY NULL,
  `planestudio` VARCHAR(10) BINARY NULL,
  `numerocompania` VARCHAR(2) BINARY NULL,
  `codigocencos` VARCHAR(6) BINARY NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idnivelorganizacional` DECIMAL(19, 0) NULL,
  `unidadorganizacionalraiz` DECIMAL(19, 0) NULL,
  `idsector` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`usuario`;
CREATE TABLE `eos`.`usuario` (
  `idusuario` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `email` VARCHAR(100) BINARY NULL,
  `numerousuario` VARCHAR(4) BINARY NULL,
  `usuariofinanzas` BIGINT(10) NULL,
  `clave` VARCHAR(200) BINARY NULL,
  `usuario` VARCHAR(50) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`usuariorol`;
CREATE TABLE `eos`.`usuariorol` (
  `idrol` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`usuariounidadnegocio`;
CREATE TABLE `eos`.`usuariounidadnegocio` (
  `idusuariounidadnegocio` DECIMAL(19, 0) NULL,
  `idunidadnegocio` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuario` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`vacacion`;
CREATE TABLE `eos`.`vacacion` (
  `idvacacion` DECIMAL(19, 0) NULL,
  `fechacreacion` DATETIME NULL,
  `diaslibres` BIGINT(10) NULL,
  `descripcion` VARCHAR(200) BINARY NULL,
  `fechafin` DATETIME NULL,
  `fechainicio` DATETIME NULL,
  `estado` VARCHAR(255) BINARY NULL,
  `totaldias` BIGINT(10) NULL,
  `fechamodificacion` DATETIME NULL,
  `usarparagenplan` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idusuariocreador` DECIMAL(19, 0) NULL,
  `idusuarioeditor` DECIMAL(19, 0) NULL,
  `idgestionvacacion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`valeinsumosrequeridos`;
CREATE TABLE `eos`.`valeinsumosrequeridos` (
  `idvaleinsumosrequeridos` DECIMAL(24, 0) NULL,
  `cantidad` DECIMAL(24, 0) NULL,
  `preciocostototal` DECIMAL(16, 2) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idmetaproductoproduccion` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`valeproductoterminado`;
CREATE TABLE `eos`.`valeproductoterminado` (
  `idvaleproductoterminado` DECIMAL(24, 0) NULL,
  `observaciones` VARCHAR(1500) BINARY NULL,
  `cantidadproducida` DECIMAL(24, 0) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `identradaordenproduccion` DECIMAL(24, 0) NULL,
  `idproductoprocesado` DECIMAL(24, 0) NULL,
  `idordenproduccion` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`valorcriterioevaluacion`;
CREATE TABLE `eos`.`valorcriterioevaluacion` (
  `idvalorcriterioevaluacion` DECIMAL(19, 0) NULL,
  `indice` BIGINT(10) NULL,
  `titulo` VARCHAR(250) BINARY NULL,
  `valor` BIGINT(10) NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `idcriterioevaluacion` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`vmarcado`;
CREATE TABLE `eos`.`vmarcado` (
  `idrhmarcado` DECIMAL(24, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL,
  `marfecha` DATETIME NULL,
  `mar_in_out` VARCHAR(255) BINARY NULL,
  `marippc` VARCHAR(255) BINARY NULL,
  `marperid` BIGINT(10) NULL,
  `marreftarjeta` VARCHAR(255) BINARY NULL,
  `marestado` VARCHAR(255) BINARY NULL,
  `marhora` DATETIME NULL,
  `sede` VARCHAR(255) BINARY NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`zona`;
CREATE TABLE `eos`.`zona` (
  `idzona` DECIMAL(19, 0) NULL,
  `nombre` VARCHAR(150) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idciudad` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(19, 0) NULL
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `eos`.`zonaproductiva`;
CREATE TABLE `eos`.`zonaproductiva` (
  `idzonaproductiva` DECIMAL(24, 0) NULL,
  `grupo` VARCHAR(20) BINARY NULL,
  `nombre` VARCHAR(200) BINARY NULL,
  `numero` VARCHAR(20) BINARY NULL,
  `version` DECIMAL(19, 0) NULL,
  `idcompania` DECIMAL(24, 0) NULL
)
ENGINE = INNODB;



SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------
-- EOF

