//
//  HistoricoDAO.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HistoricoDAO.h"
#import <sqlite3.h>

@implementation HistoricoDAO{
    EntityManager *em;
}

static HistoricoDAO *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    em = [EntityManager sharedInstance];
    return self;
}

-(bool)query:(NSString *)query{
    return [em changeData:query];
}

-(NSArray *)getAllData{

    NSArray *resultSet = [em getData:@"SELECT * FROM historico" andBlk:^id(sqlite3_stmt *stmt) {

        AlimentoDAO *dao = [AlimentoDAO sharedInstance];

        Historico *obj = [[Historico alloc] init];
        obj.codigo = sqlite3_column_int(stmt, 0);
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        obj.data = [formatter dateFromString:[NSString stringWithCString:(char*)sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding]];

        obj.alimentos = [[NSMutableArray alloc]initWithArray:[dao getAlimentosFromGivenHistory:obj.codigo]];

        return obj;
    }];

    return resultSet;
}

@end