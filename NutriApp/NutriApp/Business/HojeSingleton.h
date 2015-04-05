//
//  HojeSingleton.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/29/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Entidades/Alimento.h"
#import "../Persistencia/CoreDataPersistence.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/RefeicoesAlimento.h"

@interface HojeSingleton : NSObject

@property NSMutableArray *historicoDoDia;
@property Refeicoes *cafeManha;
@property Refeicoes *almoco;
@property Refeicoes *lanche;
@property Refeicoes *janta;
/**
 * alimento selecionado na table view de todos os alimentos; serve para passar pra view de quantidade
 */
@property Alimento *thisAlimento;
/**
 * numero da refeicao na qual estao sendo adicionados alimentos pela ComidaTableView, serve para passar para a view de quantidade
 */
@property int numeroRefeicao;

@property NSMutableArray *dadosGrafico;

+(instancetype)sharedInstance;
-(void)saveMeals;
-(void)saveMeals:(NSDate *)date;
-(void)loadTodayData;
-(void)loadPastData:(NSString *)date;

@end
