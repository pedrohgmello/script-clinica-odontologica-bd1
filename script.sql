CREATE DATABASE IF NOT EXISTS Clinica_Odontologica;
USE Clinica_Odontologica;

CREATE TABLE pacientes
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	nome_completo VARCHAR(100) NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	data_nascimento DATE DEFAULT NULL,
	telefone VARCHAR(15) DEFAULT NULL,
	email VARCHAR(100) DEFAULT NULL,
	endereco VARCHAR(100) DEFAULT NULL,
	historico_consultas VARCHAR(255) DEFAULT NULL,
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE,
	UNIQUE INDEX idx_cpf(cpf) USING BTREE,
	UNIQUE INDEX idx_email(email) USING BTREE
);

CREATE TABLE dentistas
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	nome_completo VARCHAR(100) NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	cro VARCHAR(50) NOT NULL,
	especialidade VARCHAR(50) DEFAULT NULL,
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE,
	UNIQUE INDEX idx_cro(cro) USING BTREE
);

CREATE TABLE procedimentos_odontologicos
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	descricao VARCHAR(255) DEFAULT NULL,
	duracao_media VARCHAR(100) DEFAULT NULL,
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE
);

CREATE TABLE consultas
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	paciente_id INT(0) NOT NULL,
	dentista_id INT(0) NOT NULL,
	data_consulta DATE NOT NULL,
	hora_consulta TIME NOT NULL,
	descricao_atendimento VARCHAR(100) NOT NULL,
	prescricao VARCHAR(100) DEFAULT NULL,
	status VARCHAR(20) DEFAULT 'agendado',
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE,
	INDEX fk_consultas_pacientes(paciente_id) USING BTREE,
	INDEX fk_consultas_dentistas(dentista_id) USING BTREE,
	CONSTRAINT fk_consultas_pacientes
		FOREIGN KEY(paciente_id) REFERENCES pacientes(id)
			ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_consultas_dentistas
		FOREIGN KEY(dentista_id) REFERENCES dentistas(id)
			ON DELETE RESTRICT ON UPDATE CASCADE,
	UNIQUE INDEX idx_unico_horario_dentista(dentista_id, data_consulta, hora_consulta) USING BTREE,
	UNIQUE INDEX idx_unico_horario_paciente(paciente_id, data_consulta, hora_consulta) USING BTREE
);

CREATE TABLE consultas_procedimentos
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	consulta_id INT(0) NOT NULL,
	procedimento_id INT(0) NOT NULL,
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE,
	INDEX fk_consproc_consulta(consulta_id) USING BTREE,
	INDEX fk_consproc_procedimento(procedimento_id) USING BTREE,
	CONSTRAINT fk_consproc_consulta
		FOREIGN KEY(consulta_id) REFERENCES consultas(id)
			ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_consproc_procedimento
		FOREIGN KEY(procedimento_id) REFERENCES procedimentos_odontologicos(id)
			ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE horarios_atendimento
