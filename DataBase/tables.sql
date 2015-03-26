DROP TABLE IF EXISTS `alimento_refeicoes`;
DROP TABLE IF EXISTS `alimento_historico`;
DROP TABLE IF EXISTS `alimento`;
DROP TABLE IF EXISTS `grupo_alimento`;
DROP TABLE IF EXISTS `historico`;
DROP TABLE IF EXISTS `refeicoes`;

CREATE TABLE `grupo_alimento`(
    id_grupo INTEGER PRIMARY KEY NOT NULL,
    nome_grupo TEXT NOT NULL
);

CREATE TABLE `alimento`(
    id_alimento INTEGER PRIMARY KEY NOT NULL,
    id_categoria INTEGER REFERENCES grupo_alimento(id_grupo) NOT NULL,
    descricao TEXT,
    umidade FLOAT,
    energia FLOAT,
    proteina FLOAT,
    lipideos FLOAT,
    colesterol FLOAT,
    carboidrato FLOAT,
    fibra_alimentar FLOAT,
    cinzas FLOAT,
    calcio FLOAT,
    magnesio FLOAT,
    manganes FLOAT,
    fosforo FLOAT,
    ferro FLOAT,
    sodio FLOAT,
    potassio FLOAT,
    cobre FLOAT,
    zinco FLOAT,
    retinol FLOAT,
    tiamina FLOAT,
    riboflavina FLOAT,
    piridoxina FLOAT,
    niacina FLOAT,
    vitamina_c FLOAT
);

CREATE TABLE `refeicoes`(
	id_refeicao INTEGER PRIMARY KEY NOT NULL,
	nome TEXT NOT NULL
);

CREATE TABLE `alimento_refeicoes`(
	id_refeicao INTEGER NOT NULL,
	id_alimento INTEGER NOT NULL,
	quantidade FLOAT NOT NULL,
	PRIMARY KEY (id_refeicao, id_alimento),
	FOREIGN KEY (id_refeicao) REFERENCES refeicoes(id_refeicoes),
	FOREIGN KEY (id_alimento) REFERENCES alimento(id_alimento)
);

CREATE TABLE `historico`(
	id_historico INTEGER PRIMARY KEY NOT NULL,
	data TEXT NOT NULL
);

CREATE TABLE `alimento_historico`(
	id_historico INTEGER NOT NULL,
	id_alimento INTEGER NOT NULL,
    id_tiporefeicao INTEGER NOT NULL,
	quantidade FLOAT,
	PRIMARY KEY (id_historico, id_alimento),
	FOREIGN KEY (id_historico) REFERENCES historico(id_historico),
	FOREIGN KEY (id_alimento) REFERENCES alimento(id_alimento),
    FOREIGN KEY (id_tiporefeicao) REFERENCES tipo_refeicao(id_tiporefeicao)
);

CREATE TABLE `tipo_refeicao`(
    id_tiporefeicao INTEGER PRIMARY KEY NOT NULL,
    descricao TEXT NOT NULL
);


.mode csv
.separator ";"
.import data/grupoalimento.csv grupo_alimento
.import data/alimento.csv alimento
.import data/tiporefeicao.csv tipo_refeicao
