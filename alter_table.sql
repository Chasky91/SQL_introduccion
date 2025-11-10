USE biblioteca; 
ALTER TABLE libro ADD COLUMN autor VARChAR(70) NOT NULL;
alter table libro drop column titulo;
ALTER TABLE socio ADD COLUMN email VARCHAR(30) NOT NULL;

ALTER TABLE socio MODIFY COLUMN cod_socio int AUTO_INCREMENT;