(
	id INT(0) NOT NULL AUTO_INCREMENT,
	dentista_id INT(0) NOT NULL,
	dia_semana VARCHAR(20) NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
	data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP(),
	data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP()
		ON UPDATE CURRENT_TIMESTAMP(),
	PRIMARY KEY(id) USING BTREE,
	INDEX fk_horarios_dentistas(dentista_id) USING BTREE,
	CONSTRAINT fk_horarios_dentistas
		FOREIGN KEY(dentista_id) REFERENCES dentistas(id)
			ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pacientes (nome_completo, cpf, data_nascimento, telefone, email, endereco, historico_consultas) VALUES 
('William','11122233345','1995-10-19', '(24)87670000','will.p@.com','Nogueira', 'Limpeza Dentária'),
('Marcos','22233335345','1975-04-29', '(24)98470670','marc.p@.com','Nogueira', 'Canal'),
('José','99927233325','1974-03-05', '(24)44670990','jose.p@.com','Correas', 'Ortondotia'),
('Carol','21375476588','1993-10-21', '(24)87672129','carol.p@.com','Quitandinha', 'Endodontia'),
('Ana','67877733695','1970-11-20', '(24)83240000','ana.p@.com','Alto da Serra', 'Periodontia '),
('Cosme','11190033341','1969-06-17', '(24)87670000','cosme.p@.com','ALto da Serra', 'Dentística'),
('Messias','11128220945','1994-05-25', '(24)87675322','messi.p@.com','Bonfim', 'Implantodontia'),
('Carlos','00056699915','1960-01-10', '(24)876761123','carlos.p@.com','Bonfim', 'Harmonização Orofacial'),
('Vania','14567934100','1989-07-05', '(24)889670561','vania.p@.com','Correas', 'Estomatologia'),
('Isabela','09824233178','2000-07-09', '(24)87511060','isa.p@.com','Centro', 'Radiologia'),
('Marlan','09824233559','1967-07-09', '(24)87519833','mar.p@.com','Centro', 'Harmonização Orofacial');

INSERT INTO procedimentos_odontologicos (nome, descricao, duracao_media) VALUES 
('Limpeza (Profilaxia)', 'Remoção de placa bacteriana e tártaro', '30 - 60 minutos'),
('Restauração (Obturação)', 'Reparo de dentes danificados por cáries', '30 - 60 minutos'),
('Clareamento Dental', 'Aplicação de agentes clareadores', '60 - 90 minutos'),
('Tratamento de Canal','Remoção da polpa infectada', '90 - 120 minutos'),
('Extração de Dente', 'Remoção de um dente irrecuperável', '20 - 40 minutos'),
('Implante Dentário', 'Substituição da raiz por pino de titânio', '60 - 120 minutos'),
('Coroa Dentária', 'Cobertura para restaurar forma e força', '60 - 90 minutos'),
('Aplicação de Flúor', 'Fortalecimento do esmalte', '10 - 15 minutos'),
('Raspagem Periodontal', 'Limpeza profunda abaixo da gengiva', '60 - 90 minutos'),
('Aparelho Ortodôntico', 'Correção do alinhamento', '60 - 120 minutos');

INSERT INTO dentistas (nome_completo, cpf, cro, especialidade) VALUES
('Julio Cesar Silva', '12121212121', 'SP12345', 'Clínico Geral'),
('Nicolau Pereira Gomes', '17587984812', 'RJ54321', 'Ortodentia'),
('Thayane Senju Cruz', '19735678201', 'BA47345', 'Endodentista'),
('Claudia Unohana de Souza', '12765438921', 'PR12345', 'Periodontia'),
('Susana Ysane', '18429846721', 'ES12345', 'Implantodontia'),
('Drauzio Santos Rodrigues', '13538505932', 'AM12345', 'Odontopediatria'),
('Amélia Silva da Cruz', '12354367421', 'PR12345', 'Prótese Dentária'),
('Douglas Tesch Reis', '12765438921', 'RJ12398', 'Cirurgia Bucomaxilofacial'),
('Stanier Juno Sepulcro', '12765438921', 'SP13365', 'Odonto Estética'),
('Ana Clara Lima Reis', '12765438921', 'BA12795', 'Clinico Geral');

INSERT INTO horarios_atendimento (dentista_id, dia_semana, hora_inicio, hora_fim) VALUES 
(1, 'Segunda-feira', '09:00:00', '18:00:00'),
(2, 'Quarta-feira', '07:15:00', '10:00:00'),
(3, 'Sexta-feira', '14:30:00', '16:00:00'),
(4, 'Sábado', '08:00:00', '11:00:00'),
(5, 'Segunda-feira', '17:00:00', '18:00:00'),
(6, 'Segunda-feira', '11:00:00', '11:30:00'),
(7, 'Terça-Feira', '06:00:00', '16:00:00'),
(8, 'Quarta-Feira', '08:00:00', '17:00:00'),
(9, 'Quinta-Feira', '12:00:00', '21:00:00'),
(10, 'Sábado', '07:00:00', '17:00:00');

INSERT INTO consultas (paciente_id, dentista_id, data_consulta, hora_consulta, descricao_atendimento, prescricao, status) VALUES 
(1, 1, '2025-09-01', '15:15', 'Limpeza dentária', 'cloroxedina 100mg', 'agendado'),
(2, 6, '2025-09-10', '09:00', 'Canal', 'Clindamicina 300 mg', 'agendado'),
(3, 7, '2025-09-04', '14:00', 'Ortodontia', 'Reajuste de aparelho', 'agendado'),
(4, 3, '2025-09-05', '10:30', 'Endondotia', 'Ibuprofeno e Betametasona', 'agendado'),
(5, 4, '2025-09-01', '09:30', 'Periodontia', 'Amoxilina e Metronidazol', 'agendado'),
(6, 5, '2025-09-03', '10:00', 'Dentítica', 'Lentes de contato', 'agendado'),
(7, 8, '2025-09-05', '16:00', 'Implantodontia', 'Paracetamol 1g', 'agendado'),
(8, 9, '2025-09-10', '14:00', 'Harmonização', 'Cetorolaco 10mg', 'agendado'),
(9, 6, '2025-09-12', '14:30', 'Estomatologia', 'Amoxicilina', 'agendado'),
(10, 10, '2025-09-09', '10:30', 'Radiologia', 'Raio x intrabucal', 'disponivel');

INSERT INTO consultas_procedimentos (consulta_id, procedimento_id) VALUES 
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

UPDATE consultas SET status = 'realizada' WHERE id = 1;
UPDATE pacientes SET telefone = '000000000' WHERE cpf = '11122233345';
UPDATE consultas SET prescricao = 'Reavaliar medicação' WHERE status = 'atrasada';

DELETE FROM pacientes WHERE cpf = '09824233278';
DELETE FROM pacientes WHERE endereco = 'Bonfim';

CREATE OR REPLACE VIEW view_consulta_detalhada AS
SELECT 
	c.id AS consulta_id,
	p.nome_completo AS paciente,
	d.nome_completo AS dentista,
	c.data_consulta,
	po.nome AS procedimento,
	c.status
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id
JOIN dentistas d ON c.dentista_id = d.id
JOIN consultas_procedimentos cp ON c.id = cp.consulta_id 
JOIN procedimentos_odontologicos po ON cp.procedimento_id = po.id
ORDER BY c.data_consulta DESC;

SELECT * FROM view_consulta_detalhada;