DROP database biblioteca;
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE libro (
	isbn INT PRIMARY KEY,
    titulo VARCHAR(70)
);

create table ejemplar(
	cod_ejemplar smallint primary key auto_increment,
    edicion varchar(30) Not NULl,
    isbn INT NOT NULL,
    FOREIGN KEY (isbn ) REFERENCES libro
);

CREATE TABLE socio(
	cod_socio int PRIMARY KEY,
    nombre_completo VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    monto INT
);

CREATE TABLE prestamo (
	cod_ejemplar smallint,
    cod_socio INT,
    fecha_prestamos DATE NOT NULL,
    fecha_devolucion DATE not NULL,
    FOREIGN KEY (cod_socio)  REFERENCES socio,
    foreign key (cod_ejemplar)  REFERENCES ejemplar   
    
);
