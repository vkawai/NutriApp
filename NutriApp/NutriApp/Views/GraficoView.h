//
//  GraficoView.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraficoView : UIView

//dados para traçar o grafico
/**
 * valores entre 0.0 e 1.0 que determinam cada ponto no grafico
 */
@property NSMutableArray *dados;

/**
 * NSDates que correspondem aos valores de cada ponto; serão colocados em labels nos eixos do gráficos
 */
@property NSMutableArray *dias;

//dimensoes do grafico
#define kGraphHeight 300
#define kDefaultGraphWidth 900

//constantes das linhas verticais
#define kOffsetX 10
#define kStepX 50

//offset do grafico na subview
#define kGraphBottom 300
#define kGraphTop 0

//constantes das linhas horizontais
#define kStepY 50
#define kOffsetY 10

//tamanho do circulo de data point
#define kCircleRadius 3

//-(instancetype)initWithDados:(NSMutableArray *)dados;

@end
