//
//  RefeicoesAlimento.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 29/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Alimento.h"
#import "Refeicoes.h"


@interface RefeicoesAlimento : NSManagedObject

@property (nonatomic, retain) NSNumber * quantidade;
@property (nonatomic, retain) Alimento *contais;
@property (nonatomic, retain) Refeicoes *partOf;

@end
