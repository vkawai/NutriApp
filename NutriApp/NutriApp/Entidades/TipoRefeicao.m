//
//  TipoRefeicao.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 29/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "TipoRefeicao.h"
#import "Refeicoes.h"


@implementation TipoRefeicao

@dynamic descricao;
@dynamic contains;

- (void)addContainsObject:(Refeicoes *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set addObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];
}

- (void)removeContainsObject:(Refeicoes *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set removeObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];
}



@end
