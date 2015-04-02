//
//  GrupoAlimento.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 30/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "GrupoAlimento.h"
#import "Alimento.h"


@implementation GrupoAlimento

@dynamic nomeGrupo;
@dynamic contemAlimento;

- (void)addContemAlimentoObject:(Alimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contemAlimento]];

    [set addObject:value];
    [self setContemAlimento:[[NSSet alloc] initWithSet:set]];
}

- (void)removeContemAlimentoObject:(Alimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contemAlimento]];

    [set removeObject:value];
    [self setContemAlimento:[[NSSet alloc] initWithSet:set]];
}

- (void)addContemAlimento:(NSSet *)values{
	
}

- (void)removeContemAlimento:(NSSet *)values{
	
}


@end
