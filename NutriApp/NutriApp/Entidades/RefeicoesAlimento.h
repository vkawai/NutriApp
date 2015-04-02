//
//  RefeicoesAlimento.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alimento, Refeicoes;

@interface RefeicoesAlimento : NSManagedObject

@property (nonatomic, retain) NSNumber * quantidade;
/**
 *  Alimento que faz parte de uma determinada Refeicao (partOf)
 */
@property (nonatomic, retain) Alimento *contains;
/**
 *  Refeicao que contem o Alimento (contains)
 */
@property (nonatomic, retain) Refeicoes *partOf;

@end
