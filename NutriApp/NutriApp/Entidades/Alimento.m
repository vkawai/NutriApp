//
//  Alimento.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "Alimento.h"
#import "GrupoAlimento.h"
#import "RefeicoesAlimento.h"


@implementation Alimento

@dynamic calcio;
@dynamic carboidrato;
@dynamic cinzas;
@dynamic cobre;
@dynamic colesterol;
@dynamic descricao;
@dynamic energia;
@dynamic ferro;
@dynamic fibraAlimentar;
@dynamic fosforo;
@dynamic lipideos;
@dynamic magnesio;
@dynamic manganes;
@dynamic niacina;
@dynamic piridoxina;
@dynamic potassio;
@dynamic proteina;
@dynamic retinol;
@dynamic riboflavina;
@dynamic sodio;
@dynamic tiamina;
@dynamic umidade;
@dynamic vitaminaC;
@dynamic zinco;
@dynamic igredientOf;
@dynamic categoria;


- (void)addIgredientOfObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self igredientOf]];

    [set addObject:value];
    [self setIgredientOf:[[NSSet alloc] initWithSet:set]];
}

- (void)removeIgredientOfObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self igredientOf]];

    [set removeObject:value];
    [self setIgredientOf:[[NSSet alloc] initWithSet:set]];
	
}

- (void)addIgredientOf:(NSSet *)values{
	
}

- (void)removeIgredientOf:(NSSet *)values{
	
}


@end
