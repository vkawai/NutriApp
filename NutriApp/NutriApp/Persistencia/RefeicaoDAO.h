//
//  RefeicaoDAO.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlimentoDAO.h"
#import "../Entidades/Refeicao.h"
#import "EntityManager.h"

@interface RefeicaoDAO : NSObject

+(instancetype)sharedInstance;
-(bool)query:(NSString *)query;

@end
