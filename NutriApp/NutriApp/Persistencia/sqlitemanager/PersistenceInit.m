//
//  AlimentoDAO.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "PersistenceInit.h"
#import "../../Entidades/GrupoAlimento.h"
#import "CoreDataPersistence.h"
@implementation PersistenceInit{
    id (^blk)(sqlite3_stmt*);
    EntityManager *em;
}

static PersistenceInit *instance;

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
        CoreDataPersistence *persistence = [CoreDataPersistence sharedInstance];
        Alimento *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Alimento" inManagedObjectContext:[persistence managedObjectContext]];

        obj.descricao = [NSString stringWithCString:(char*)sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding];
        obj.umidade = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 3)];
        obj.energia = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 4)];
        obj.proteina = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 5)];
        obj.lipideos = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 6)];
        obj.colesterol = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 7)];
        obj.carboidrato = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 8)];
        obj.fibraAlimentar = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 9)];
        obj.cinzas = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 10)];
        obj.calcio = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 11)];
        obj.magnesio = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 12)];
        obj.manganes = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 13)];
        obj.fosforo = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 14)];
        obj.ferro = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 15)];
        obj.sodio = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 16)];
        obj.potassio = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 17)];
        obj.cobre = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 18)];
        obj.zinco = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 19)];
        obj.retinol = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 20)];
        obj.tiamina = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 21)];
        obj.riboflavina = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 22)];
        obj.piridoxina = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 23)];
        obj.niacina = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 24)];
        obj.vitaminaC = [NSNumber numberWithFloat:sqlite3_column_double(stmt, 25)];


        NSString *groupName = [[PersistenceInit sharedInstance] getGrupoAlimentosForGivenSet:sqlite3_column_int(stmt, 1)];

        GrupoAlimento *obj2 = [[persistence fetchDataForEntity:@"GrupoAlimento" usingPredicate:[NSPredicate predicateWithFormat:@"nomeGrupo=%@",groupName]] firstObject];

        if(obj2 == nil){
            obj2 = [NSEntityDescription insertNewObjectForEntityForName:@"GrupoAlimento" inManagedObjectContext:[persistence managedObjectContext]];
            obj2.nomeGrupo = groupName;
        }

        obj.categoria = obj2;
        [obj2 addContemAlimentoObject:obj];

//        NSLog(@"%@ : %@\n",obj.descricao, obj2.nomeGrupo);

        [persistence saveContext];

        return obj;
    };


    return self;
}

-(void)fillCoreDataDatabase{
    em = [EntityManager sharedInstance];
    [em loadDatabase:@"alimento"];
    CoreDataPersistence *persistence = [CoreDataPersistence sharedInstance];
    [em getData:@"SELECT * FROM alimento" andBlk:blk];
    [persistence saveContext];
}


-(NSString *)getGrupoAlimentosForGivenSet:(int)identifier{
   return [[em getData:[NSString stringWithFormat:@"SELECT nome_grupo FROM grupo_alimento WHERE id_grupo=%d",identifier] andBlk:^id(sqlite3_stmt *stmt) {
        return [NSString stringWithCString:(char *)sqlite3_column_text(stmt, 0)  encoding:NSUTF8StringEncoding];
    }] firstObject];
}

@end
