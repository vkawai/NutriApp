//
//  HistoricoDAO.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HistoricoDAO.h"
#import <sqlite3.h>

@implementation HistoricoDAO

-(NSArray *)getAllData{
    EntityManager *em = [EntityManager sharedInstance];

    NSArray *resultSet = [em getData:@"SELECT * FROM historico" andBlk:^id(sqlite3_stmt *stmt) {
        Historico *obj = [[Historico alloc] init];
        obj.codigo = sqlite3_column_int(stmt, 0);

        return obj;
    }];

    return resultSet;
}

@end
