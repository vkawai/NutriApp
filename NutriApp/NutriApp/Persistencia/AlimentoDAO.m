//
//  AlimentoDAO.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "AlimentoDAO.h"
@implementation AlimentoDAO

-(NSArray*)getAllData{
    EntityManager *em = [EntityManager sharedInstance];
    
    NSArray *resultSet = [em getData:@"SELECT * FROM alimento" andBlk:^id(sqlite3_stmt *stmt) {
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
    }];
    
    return resultSet;
}

@end
