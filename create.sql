CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE libro ( 
	isbn INT PRIMARY KEY,  
    autor VARCHAR(70) NOT NULL,   
    titulo VARCHAR(70) 
);

CREATE TABLE ejemplar(
	cod_ejemplar smallint primary key auto_increment,
    edicion varchar(30) Not NULl,
    isbn INT NOT NULL,
    FOREIGN KEY (isbn ) REFERENCES libro(isbn)
);

CREATE TABLE socio(
	cod_socio INT PRIMARY KEY,
    nombre_completo VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    monto INT
);

CREATE TABLE prestado (
	id_cod_ejemplar smallint,
    id_cod_socio INT,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
	PRIMARY KEY (id_cod_ejemplar,id_cod_socio),
    FOREIGN KEY (id_cod_socio)  REFERENCES socio(cod_socio),
    foreign key (id_cod_ejemplar)  REFERENCES ejemplar(cod_ejemplar)    
);
