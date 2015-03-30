//
//  EntityManager.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "EntityManager.h"

@implementation EntityManager

static EntityManager *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}


/**
 *
 *
 *  @param dataBaseName nome do database @"databasename" (sem sufixo .db)
 */
-(void)loadDatabase:(NSString *)dataBaseName{

    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    _path = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:dataBaseName]];

    NSFileManager *fm = [NSFileManager defaultManager];
//#warning REMOVER!
//    NSLog(@"%@\n",_path);
    if([fm fileExistsAtPath:_path] == NO){

        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:dataBaseName ofType:@"db"];

        [fm copyItemAtPath:bundlePath toPath:_path error:nil];

    }

}

/**
 *  Método para enviar querys de INSERT, UDPATE e DELETE
 *
 *  @param query - String com a query SQL para SQLite
 *
 *  @return YES se a query for executada com sucesso, NO caso contrário.
 */
-(BOOL)changeData:(NSString *)query{
    sqlite3_stmt *stmt;
    const char *dbpath = [_path UTF8String];
    BOOL success = false;

    if(sqlite3_open(dbpath, &_sqlite) == SQLITE_OK){

        const char *saveStmt = [query UTF8String];
        sqlite3_prepare_v2(_sqlite, saveStmt, -1, &stmt, nil);

        if(sqlite3_step(stmt) == SQLITE_DONE){
            success = true;
        }
        sqlite3_finalize(stmt);
        sqlite3_close(_sqlite);
    }
    return success;
}

/**
 *  Método para enviar query de SELECT. Precisa enviar um bloco de execução
 *  Mostrando como os dados deve ser distribuido para uma entidade.
 *
 *  @param query - String contendo a query SQL.
 *  @param blk   - Bloco de execução contendo o tratamento de dado.
 *
 *  @return NSArray contendo o set de resultado.
 */
-(NSArray *)getData:(NSString *)query andBlk:(id (^)(sqlite3_stmt *stmt))blk{

    sqlite3_stmt *stmt;
    const char *dbpath = [_path UTF8String];
    NSMutableArray *resultSet = [[NSMutableArray alloc] init];
    if(sqlite3_open(dbpath, &_sqlite) == SQLITE_OK){
        const char *query_stmt = [query UTF8String];

        if (sqlite3_prepare_v2(_sqlite, query_stmt, -1, &stmt, NULL) == SQLITE_OK){
            while(sqlite3_step(stmt) == SQLITE_ROW){
                [resultSet addObject:blk(stmt)];
            }
            sqlite3_finalize(stmt);
        }
        sqlite3_close(_sqlite);
    }
    return resultSet;
}

/**
 *
 *
 *  @param tableName Nome da tabela
 *  @param idName    Nome da coluna que armazena a chave
 *
 *  @return NSNumber contendo o valor da próxima chave disponível.
 */
-(NSNumber *)nextIdForTable:(NSString *)tableName withIdName:(NSString *)idName{
    NSNumber *next = [[self getData:[NSString stringWithFormat:@"SELECT MAX(%@)+1 FROM %@",idName, tableName] andBlk:^id(sqlite3_stmt *stmt) {
        NSNumber *result = [NSNumber numberWithInt:sqlite3_column_int(stmt, 0)];
        return result;
    }] firstObject];

    return next;
}

@end
