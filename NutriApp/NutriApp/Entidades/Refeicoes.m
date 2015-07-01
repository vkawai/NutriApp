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
@dynamic refeicoesAlimentos;



-(double)caloria{
    double res = 0;
    for(RefeicoesAlimento *ra in [self refeicoesAlimentos]){
        res += ([ra.alimento.energia doubleValue]/100) * [ra.quantidade intValue];
    }
    return res;
}

-(double)carboidrado{
    double res = 0;
    for(RefeicoesAlimento *ra in [self refeicoesAlimentos]){
        res += [ra.alimento.carboidrato doubleValue] * [ra.quantidade intValue];
    }
    return res;
}

-(double)lipidio{
    double res = 0;
    for(RefeicoesAlimento *ra in [self refeicoesAlimentos]){
        res += [ra.alimento.lipideos doubleValue] * [ra.quantidade intValue];
    }
    return res;
}



#warning RESTOSERAIMPLEMENTADO SOON™


- (void)addRefeicoesAlimentosObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self refeicoesAlimentos]];

    [set addObject:value];
    [self setRefeicoesAlimentos:[[NSSet alloc] initWithSet:set]];
}

- (void)removeRefeicoesAlimentosObject:(RefeicoesAlimento *)value{
    NSMutableSet *set = [[NSMutableSet alloc]initWithSet:[self refeicoesAlimentos]];

    [set removeObject:value];
    [self setRefeicoesAlimentos:[[NSSet alloc] initWithSet:set]];

}

- (void)addRefeicoesAlimentos:(NSSet *)values{

}

- (void)removeRefeicoesAlimentos:(NSSet *)values{
    
}

@end
