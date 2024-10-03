CREATE TABLE onibus (
  id int NOT NULL AUTO_INCREMENT, 					#ID único para cada ônibus, usado como chave primária
  placa varchar(10) COLLATE utf8_bin NOT NULL,		#Placa do ônibus, com tamanho máximo de 10 caracteres >varchar (10) <
  `quantidade_assento`INT NOT NULL,						#Quantidade de assentos no ônibus não pode ser vazia > not null <
  ativo tinyint DEFAULT '1',							#Indica se o ônibus está ativo (1 para sim, 0 para não)
  PRIMARY KEY (id),									#Define o campo id como chave primária > primary key <
  UNIQUE KEY placa_UNIQUE (placa)					#Garante que a placa do ônibus seja única no sistema
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


CREATE TABLE assento (
  id int NOT NULL AUTO_INCREMENT,				#Identificador único para cada assento, sobe o id automaticamente > auto_increment <
  id_onibus int NOT NULL,						#Referência ao ônibus a que o assento pertence
  numero_assento int NOT NULL,				#Número do assento dentro do ônibus
  ativo tinyint DEFAULT '1',					#Indica se o assento está ativo ou não (1 = ativo, 0 = inativo)
  PRIMARY KEY (id),							#Define o campo id como chave primária
  UNIQUE KEY unico_assento_onibus (id_onibus, numero_assento), 							#Garante que o número do assento seja único por ônibus
  CONSTRAINT fk_assento_onibus FOREIGN KEY (id_onibus) REFERENCES onibus (id) 			#Chave estrangeira para a tabela onibus
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


CREATE TABLE viagem (
  id int NOT NULL AUTO_INCREMENT,
  id_onibus int NOT NULL,
  cidade_origem varchar(100) COLLATE utf8_bin NOT NULL,
  cidade_destino varchar(100) COLLATE utf8_bin NOT NULL,
  data_hora_saida DATETIME NOT NULL,					#DATETIME combina a hora e a data, não sendo necessário criar campos apenas com data e apenas com hora
  data_hora_prevista_chegada DATETIME NOT NULL, 		
  ativo tinyint DEFAULT '1',
  PRIMARY KEY (id),
  KEY fk_viagem_onibus_idx (id_onibus),
  CONSTRAINT fk_viagem_onibus FOREIGN KEY (id_onibus) REFERENCES onibus (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


CREATE TABLE passageiro (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(150) COLLATE utf8_bin NOT NULL,
  sexo enum('M', 'F') NOT NULL, 					#Alterado para apenas ser possível selecionar masculino ou feminino
  email varchar(150) COLLATE utf8_bin NOT NULL,
  cpf varchar(14) COLLATE utf8_bin NOT NULL,
  celular varchar(15) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email_UNIQUE (email),
  UNIQUE KEY cpf_UNIQUE (cpf)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

CREATE TABLE passagem (
  id int NOT NULL AUTO_INCREMENT,
  id_viagem int NOT NULL,
  id_assento int NOT NULL,
  id_passageiro int NOT NULL,
  classe enum('economica', 'executiva') NOT NULL,  			#Usuário pode selecionar se quer uma passagem de classe economica ou executiva
  data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_passagem_viagem FOREIGN KEY (id_viagem) REFERENCES viagem (id),
  CONSTRAINT fk_passagem_assento FOREIGN KEY (id_assento) REFERENCES assento (id),
  CONSTRAINT fk_passagem_passageiro FOREIGN KEY (id_passageiro) REFERENCES passageiro (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

CREATE TABLE usuario (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(150) COLLATE utf8_bin NOT NULL,
  email varchar(150) COLLATE utf8_bin NOT NULL,
  senha varchar(10) COLLATE utf8_bin NOT NULL,
  nivel_acesso enum('admin', 'usuario') NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email_UNIQUE (email)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;