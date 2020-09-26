
DROP database if exists access_inspection;

# crear base de datos
CREATE DATABASE IF NOT EXISTS access_inspection; 

# usar base de datos
USE access_inspection;
#USE b2cktote1e918dx6vjfa;
DROP TABLE IF exists administradores;
CREATE TABLE IF NOT EXISTS administradores(
    idAdmin SMALLINT AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    correo varchar(250) UNIQUE NOT NULL,
	pass BLOB NOT NULL,
    telefono varchar(30) NOT NULL,
    rol VARCHAR(15) NOT NULL,
    CONSTRAINT PK_administradores PRIMARY KEY (idAdmin)
) ENGINE=INNODB;

CREATE TABLE token(
	idToken varchar(350) PRIMARY KEY,
    fechaLogin Date,
    hora time,
    expTime LONG,
    idAdministrador SMALLINT,
    CONSTRAINT FK_adminLogin FOREIGN KEY (idAdministrador) REFERENCES administradores (idAdmin) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE  IF exists empleados;
CREATE TABLE IF NOT EXISTS empleados(
    numDoc VARCHAR(20),
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    tipoDoc VARCHAR(20) NOT NULL,
    fechaNac DATE NOT NULL,
    rh VARCHAR(5) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL,
    ntelefono VARCHAR(20) NOT NULL,
    cargo VARCHAR(20) NOT NULL,
    foto LONGBLOB  NOT NULL,
    creacion date ,
    idAdminCreater SMALLINT NOT NULL,
    
    CONSTRAINT PK_empleados PRIMARY KEY (numDoc),
    CONSTRAINT FK_adminCreater FOREIGN KEY (idAdminCreater) REFERENCES administradores (idAdmin)
)ENGINE=INNODB;
/*
HUella  y pin juntos 

*/

DROP TABLE IF EXISTS HuellaCode;
CREATE TABLE IF NOT EXISTS HuellaCode(
	idHuella INT  AUTO_INCREMENT,
	huella blob NOT NULL,
    codigoPin int,
    numDocEmp VARCHAR(20) NOT NULL,
    CONSTRAINT PK_hc PRIMARY KEY (idHuella),
    CONSTRAINT FK_person FOREIGN KEY (numDocEmp ) REFERENCES empleados(numDoc) ON UPDATE CASCADE ON DELETE CASCADE 
);

DROP TABLE IF EXISTS reporte_quincenal;
CREATE TABLE IF NOT EXISTS reporte_quincenal(
	id_rp_quincenal INT AUTO_INCREMENT,
    fecha_report_quince_inicio DATE UNIQUE NOT NULL,
    fecha_report_quince_fin DATE UNIQUE NOT NULL,
    hora_report_quince TIME NOT NULL,
    CONSTRAINT KP_RP_quincenal PRIMARY KEY (id_rp_quincenal)
);

DROP TABLE  IF EXISTS reporte_diario;
CREATE TABLE IF NOT EXISTS reporte_diario (
	id_rp_diario INT AUTO_INCREMENT,
    fecha_reporte DATE UNIQUE NOT NULL,
    hora_reporte TIME NOT NULL,
    id_rp_quincenal_kf INT,
    CONSTRAINT KP_RP_diario  PRIMARY KEY (id_rp_diario),
    CONSTRAINT KF_RP_diario_RP_quincenal FOREIGN KEY (id_rp_quincenal_kf) REFERENCES reporte_quincenal(id_rp_quincenal)ON UPDATE CASCADE ON DELETE CASCADE
);

#DROP TABLE empleados, asistecia_entrada, asistencia_salida;

DROP TABLE  IF exists asistencia_entrada;
CREATE TABLE IF NOT EXISTS asistencia_entrada (
	id_entrada INT AUTO_INCREMENT,
	hora_entrada TIME NOT NULL,
    fecha_e_fk DATE NOT NULL,
	documento VARCHAR(20) NOT NULL,
	CONSTRAINT KP_asistencia_entrada PRIMARY KEY (id_entrada) ,
	CONSTRAINT FK_entrada_empleado FOREIGN KEY (documento) REFERENCES empleados(numDoc)ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT Fk_rp_e_fecha FOREIGN KEY (fecha_e_fk) REFERENCES reporte_diario (fecha_reporte) ON UPDATE CASCADE ON DELETE CASCADE
);
#INSERT INTO asistencia_entrada VALUES (1,"2021-05-20 18:57:44","16140219 7246");
#delete from asistencia_entrada where id_entrada=1;
DROP TABLE  IF exists asistencia_salida;
CREATE TABLE IF NOT EXISTS asistencia_salida (
	id_salida INT AUTO_INCREMENT,
	hora_salida TIME,
    fecha_s_fk DATE,
	documento_fk VARCHAR(20) NOT NULL,
	CONSTRAINT PK_asistencia_salida  PRIMARY KEY (id_salida),
	CONSTRAINT FK_CC_empleado FOREIGN KEY (documento_fk) REFERENCES empleados(numDoc)ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Fk_rp_s_fecha FOREIGN KEY (fecha_s_fk) REFERENCES reporte_diario (fecha_reporte) ON UPDATE CASCADE ON DELETE CASCADE
);






