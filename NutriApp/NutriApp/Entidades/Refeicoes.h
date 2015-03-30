//
//  Refeicoes.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 29/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TipoRefeicao.h"

@class RefeicoesAlimento;

@interface Refeicoes : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) TipoRefeicao *partOf;
@property (nonatomic, retain) RefeicoesAlimento *contais;

@end
