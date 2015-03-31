//
//  HojeSingleton.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/29/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HojeSingleton.h"
#import "../Persistencia/CoreDataPersistence.h"
#import "../Entidades/Refeicoes.h"

@implementation HojeSingleton

static HojeSingleton *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    
    if(self){
        NSMutableArray *cafe = [[NSMutableArray alloc] init];
        NSMutableArray *almoco = [[NSMutableArray alloc] init];
        NSMutableArray *lanche = [[NSMutableArray alloc] init];
        NSMutableArray *janta = [[NSMutableArray alloc] init];

        NSArray *temp = [self loadData:@"31/03/2015"];
        for(Refeicoes *r in temp){
            switch ([r.tipoRefeicao intValue]) {
                case REFEICAO_CAFEMANHA:
                    [cafe addObject:r];
                    break;
                case REFEICAO_ALMOCO:
                    [almoco addObject:r];
                    break;
                case REFEICAO_LANCHE:
                    [lanche addObject:r];
                    break;
                case REFEICAO_JANTAR:
                    [janta addObject:r];
                    break;
            }
        }

//        _historicoDoDia = [[NSDictionary alloc]initWithObjects:@[cafe, almoco, lanche, janta] forKeys:@[@"Cafe da manhã",@"Almoço",@"Lanche", @"Janta"]];
        _historicoDoDia = [[NSMutableArray alloc]init];
        [_historicoDoDia addObject:cafe];
        [_historicoDoDia addObject:almoco];
        [_historicoDoDia addObject:lanche];
        [_historicoDoDia addObject:janta];
    }
    
    return self;
}


#pragma mark - History load (Core Data)

-(NSArray *)loadData:(NSString *)data{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSDate *searchDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",data]];
    CoreDataPersistence *coredata = [CoreDataPersistence sharedInstance];
    return [coredata fetchDataForEntity:@"Refeicoes" usingPredicate:[NSPredicate predicateWithFormat:@"data == %@",searchDate]];
}

@end
