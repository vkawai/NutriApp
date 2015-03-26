//
//  HistoricoDAO.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityManager.h"
#import "../Entidades/Historico.h"
#import "AlimentoDAO.h"


@interface HistoricoDAO : NSObject

+(instancetype)sharedInstance;
-(NSArray *)getAllData;
-(bool)query:(NSString *)query;

@end
