CREATE DATABASE Luminar;
-- DROP DATABASE Luminar;
USE Luminar;

-- CRIANDO AS TABELAS;
CREATE TABLE empresa(
	idempresa INT PRIMARY KEY auto_increment,
    nome VARCHAR(45),
    cnpj VARCHAR(15),
    telefone VARCHAR(13)
);

CREATE TABLE endereco(
	idendereco INT PRIMARY KEY auto_increment,
    numero INT,
    cep char(9),
    fkempresa INT, FOREIGN KEY (fkempresa) REFERENCES Empresa(idempresa)
);

CREATE TABLE usuario(
	idusuario INT auto_increment,
	nome VARCHAR (45),
	email VARCHAR (45),
	senha VARCHAR (45),
    tipo varchar(20),
	fkempresa INT,
	FOREIGN KEY (fkempresa) REFERENCES empresa(idempresa),
	PRIMARY KEY (idusuario, fkEmpresa)
); 

ALTER TABLE usuario ADD CONSTRAINT chk_tipo CHECK
	(tipo in ('admin', 'func'));

-- esses selects são apenas para verificar se a api gravou os dados corretamente
SELECT * FROM usuario;
SELECT * FROM empresa;
SELECT * FROM endereco;

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY auto_increment,
	nome_sensor VARCHAR (45)

);

CREATE TABLE local(
id_acesso int auto_increment,
nome_sala varchar(20),
metros_quadrados int,

fk_usuario int, foreign key (fk_usuario) references usuario(idusuario),
fk_sensor int, foreign key (fk_sensor) references sensor(idsensor),

primary key(id_acesso,fk_usuario,fk_sensor)
 );


CREATE TABLE registro(
	idRegistro INT auto_increment,
    luminosidade1 DECIMAL(10,2),
    luminosidade2 DECIMAL(10,2),
    luminosidade3 DECIMAL(10,2),
    luminosidade4 DECIMAL(10,2),
    data_hora DATETIME,
    fkSensor INT, FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    PRIMARY KEY (idRegistro, fkSensor)
);
-- criação das tabelas nota e contato 
create table nota(
idNota int primary key auto_increment,
nota varchar(45)
);

create table contato(
idContato int primary key auto_increment,
contato char(11),
email varchar (45),
nome varchar(45),
descricao text(100)
);

-- INSERINDO DADOS NAS TABELAS
INSERT INTO empresa values
(NULL, 'Banco C6 SA', '31872495000172', '11912345678'),
(NULL, 'Banco Safra SA', '58160789000128', '11922345678'),
(NULL, 'Faculdade de tecnologia bandeirantes', '07165496000100', '1135894043'),
(NULL, 'atma ltda', '31341560172', '11912345678'),
(NULL, 'rossi center', '581546590128', '11922345678');

INSERT INTO endereco values
(null, 595, 01414001, 3),
(null, 3186, 01406000, 1),
(null, 2100, 01406000, 2);

INSERT INTO usuario VALUES

(null, 'Hariel Santos', 'hariel@c6bank.com', 'hariel','admin', 1),
(null, 'Larissa', 'larissa@safra.com', 'larissa', 'admin', 2),
(null, 'Paulo', 'paulo@sptech.school', 'paulo','func', 3),
(null, 'roger', 'roger@sptech.school', 'roger','func', 3),
(null, 'marcos', 'marcos@c6.school', 'marcos','func', 1);

INSERT INTO sensor VALUES
-- id, nomeSensor, fkAmbiente
(null, 'qa5-7'),
(null, 'aaa-3'),
(null, 'cdk-3'),
(null, 'qaa-7'),
(null, 'lm-3'),
(null, 'ldr-3'),
(null, 'xpto-7'),
(null, 'asd-3'),
(null, 'sdd-3'),
(null, 'qas-7'),
(null, 'try-3'),
(null, '564-3'),
(null, 'qwe-7'),
(null, 'ksj-3'),
(null, 'ak-3'),
(null, 'qa5-123');
 
INSERT INTO local VALUES
(null,'sala1',9,1,1),
(null,'sala2',11,1,2),
(null,'sala3',12,1,3),
(null,'sala4',8,3,7),
(null,'sala5',6,2,4),
(null,'sala6',8,2,3),
(null,'sala7',9,2,6),
(null,'sala8',10,3,6),
(null,'sala9',11,4,6),
(null,'sala1',25,1,16);


