create DATABASE Luminar;
USE Luminar;

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY auto_increment,
    nome VARCHAR(45),
    nome_fantasia VARCHAR(45),
    cnpj VARCHAR(14),
    responsavel VARCHAR(45),
    telefone VARCHAR(11)
);

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY auto_increment,
    logradouro VARCHAR(45),
    numero INT,
    complemento VARCHAR(45),
    cep char(8),
    cidade VARCHAR(20),
    uf char(2),
    fkEmpresa INT, FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE usuario(
	idusuario INT auto_increment,
	cpf VARCHAR (11),
	nome VARCHAR (45),
	login VARCHAR (45),
	senha VARCHAR (45),
	setor VARCHAR (45),
    tipo varchar(20),
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	PRIMARY KEY (idusuario, fkEmpresa)
); 
alter table usuario add constraint chk_tipo check(tipo in('admin', 'func'));


CREATE TABLE local(
	idlocal INT PRIMARY KEY auto_increment, 
	metros_quadrados INT,
	andar int
);
Create table usuario_local(
fk_usuario int, foreign key (fk_usuario) references usuario(idusuario),
fk_local int, foreign key (fk_local) references local(idlocal),
fk_empresa int,foreign key (fk_empresa) references usuario(idusuario),
primary key(fk_usuario,fk_local,fk_empresa)
 );

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY auto_increment,
	nome_sensor VARCHAR (45),
	fklocal_sensor INT,
	FOREIGN KEY (fklocal_sensor) REFERENCES local(idlocal)
);

CREATE TABLE registro(
	idRegistro INT auto_increment,
    valor_luminosidade DECIMAL(4,2),
    data_hora DATETIME,
    fkSensor INT, FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    PRIMARY KEY (idRegistro, fkSensor)
);

-- INSERTS
INSERT INTO empresa values
(NULL, 'C6', 'Banco C6 SA', '31872495000172', 'Joao Victor', '11912345678'),
(NULL, 'Safra', 'Banco Safra SA', '58160789000128', 'Paulo Silva', '11922345678'),
(NULL, 'SPtech', 'Faculdade de tecnologia bandeirantes', '07165496000100', 'Alessandro Rodrigues', '1135894043');

INSERT INTO endereco values
(null, 'Rua Haddock Lobo', 595,'bloco 3', 01414001, 'São Paulo', 'SP', 3),
(null, 'Av. Nove de Julho', 3186, 'bloco 4',  01406000, 'São Paulo', 'SP', 1),
(null, 'Av. Paulista', 2100, 'bloco 1', 01406000, 'São Paulo', 'SP', 2);

INSERT INTO usuario VALUES
(null, '12345678912', 'Hariel Santos', 'hariel@c6bank.com', md5('hariel1234'), 'TI','admin', 1),
(null, '12345678910', 'Larissa', 'larissa@safra.com', md5('larissa1234'), 'RH','admin', 2),
(null, '12345678920', 'Paulo', 'paulo@sptech.school', md5('paulo1234'), 'TI','func', 3);


 INSERT INTO local VALUES
-- id, metros_quadrados, qntSensor, fkFuncionário
(null, 10, 2 ),
(null, 20, 4),
(null, 8, 3);
insert into usuario_local value
(1,1,2),
(2,1,1),
(1,2,2),
(3,2,2),
(3,1,1);

INSERT INTO sensor VALUES
-- id, nomeSensor, fkAmbiente
(null, 'qa5-7', 1),
(null, 'aaa-3', 2),
(null, 'cdk-3', 3);

INSERT INTO registro VALUES 
-- id, valorLuminosidade, data_hora, fkSensor
(null, 450.7, '2022-10-02 12:00:00', 1),
(null, 330.5, '2022-10-02 12:30:00', 2),
(null, 85.0, '2022-10-02 13:00:00', 3);
select  * from local;
select * from usuario;
select * from usuario_local;
select * from registro;
select * from endereco;
select * from sensor;
select * from registro;
select * from empresa;

select * from local;

select e.nome,f.nome,f.setor from  empresa as e join usuario as f on idempresa= fkEmpresa;
select l.idlocal from local as l join empresa  on idEmpresa = idlocal join usuario on  idEmpresa = fkEmpresa WHERE empresa.nome = 'c6';
select * from registro join sensor on idsensor = fkSensor;
select valor_luminosidade from registro join sensor on idsensor = fkSensor;
select nome_sensor from registro join sensor on idsensor = fkSensor;
select max(valor_luminosidade) from registro;
select min(valor_luminosidade) from registro;
select count(valor_luminosidade < 20) from registro;
-- select nome_sensor from  sensor join local on  fkSensor = idlocal join usuario_local on fk_usuario = idusuario join usuario on fkEmpresa = idEmpresa ;
-- select nome_sensor from  sensor join local on  fklocal_sensor = idlocal join usuario_local on fk_local = idlocal join usuario on idusuario = fk_usuario ;