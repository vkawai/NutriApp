//
//  AlimentoDAO.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityManager.h"
#import "Alimento.h"

@interface PersistenceInit : NSObject

+(instancetype)sharedInstance;
-(void)fillCoreDataDatabase;
-(NSString *)getGrupoAlimentosForGivenSet:(int)identifier;

@end
