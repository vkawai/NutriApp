//
//  GrupoAlimento.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 30/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alimento;

@interface GrupoAlimento : NSManagedObject

@property (nonatomic, retain) NSString * nomeGrupo;
/**
 *  NSSet de Alimentos que fazem parte do grupo.
 */
@property (nonatomic, retain) NSSet *contains;
@end

@interface GrupoAlimento (CoreDataGeneratedAccessors)

- (void)addContainsObject:(Alimento *)value;
- (void)removeContainsObject:(Alimento *)value;
- (void)addContains:(NSSet *)values;
- (void)removeContains:(NSSet *)values;

@end
