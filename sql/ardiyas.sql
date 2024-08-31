CREATE USER 'ardiyas'@'localhost' IDENTIFIED BY '1234';
SHOW GRANTS FOR 'ardiyas'@'localhost';
GRANT ALL PRIVILEGES ON * . * TO 'ardiyas'@'localhost';
FLUSH PRIVILEGES;
show databases;


create table races (
 id INT primary key auto_increment,
 name VARCHAR(50) not null,
 description VARCHAR(50),
 distance VARCHAR(50),
 slope VARCHAR(50),
 datetime DATETIME,
 price FLOAT,
 picture VARCHAR(50));
 
drop table races;

insert into races (name, description, distance, slope, datetime, price) values 
('Quebrantahuesos', 'Pirineos puros y duros', '200', '3.464', '2025-06-21 07:30', 60),
('Los 10.000 del Soplao', 'El infierno de Cantabria', '162', '3.330', '2024-09-14 07:30', 85),
('Larra Larrau', 'Sube los puertos donde entrenaba Indurain', '146', '3.780', '2025-07-5 07:00', 75),
('Mussara Donostia', 'Autentico rompepiernas vasco', '148', '2.840', '2025-04-20 08:00', 65),
('La Purito', 'Sufre los puertos andorranos', '312', '5.050', '2025-04-26 07:00', 90),
('La Indurain', 'Descubre los pirineos navarros', '312', '5.050', '2025-04-26 07:00', 90),
('Pontevedra 4 picos Road', 'Marcha relativamente nueva por Galicia', '120', '5.500', '2025-09-14 9:00', 60),
('La Titanica', 'Paisaje salvajes por las islas', '172', '3.452', '2025-02-18 08:00', 100);

select * from races;



CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL DEFAULT 'no-name',
  surname VARCHAR(50),
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(40) NOT NULL,
  role VARCHAR(50) DEFAULT 'user'
);
    
INSERT INTO users (username, password, role) VALUES ('jorge', SHA1('jorge'), 'admin');
INSERT INTO users (username, password, role) VALUES ('maria', SHA1('maria'), 'user');

SELECT * FROM users;

drop table users;



CREATE TABLE trainings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(50),
  datetime DATETIME,
  type VARCHAR(50) DEFAULT 'road',
  picture VARCHAR(50)
);

insert into trainings (name, description, datetime, type) values 
('Series explosivas', 'Sprints en llanos de 1 minuto', '2025-09-30 08:30', 'carretera'),
('Rodaje', 'Base aerobica zona 2', '2025-10-01 08:30', 'carretera'),
('Fuerza', 'Sprints en llanos de 1 minuto', '2025-10-05 08:30', 'btt'),
('Fondo', '3 horas rodando en zona 2-3', '2025-10-08 08:30', 'carretera'),
('Series subida', '4 subidas de 4 min con rec. de 1 min', '2025-10-15 08:30', 'btt'),
('Alta intesidad', '2 horas en zona 3-4', '2025-10-19 08:30', 'carretera'),
('Pre-carrera', '3 horas en zona 2 y 3 sprints de 30 seg', '2025-10-21 08:30', 'carretera'),
('Post-carrera', '2 horas en zona 2', '2025-10-24 08:30', 'btt'),
('Fuerza llano', '8 min en zona 4 con 1 min de rec.', '2025-10-29 08:30', 'btt');

select * from trainings;

drop table trainings;




CREATE TABLE bikepackings (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description VARCHAR(50),
datetime DATETIME,
price FLOAT,
picture VARCHAR(50)
);

insert into bikepackings (name, description, datetime, price) values 
('Montañas vacias', '680 kms y 12.910 mtrs positivos', '2025-09-30 08:00', 150),
('Transpirenaica', '1.035 kms y 21.050 mtrs positivos', '2025-07-05 08:00', 300),
('Camino de Santiago', '743 kms y 9.333 mtrs positivos', '2025-06-30 08:00', 120),
('Cami de Cavalls', '189 kms y 2.875 mtrs positivos', '2025-07-14 08:00', 50),
('Sendero de Sierra Morena', '600 kms y 10.000 mtrs positivos', '2025-05-30 08:00', 150),
('Altravesur', '1.322 kms y 28.552 mtrs positivos', '2025-06-21 08:00', 320),
('Basajaun', '800 kms y 13.437 mtrs positivos', '2025-07-12 08:00', 200);

select * from bikepackings;

drop table bikepackings;

ALTER DATABASE bicis CHARACTER SET utf8 COLLATE utf8_general_ci;

