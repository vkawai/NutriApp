//
//  Refeicoes.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 30/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Historico, RefeicoesAlimento, TipoRefeicao;

@interface Refeicoes : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) RefeicoesAlimento *contais;
@property (nonatomic, retain) TipoRefeicao *partOf;
@property (nonatomic, retain) NSSet *historyOf;
@end

@interface Refeicoes (CoreDataGeneratedAccessors)

- (void)addHistoryOfObject:(Historico *)value;
- (void)removeHistoryOfObject:(Historico *)value;
- (void)addHistoryOf:(NSSet *)values;
- (void)removeHistoryOf:(NSSet *)values;

@end
