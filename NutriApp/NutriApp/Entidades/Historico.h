//
//  Historico.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 30/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define REFEICAO_CAFEMANHA 0
#define REFEICAO_ALMOCO 1
#define REFEICAO_LANCHE 2
#define REFEICAO_JANTAR 3

@class Refeicoes;

@interface Historico : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * tipoRefeicao;
@property (nonatomic, retain) NSSet *historyOf;
@end

@interface Historico (CoreDataGeneratedAccessors)

- (void)addHistoryOfObject:(Refeicoes *)value;
- (void)removeHistoryOfObject:(Refeicoes *)value;
- (void)addHistoryOf:(NSSet *)values;
- (void)removeHistoryOf:(NSSet *)values;

@end
