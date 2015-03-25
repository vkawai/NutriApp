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
	quantidade FLOAT NOT NULL DEFAULT=1,
	PRIMARY KEY (id_refeicao, id_alimento),
	FOREIGN KEY (id_refeicao, id_alimento) REFERENCES (refeicoes, alimento)
);

CREATE TABLE `historico`(
	id_historico INTEGER PRIMARY KEY NOT NULL,
	data TEXT NOT NULL
);

CREATE TABLE `alimento_historico`(
	id_historico INTEGER NOT NULL,
	id_alimento INTEGER NOT NULL,
	quantidade FLOAT DEFAULT=1,
	PRIMARY KEY (id_historico, id_alimento),
	FOREIGN KEY (id_historico, id_alimento) REFERENCES (historico, alimento)	
);


.mode csv
.separator ";"
.import data/grupoalimento.csv grupo_alimento
.import data/alimento.csv alimento
