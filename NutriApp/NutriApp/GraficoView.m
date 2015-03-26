//
//  GraficoView.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "GraficoView.h"

@implementation GraficoView

- (void)lineGraphWithContext:(CGContextRef)ctx{// andData:(float[])dados{
    float dados[] = {0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77, 0.99, 0.55};
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * dados[0]);
    
    for (int i = 1; i < sizeof(dados); i++){
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * dados[i]);
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    
    //cria circulos inscritos a retangulos em cada data point, e entao preenche os circulos
    for (int i = 1; i < sizeof(dados) - 1; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * dados[i];
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //cor para preencher a area do grafico
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:0.5] CGColor]);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight);
    CGContextAddLineToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * dados[0]);
    for (int i = 1; i < sizeof(dados); i++)
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * dados[i]);
    }
    CGContextAddLineToPoint(ctx, kOffsetX + (sizeof(dados) - 1) * kStepX, kGraphHeight);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFill);
    
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //configura como serão traçadas as linhas da grid
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    //numero de linhas que cabem no grafico
    int linhasGrid = (kDefaultGraphWidth - kOffsetX) / kStepX;
    
    //desenhar a grid
    for (int i = 0; i < linhasGrid; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    //numero de linhas horizontais que cabem
    int linhasGridHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    //desenahr linhas horizontais
    for (int i = 0; i <= linhasGridHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
    
    //faz as linhas da grid serem desenhadas tracejadas
    CGFloat tracejado[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, tracejado, 2);
    
    CGContextStrokePath(context);
    
    //faz as proximas linhas não serem tracejadas
    CGContextSetLineDash(context, 0, NULL, 0);
    
    [self lineGraphWithContext:context];
    
}


@end