INSERT INTO registro VALUES 
-- id, valorLuminosidade, data_hora, fkSensor
(null, 450.7, 500.6, 500.6, 600.6, '2022-10-02 12:00:00', 1),
(null, 330.5, 550.6, 500.6, 600.6, '2022-10-02 12:30:00', 2),
(null, 85.0, 550.6, 500.6, 300.6, '2022-10-02 13:54:00', 4),
(null,666.7, 500.6, 500.6, 300.6, '2022-10-02 12:50:00', 5),
(null, 3050.5, 500.6, 500.6, 300.6, '2022-10-02 12:40:00', 7),
(null, 54.0, 500.6, 500.6, 400.6, '2022-10-02 13:02:00', 3),
(null, 455.7, 500.6, 700.6, 500.6, '2022-10-02 13:08:00', 1),
(null, 555.5, 500.6, 600.6, 600.6, '2022-10-02 11:30:00', 2),
(null, 750.0, 500.6, 500.6, 500.6, '2022-10-02 03:20:00', 3),
(null, 547.7, 500.6, 500.6, 500.6, '2022-10-02 16:00:00', 1),
(null, 86.5, 500.6, 500.6, 500.6, '2022-10-02 19:30:00', 3),
(null, 66.0, 500.6, 500.6, 500.6, '2022-10-02 17:00:00', 3);

SELECT * FROM  empresa;
SELECT * FROM  endereco;
SELECT * FROM  usuario;
SELECT * FROM  sensor;
SELECT * FROM  local;
SELECT * FROM  registro;
SELECT * FROM nota;
SELECT * FROM contato;

select * from empresa join usuario on fkempresa = idempresa;
-- todas empresa com usuario cadastrados

select * from empresa left join usuario on fkempresa = idempresa;
-- empresas sem usuarios

select * from empresa  left join usuario on fkempresa = idempresa left join  local on idusuario = fk_usuario;
-- empresas sem usuarios

select e.nome, f.nome,f.setor from  empresa as e join usuario as f on idempresa= fkEmpresa where idusuario = 2;
-- select dos dados texto

select l.nome_sala from empresa as e join
 usuario on fkempresa = e.idempresa join
 local  as l on l.fk_usuario = idusuario where e.nome = 'safra';
 -- salas da empresa
 
 select l.nome_sala from empresa as e join
 usuario on fkempresa = e.idempresa join
 local  as l on l.fk_usuario = idusuario where e.nome = 'sptech' and usuario.nome = 'roger';
 -- sala que o usuario tem acesso
 
select nome_sensor from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor where nome_sala = 'sala1';
-- quais sensores tem na sala

select luminosidade1 from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor
 where nome_sala ='sala1'  ;
 -- dados gerados nos graficos

select * from empresa join 
usuario on idempresa = fkempresa join local on fk_usuario = idusuario join sensor on fk_sensor = idsensor;
-- aqui repete pois mostra qtn sensores por causa da composta
select local.* from empresa join 
usuario on idempresa = fkempresa join local on fk_usuario = idusuario join sensor on idsensor = fk_sensor;
-- ordenados pelo idusuario


-- select luminosidade1 from registro r
 -- join sensor s on s.idsensor = r.fkSensor
-- join local l on l.idlocal = s.fklocal_sensor 
-- join usuario_local u on u.fk_local = l.idlocal ;


select nome_sensor from registro join sensor on idsensor = fkSensor;
-- todos sensores no banco
select max(luminosidade2) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor
 where nome_sala ='sala1' ;
 -- kpi luminosidade maxima
 
 
select min(luminosidade1) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor
 where nome_sala ='sala1' ;
 -- kpi luminosidade minima
 
 select (luminosidade2) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor
 where nome_sala ='sala1' ;
 -- kpi luminosidade maxima
 
  select (luminosidade3) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor where nome_sala = 'sala1' and luminosidade3
order by data_hora desc limit 1 ;
-- kpi de ultima luminosidade registrada na sala

 select round(avg(luminosidade2)) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor where nome_sala = 'sala1';
-- media de luminosidade no local

 select count(luminosidade1) from empresa join 
usuario on idempresa = fkempresa join 
local on fk_usuario = idusuario join 
sensor on fk_sensor = idsensor join registro on fksensor = idsensor where nome_sala = 'sala1' and luminosidade1 > 750 and luminosidade1 < 500;
-- parametro para contar a quantidade de urgencias