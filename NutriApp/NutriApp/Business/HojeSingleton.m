//
//  HojeSingleton.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/29/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HojeSingleton.h"

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

        CoreDataPersistence *coredata = [CoreDataPersistence sharedInstance];

        NSMutableArray *c;
        NSMutableArray *a;
        NSMutableArray *l;
        NSMutableArray *j;

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [[NSDate alloc]init];

        NSArray *temp = [self loadData:[formatter stringFromDate:date]];

        for(Refeicoes *r in temp){
            switch ([r.tipoRefeicao intValue]) {
                case REFEICAO_CAFEMANHA:
                    _cafeManha = r;
                    c = [self getArrayWithRefeicao:_cafeManha];
                    break;
                case REFEICAO_ALMOCO:
                    _almoco = r;
                    a = [self getArrayWithRefeicao:_almoco];
                    break;
                case REFEICAO_LANCHE:
                    _lanche = r;
                    l = [self getArrayWithRefeicao:_lanche];
                    break;
                case REFEICAO_JANTAR:
                    _janta = r;
                    j = [self getArrayWithRefeicao:_janta];
                    break;
            }
        }

        if(_cafeManha == nil){
            _cafeManha = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
            c = [[NSMutableArray alloc] init];
        }
        if(_almoco == nil){
            _almoco = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
            a = [[NSMutableArray alloc] init];
        }
        if(_lanche == nil){
            _lanche = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
            l = [[NSMutableArray alloc] init];
        }
        if(_janta == nil){
            _janta = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
            j = [[NSMutableArray alloc] init];
        }

//        _historicoDoDia = [[NSDictionary alloc]initWithObjects:@[cafe, almoco, lanche, janta] forKeys:@[@"Cafe da manhã",@"Almoço",@"Lanche", @"Janta"]];
        _historicoDoDia = [[NSMutableArray alloc]init];
        [_historicoDoDia addObject:c];
        [_historicoDoDia addObject:a];
        [_historicoDoDia addObject:l];
        [_historicoDoDia addObject:j];
    }
    
    return self;
}

-(NSMutableArray *)getArrayWithRefeicao:(Refeicoes *)refeicao{
    NSArray *sortedArray = [[[refeicao contains] allObjects] sortedArrayUsingComparator:^NSComparisonResult(RefeicoesAlimento* obj1, RefeicoesAlimento* obj2) {
        return [[[obj1 contains] descricao] compare:[[obj2 contains] descricao]];
    }];
    return [[NSMutableArray alloc]initWithArray:sortedArray];
}

-(void)saveMeals{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];


    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSDate *now = [NSDate date];
    NSString *data = [formatter stringFromDate:now];

    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    now = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",data]];


    for (int i = 0; i < _historicoDoDia.count; i++) {
        NSMutableArray *selected = [_historicoDoDia objectAtIndex:i];
        for(int j = 0; j < selected.count; j++){
            RefeicoesAlimento *ra = [selected objectAtIndex:j];
            switch(i){
                case REFEICAO_CAFEMANHA:
                    [_cafeManha addContainsObject:ra];
                    _cafeManha.data = now;
                    _cafeManha.tipoRefeicao = @REFEICAO_CAFEMANHA;
                    ra.partOf = _cafeManha;
                    break;
                case REFEICAO_ALMOCO:
                    [_almoco addContainsObject:ra];
                    _almoco.data = now;
                    _almoco.tipoRefeicao = @REFEICAO_ALMOCO;

                    ra.partOf = _almoco;
                    break;
                case REFEICAO_LANCHE:
                    [_lanche addContainsObject:ra];
                    _lanche.data = now;
                    _lanche.tipoRefeicao = @REFEICAO_LANCHE;

                    ra.partOf = _lanche;
                    break;
                case REFEICAO_JANTAR:
                    [_janta addContainsObject:ra];
                    _janta.data = now;
                    _janta.tipoRefeicao = @REFEICAO_JANTAR;

                    ra.partOf = _janta;
                    break;
            }
        }
    }

    [[CoreDataPersistence sharedInstance] saveContext];
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
