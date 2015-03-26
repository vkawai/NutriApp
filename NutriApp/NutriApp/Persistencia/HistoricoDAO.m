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
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        obj.data = [formatter dateFromString:[NSString stringWithFormat:@"%s",sqlite3_column_text(stmt,1)]];


        obj.alimentos = [em getData:@"" andBlk:^id(sqlite3_stmt *stmt) {
            return nil;
        }];


        return obj;
    }];

    return resultSet;
}

@end
