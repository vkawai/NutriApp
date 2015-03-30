//
//  TipoRefeicao.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 29/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Refeicoes;

@interface TipoRefeicao : NSManagedObject

@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSSet *contains;
@end

@interface TipoRefeicao (CoreDataGeneratedAccessors)

- (void)addContainsObject:(Refeicoes *)value;
- (void)removeContainsObject:(Refeicoes *)value;

@end
