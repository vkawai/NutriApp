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

-(bool)insertNewAlimento:(Alimento *)obj{
    int identifier = [[em nextIdForTable:@"alimento" withIdName:@"id_alimento"] intValue];
    return [em changeData:[NSString stringWithFormat:@"INSERT INTO alimento VALUES (%d, %d, %@, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f)",identifier, obj.id_categoria, obj.descricao, obj.umidade, obj.energia, obj.proteina, obj.lipideos, obj.colesterol, obj.carboidrato, obj.fibra_alimentar, obj.cinzas, obj.calcio, obj.magnesio, obj.manganes, obj.fosforo, obj.ferro, obj.sodio, obj.potassio, obj.cobre, obj.zinco, obj.retinol, obj.tiamina, obj.riboflavina, obj.piridoxina, obj.niacina, obj.vitamina_c]];

}   

-(instancetype)init{
    self = [super init];

    blk = ^id(sqlite3_stmt *stmt){
        Alimento *obj = [[Alimento alloc] init];
        obj.id_alimento = sqlite3_column_int(stmt, 0);
        obj.id_categoria = sqlite3_column_int(stmt, 1);
        obj.descricao = [NSString stringWithCString:(char*)sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding];
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

-(NSMutableArray*)getAllData{
    NSMutableArray *resultSet = [[NSMutableArray alloc]initWithArray:[em getData:@"SELECT * FROM alimento" andBlk:blk]];
    [self getGrupoAlimentosForGivenSet:resultSet];
    return resultSet;
}

-(NSMutableArray*)getAlimentosFromGivenHistory:(int)identifier{
    NSMutableArray *resultSet = [[NSMutableArray alloc]initWithArray:[em getData:[NSString stringWithFormat:@"SELECT * FROM alimento INNER JOIN alimento_historico ON alimento.id_alimento=alimento_historico.id_alimento WHERE alimento_historico.id_historico=%d",identifier] andBlk:blk]];
    [self getGrupoAlimentosForGivenSet:resultSet];
    return resultSet;
}

-(NSMutableArray*)getAlimentosFromGivenMeal:(int)identifier{
    NSMutableArray *resultSet = [[NSMutableArray alloc]initWithArray:[em getData:[NSString stringWithFormat:@"SELECT * FROM alimento INNER JOIN alimento_refeicoes ON alimento.id_alimento=alimento_refeicoes.id_alimento WHERE alimento_refeicoes.id_refeicao=%d",identifier] andBlk:blk]];
    [self getGrupoAlimentosForGivenSet:resultSet];
    return resultSet;
}

-(void)getGrupoAlimentosForGivenSet:(NSMutableArray *)set{
    for(int i = 0; i < [set count]; i++){
        Alimento *obj = [set objectAtIndex:i];
        [obj setCategoria:[[em getData:[NSString stringWithFormat:@"SELECT nome_grupo FROM grupo_alimento WHERE id_grupo=%d",obj.id_categoria] andBlk:^id(sqlite3_stmt *stmt) {
            return [NSString stringWithCString:(char *)sqlite3_column_text(stmt, 0)  encoding:NSUTF8StringEncoding];
        }] firstObject]];
        [set replaceObjectAtIndex:i withObject:obj];
    }
}

@end
