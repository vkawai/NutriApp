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
    //valores para teste, remover depois
    float dados[] = {0.7, 0.4, 0.5, 0.7, 0.7, 0.4, 0.5, 0.7, 0.67, 0.81, 0.76, 0.9, 1.0, 0.33, 0.85, 0.41, 0.75};
    _dadosGrafico = [[NSMutableArray alloc]init];
    
#warning ESSES DADOS DEVEM VIR DO SINGLETON DE UM ARRAY RESPONSAVEL POR ISSO. PEGAR TIPO OS DEZ DIAS MAIS RECENTES. DIVIDIR ELES POR 4000 PARA OBTER O FLOAT QUE VAI NO GRAFICO
    
    float dadosLength = sizeof(dados)/sizeof(dados[0]);
    
    for(int i=0; i<dadosLength; i++){
        [_dadosGrafico addObject:[NSNumber numberWithFloat:dados[i] ]];
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

    [self saveMeals:now];
}

-(void)saveMeals:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];


    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSString *data = [formatter stringFromDate:date];

    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    date = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",data]];


    for (int i = 0; i < _historicoDoDia.count; i++) {
        NSMutableArray *selected = [_historicoDoDia objectAtIndex:i];
        for(int j = 0; j < selected.count; j++){
            RefeicoesAlimento *ra = [selected objectAtIndex:j];
            switch(i){
                case REFEICAO_CAFEMANHA:
                    [_cafeManha addContainsObject:ra];
                    _cafeManha.data = date;
                    _cafeManha.tipoRefeicao = @REFEICAO_CAFEMANHA;
                    ra.partOf = _cafeManha;
                    break;
                case REFEICAO_ALMOCO:
                    [_almoco addContainsObject:ra];
                    _almoco.data = date;
                    _almoco.tipoRefeicao = @REFEICAO_ALMOCO;

                    ra.partOf = _almoco;
                    break;
                case REFEICAO_LANCHE:
                    [_lanche addContainsObject:ra];
                    _lanche.data = date;
                    _lanche.tipoRefeicao = @REFEICAO_LANCHE;

                    ra.partOf = _lanche;
                    break;
                case REFEICAO_JANTAR:
                    [_janta addContainsObject:ra];
                    _janta.data = date;
                    _janta.tipoRefeicao = @REFEICAO_JANTAR;

                    ra.partOf = _janta;
                    break;
            }
        }
    }

    [[CoreDataPersistence sharedInstance] saveContext];
}


#pragma mark - History load (Core Data)

-(void)loadTodayData{
    CoreDataPersistence *coredata = [CoreDataPersistence sharedInstance];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [[NSDate alloc]init];

    NSArray *refeicoes = [self loadData:[formatter stringFromDate:date]];
    [self fillDataWithArray:refeicoes];


    if(_cafeManha == nil){
        _cafeManha = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];

    }
    if(_almoco == nil){
        _almoco = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
    }
    if(_lanche == nil){
        _lanche = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
    }
    if(_janta == nil){
        _janta = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
    }
    
    //    [self saveMeals];
}

-(void)loadPastData:(NSString *)date{
    NSArray *refeicoes = [self loadData:date];
    [self fillDataWithArray:refeicoes];
    
    CoreDataPersistence *coredata = [CoreDataPersistence sharedInstance];
    
    if(_cafeManha == nil){
        _cafeManha = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
    }
    if(_almoco == nil){
        _almoco = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
    }
    if(_lanche == nil){
        _lanche = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
        
    }
    if(_janta == nil){
        _janta = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[coredata managedObjectContext]];
        
    }

//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd/MM/yyyy"];
//    [self saveMeals:[formatter dateFromString:date]];

}

-(void)fillDataWithArray:(NSArray *)array{
    _almoco = nil;
    _cafeManha = nil;
    _lanche = nil;
    _janta = nil;
    
    _historicoDoDia = [[NSMutableArray alloc]init];

    NSMutableArray *c = [[NSMutableArray alloc] init];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    NSMutableArray *l = [[NSMutableArray alloc] init];
    NSMutableArray *j = [[NSMutableArray alloc] init];

    for(Refeicoes *r in array){
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

    //        _historicoDoDia = [[NSDictionary alloc]initWithObjects:@[cafe, almoco, lanche, janta] forKeys:@[@"Cafe da manhã",@"Almoço",@"Lanche", @"Janta"]];
    _historicoDoDia = [[NSMutableArray alloc]init];
    [_historicoDoDia addObject:c];
    [_historicoDoDia addObject:a];
    [_historicoDoDia addObject:l];
    [_historicoDoDia addObject:j];
}

#pragma sakmsoa
-(NSArray *)loadData:(NSString *)data{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSDate *searchDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",data]];
//    NSLog(@"CUMIDAS PRO DIA: %@",[formatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",data]]);
    CoreDataPersistence *coredata = [CoreDataPersistence sharedInstance];
    return [coredata fetchDataForEntity:@"Refeicoes" usingPredicate:[NSPredicate predicateWithFormat:@"data == %@",searchDate]];
}

@end
