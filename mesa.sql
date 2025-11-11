USE biblioteca;

CREATE TABLE mesa_de_salon (
	nro_mesa int,
    id_salon VARCHAR(30),
    color VARCHAR(10) NOT NULL,
    CANTIDAD_SILLAS smallint(2),
    PRIMARY KEY(nro_mesa, id_salon)
);