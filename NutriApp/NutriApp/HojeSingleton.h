//
//  HojeSingleton.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/29/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Alimento.h"

@interface HojeSingleton : NSObject

@property NSMutableArray *historicoDoDia;

+(instancetype)sharedInstance;

@end
