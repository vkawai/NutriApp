DROP TABLE IF EXISTS `alimento`;
DROP TABLE IF EXISTS `grupo_alimento`;

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

.mode csv
.separator ";"
.import data/grupoalimento.csv grupo_alimento
.import data/alimento.csv alimento
