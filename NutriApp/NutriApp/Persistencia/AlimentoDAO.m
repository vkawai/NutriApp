//
//  AlimentoDAO.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "AlimentoDAO.h"
@implementation AlimentoDAO{
    id (^blk)(sqlite3_stmt*);
    EntityManager *em;
}

static AlimentoDAO *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];

    blk = ^id(sqlite3_stmt *stmt){
        Alimento *obj = [[Alimento alloc] init];
        obj.id_alimento = sqlite3_column_int(stmt, 0);
        obj.id_categoria = sqlite3_column_int(stmt, 1);
        obj.descricao = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 2)];
        obj.umidade = sqlite3_column_double(stmt, 3);
        obj.energia = sqlite3_column_double(stmt, 4);
        obj.proteina = sqlite3_column_double(stmt, 5);
        obj.lipideos = sqlite3_column_double(stmt, 6);
        obj.colesterol = sqlite3_column_double(stmt, 7);
        obj.carboidrato = sqlite3_column_double(stmt, 8);
        obj.fibra_alimentar = sqlite3_column_double(stmt, 9);
        obj.cinzas = sqlite3_column_double(stmt, 10);
        obj.calcio = sqlite3_column_double(stmt, 11);
        obj.magnesio = sqlite3_column_double(stmt, 12);
        obj.manganes = sqlite3_column_double(stmt, 13);
        obj.fosforo = sqlite3_column_double(stmt, 14);
        obj.ferro = sqlite3_column_double(stmt, 15);
        obj.sodio = sqlite3_column_double(stmt, 16);
        obj.potassio = sqlite3_column_double(stmt, 17);
        obj.cobre = sqlite3_column_double(stmt, 18);
        obj.zinco = sqlite3_column_double(stmt, 19);
        obj.retinol = sqlite3_column_double(stmt, 20);
        obj.tiamina = sqlite3_column_double(stmt, 21);
        obj.riboflavina = sqlite3_column_double(stmt, 22);
        obj.piridoxina = sqlite3_column_double(stmt, 23);
        obj.niacina = sqlite3_column_double(stmt, 24);
        obj.vitamina_c = sqlite3_column_double(stmt, 25);

        return obj;
    };

    em = [EntityManager sharedInstance];

    return self;
}

-(bool)query:(NSString *)query{
    return [em changeData:query];
}

-(NSArray*)getAllData{
    NSArray *resultSet = [em getData:@"SELECT * FROM alimento" andBlk:blk];
    return resultSet;
}

-(NSArray*)getAlimentosFromGivenHistory:(int)identifier{
    NSArray *resultSet = [em getData:[NSString stringWithFormat:@"SELECT * FROM alimento INNER JOIN alimento_historico ON alimento.id_alimento=alimento_historico.id_alimento WHERE alimento_historico.id_historico=%d",identifier] andBlk:blk];
    return resultSet;
}

-(NSArray*)getAlimentosFromGivenMeal:(int)identifier{

    NSArray *resultSet = [em getData:[NSString stringWithFormat:@"SELECT * FROM alimento INNER JOIN alimento_refeicoes ON alimento.id_alimento=alimento_refeicoes.id_alimento WHERE alimento_refeicoes.id_refeicao=%d",identifier] andBlk:blk];
    return resultSet;
}

@end
