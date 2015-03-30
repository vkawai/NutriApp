//
//  HojeSingleton.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/29/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HojeSingleton.h"

@implementation HojeSingleton

static HojeSingleton *instance;

+(instancetype)sharedInstance{
    static dispatch_once_t dispatcher;
    dispatch_once(&dispatcher,^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    
    if(self){
        NSMutableArray *cafe;
        NSMutableArray *almoco;
        NSMutableArray *lanche;
        NSMutableArray *janta;
        
//        
//        
//        cafe = [[NSMutableArray alloc]initWithObjects:[[Alimento alloc]initWithNome:@"Pão" andCalorias:120.0], [[Alimento alloc]initWithNome:@"Queijo"andCalorias:144.3], nil];
//        almoco = [[NSMutableArray alloc]initWithObjects:[[Alimento alloc]initWithNome:@"Arroz" andCalorias:98.4], [[Alimento alloc]initWithNome:@"Peito de frango" andCalorias:106.7], nil];
//        lanche = [[NSMutableArray alloc]initWithObjects: nil];
//        janta = [[NSMutableArray alloc]initWithObjects:[[Alimento alloc]initWithNome:@"Macarrao" andCalorias:220.4],[[Alimento alloc]initWithNome:@"Omelete" andCalorias:389.0] , nil];

        _historicoDoDia = [NSMutableArray arrayWithObjects:cafe, almoco, lanche, janta, nil];
        
        
        
    }
    
    return self;
}

@end
