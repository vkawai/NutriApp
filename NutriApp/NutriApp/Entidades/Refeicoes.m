//
//  Refeicoes.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "Refeicoes.h"
#import "RefeicoesAlimento.h"
#import "Alimento.h"


@implementation Refeicoes

@dynamic data;
@dynamic nome;
@dynamic saved;
@dynamic tipoRefeicao;
@dynamic contains;



-(double)caloria{
    double res = 0;
    for(RefeicoesAlimento *ra in [self contains]){
        res += [ra.contains.energia doubleValue] * [ra.quantidade intValue];
    }
    return res;
}

-(double)carboidrado{
    double res = 0;
    for(RefeicoesAlimento *ra in [self contains]){
        res += [ra.contains.carboidrato doubleValue] * [ra.quantidade intValue];
    }
    return res;
}

-(double)lipidio{
    double res = 0;
    for(RefeicoesAlimento *ra in [self contains]){
        res += [ra.contains.lipideos doubleValue] * [ra.quantidade intValue];
    }
    return res;
}



#warning RESTOSERAIMPLEMENTADO SOON™



- (void)addContainsObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set addObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];
}

- (void)removeContainsObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self contains]];

    [set removeObject:value];
    [self setContains:[[NSSet alloc] initWithSet:set]];

}

- (void)addContains:(NSSet *)values{

}

- (void)removeContains:(NSSet *)values{
    
}

@end
