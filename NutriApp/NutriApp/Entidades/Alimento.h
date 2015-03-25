//
//  Alimento.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlimentoComposite.h"

@interface Alimento : AlimentoComposite

@property int id_alimento;
@property NSString* descricao;

@end
