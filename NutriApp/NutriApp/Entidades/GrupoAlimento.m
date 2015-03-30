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
@dynamic contains;

- (void)addContainsObject:(Alimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set addObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];
}

- (void)removeContainsObject:(Alimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set removeObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];
}

- (void)addContains:(NSSet *)values{
	
}

- (void)removeContains:(NSSet *)values{
	
}


@end
