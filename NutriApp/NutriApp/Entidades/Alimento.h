//
//  Alimento.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GrupoAlimento, RefeicoesAlimento;

@interface Alimento : NSManagedObject

@property (nonatomic, retain) NSNumber * calcio;
@property (nonatomic, retain) NSNumber * carboidrato;
@property (nonatomic, retain) NSNumber * cinzas;
@property (nonatomic, retain) NSNumber * cobre;
@property (nonatomic, retain) NSNumber * colesterol;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSNumber * energia;
@property (nonatomic, retain) NSNumber * ferro;
@property (nonatomic, retain) NSNumber * fibraAlimentar;
@property (nonatomic, retain) NSNumber * fosforo;
@property (nonatomic, retain) NSNumber * lipideos;
@property (nonatomic, retain) NSNumber * magnesio;
@property (nonatomic, retain) NSNumber * manganes;
@property (nonatomic, retain) NSNumber * niacina;
@property (nonatomic, retain) NSNumber * piridoxina;
@property (nonatomic, retain) NSNumber * potassio;
@property (nonatomic, retain) NSNumber * proteina;
@property (nonatomic, retain) NSNumber * retinol;
@property (nonatomic, retain) NSNumber * riboflavina;
@property (nonatomic, retain) NSNumber * sodio;
@property (nonatomic, retain) NSNumber * tiamina;
@property (nonatomic, retain) NSNumber * umidade;
@property (nonatomic, retain) NSNumber * vitaminaC;
@property (nonatomic, retain) NSNumber * zinco;

/**
 *  NSSet de RefeicoesAlimento.
 */
@property (nonatomic, retain) NSSet *igredientOf;
/**
 *  GrupoAlimento do qual faz parte
 */
@property (nonatomic, retain) GrupoAlimento *partOf;
@end

@interface Alimento (CoreDataGeneratedAccessors)

- (void)addIgredientOfObject:(RefeicoesAlimento *)value;
- (void)removeIgredientOfObject:(RefeicoesAlimento *)value;
- (void)addIgredientOf:(NSSet *)values;
- (void)removeIgredientOf:(NSSet *)values;

@end
