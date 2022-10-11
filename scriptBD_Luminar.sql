CREATE DATABASE Luminar;
USE Luminar;

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY auto_increment,
    nome VARCHAR(45),
    nome_fantasia VARCHAR(45),
    cnpj VARCHAR(14),
    responsavel VARCHAR(45),
    telefone VARCHAR(11),
    email VARCHAR(45),
    senha VARCHAR(45)
);

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY auto_increment,
    logradouro VARCHAR(45),
    numero INT,
    bairro VARCHAR(45),
    complemento VARCHAR(45),
    cep VARCHAR(8),
    cidade VARCHAR(20),
    estado VARCHAR(25),
    fkEmpresa INT, FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE funcionario(
	idFuncionario INT auto_increment,
	cpf VARCHAR (11),
	nome VARCHAR (45),
	usuario VARCHAR (45),
	senha VARCHAR (45),
	setor VARCHAR (45),
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	PRIMARY KEY (idFuncionario, fkEmpresa)
); 

CREATE TABLE ambiente(
	idAmbiente INT PRIMARY KEY auto_increment, 
	metros_quadrados INT,
	qtd_sensor INT,
	fkFuncionario INT, 
	FOREIGN KEY (fkFuncionario) REFERENCES funcionario (idFuncionario)
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY auto_increment,
	nome_sensor VARCHAR (45),
	fkAmbiente INT,
	FOREIGN KEY (fkAmbiente) REFERENCES ambiente (idAmbiente)
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
(NULL, 'C6', 'Banco C6 SA', '31872495000172', 'Joao Victor', '11912345678', 'joao@c6bank.com', md5('c61234')),
(NULL, 'Safra', 'Banco Safra SA', '58160789000128', 'Paulo Silva', '11922345678','paulo@safra.com', md5('safra1234')),
(NULL, 'SPtech', 'Faculdade de tecnologia bandeirantes', '07165496000100', 'Alessandro Rodrigues', '1135894043', 'alessandro@sptech.school', md5('#Gf1234'));

INSERT INTO endereco values
(null, 'Rua Haddock Lobo', 595,'Cerqueira Cesar', '', '01414001', 'São Paulo', 'SP', 3),
(null, 'Av. Nove de Julho', 3186, 'Jardim Paulista', '', '01406000', 'São Paulo', 'SP', 1),
(null, 'Av. Paulista', 2100, 'Bela Vista', '', '01406000', 'São Paulo', 'SP', 2);

INSERT INTO funcionario VALUES
(null, '12345678912', 'Hariel Santos', 'hariel@c6bank.com', md5('hariel1234'), 'TI', 1),
(null, '12345678910', 'Larissa', 'larissa@safra.com', md5('larissa1234'), 'RH', 2),
(null, '12345678920', 'Paulo', 'paulo@sptech.school', md5('paulo1234'), 'TI', 3);

