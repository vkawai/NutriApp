//
//  GraficoView.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "GraficoView.h"
#import "HojeSingleton.h"

@implementation GraficoView

-(instancetype)initWithDados:(NSMutableArray *)dados{
    self = [super init];
    if(self){
        _dados = dados;
    }
    return self;
}

- (void)lineGraphWithContext:(CGContextRef)context{
    
    float varStepX = kDefaultGraphWidth/_dados.count;
    NSLog(@"%f",varStepX);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:.15 green:.48 blue:.8 alpha:1] CGColor]);
    
    int maxGraphHeight = kGraphHeight - kOffsetY;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, kOffsetX, kGraphHeight - maxGraphHeight * [[_dados firstObject]floatValue]);
    
    for (int i = 0; i < _dados.count; i++){
        float valorPonto = [[_dados objectAtIndex:i]floatValue];
        if (valorPonto > 1){
            valorPonto = 1;
        }
        CGContextAddLineToPoint(context, kOffsetX + i * varStepX, kGraphHeight - maxGraphHeight * valorPonto);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:.15 green:.48 blue:.8 alpha:1] CGColor]);
    
    //cria circulos inscritos a retangulos em cada data point, e entao preenche os circulos
    for (int i = 0; i < _dados.count; i++)
    {
        float valorPonto = [[_dados objectAtIndex:i]floatValue];
        if (valorPonto > 1){
            valorPonto = 1;
        }
        float x = kOffsetX + i * varStepX;
        float y = kGraphHeight - maxGraphHeight * valorPonto;
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(context, rect);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //cor para preencher a area do grafico
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:.15 green:.48 blue:.8 alpha:0.5] CGColor]);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, kOffsetX, kGraphHeight);
    float valorFirst = [[_dados firstObject]floatValue];
    if (valorFirst > 1){
        valorFirst = 1;
    }
    CGContextAddLineToPoint(context, kOffsetX, kGraphHeight - maxGraphHeight * valorFirst);
    for (int i = 0; i < _dados.count; i++)
    {
        float valorPonto = [[_dados objectAtIndex:i]floatValue];
        if (valorPonto > 1){
            valorPonto = 1;
        }
        CGContextAddLineToPoint(context, kOffsetX + i * varStepX, kGraphHeight - maxGraphHeight * valorPonto);
    }
    CGContextAddLineToPoint(context, kOffsetX + (_dados.count - 1) * varStepX, kGraphHeight);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);
    
    //desenha a linha horizontal que representa o limite definido pelo usuario
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
    float limite = [[[NSUserDefaults standardUserDefaults]objectForKey:@"limiteNutricao"]floatValue ];
    if(limite>0 && limite<4000){
        //CGContextBeginPath(context);
        CGContextMoveToPoint(context, kOffsetX, kGraphHeight - maxGraphHeight *(limite/4000));
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphHeight - maxGraphHeight *(limite/4000));
        CGContextStrokePath(context);
    }
    
    //"inverte o sistema de coordenadas da tela"; se não fizer isso, o texto vai ser escrito de cabeça para baixo
    CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    
    //colocando texto no grafico, para identificar os pontos
    CGContextSelectFont(context, "Helvetica", 14, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM"];
    
    for (int i = 0; i < _dias.count; i++)
    {
        //NSString *text = [_dados objectAtIndex:1].texto OU ALGO DO TIPO
        NSString *texto = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[_dias
                                                                                        objectAtIndex:i]]];
        CGContextShowTextAtPoint(context, kOffsetX + i * varStepX - [texto sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18]].width/2, kGraphBottom - 5, [texto cStringUsingEncoding:NSUTF8StringEncoding], [texto length]);
    }
    
    
}


- (void)drawRect:(CGRect)rect {
    
//    //valores para teste, remover depois
//    float dados[] = {0.7, 0.4, 0.5, 0.7, 0.7, 0.4, 0.5, 0.7, 0.67, 0.81, 0.76, 0.9, 1.0, 0.33, 0.85, 0.41, 0.75};
//    _dados = [[NSMutableArray alloc]init];
//    
//#warning ESSES DADOS DEVEM VIR DO SINGLETON DE UM ARRAY RESPONSAVEL POR ISSO. PEGAR TIPO OS DEZ DIAS MAIS RECENTES. DIVIDIR ELES POR 4000 PARA OBTER O FLOAT QUE VAI NO GRAFICO
//    
//    float dadosLength = sizeof(dados)/sizeof(dados[0]);
//    
//    for(int i=0; i<dadosLength; i++){
//        [_dados addObject:[NSNumber numberWithFloat:dados[i] ]];
//    }
    
    //fim da parte de testes

    // ----- Carregando dados dos ultimos 10 dias -----
    CoreDataPersistence *persistence = [CoreDataPersistence sharedInstance];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *components = [calendar components:(NSCalendarUnitDay) fromDate:[[NSDate alloc]init]];
    NSDateComponents *dateMinusTen = [[NSDateComponents alloc]init];

    [dateMinusTen setDay:[components day]-12];

    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSString *string = [formatter stringFromDate:[[NSDate alloc]init]];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSDate *data1 = [formatter dateFromString:[NSString stringWithFormat:@"%@ 04:00",string]];
    NSDate *data2;

    data2 = [calendar dateByAddingComponents:dateMinusTen toDate:data1 options:0];

    NSLog(@"%@ -> %@",data2,data1);

    NSArray *fetchedData = [[persistence fetchDataForEntity:@"Refeicoes" usingPredicate:[NSPredicate predicateWithFormat:@"(data <= %@) AND (data >= %@)",data1, data2]] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(Refeicoes *)obj1 data] compare:[(Refeicoes *)obj2 data]];
    }];
    NSLog(@"REFEICOES RETORNADAS: %lu",(unsigned long)[fetchedData count]);
    _dados = [[NSMutableArray alloc] init];
    _dias = [[NSMutableArray alloc]init];

    NSDate *esseDia = [(Refeicoes*)[fetchedData firstObject] data];
    
    
    float calorias = 0.0;
    
    for (int i = 0; i < [fetchedData count]; i++) {
        
        if([(Refeicoes *)[fetchedData objectAtIndex:i] data] == esseDia){
            calorias += [[fetchedData objectAtIndex:i] caloria];
        }
        else{
            [_dados addObject:[NSNumber numberWithDouble:calorias/4000]];
            NSLog(@"Valor %f dia %@", calorias, [[fetchedData objectAtIndex:i-1]data]);
            [_dias addObject:[(Refeicoes*)[fetchedData objectAtIndex:i-1]data]];
            calorias = [[fetchedData objectAtIndex:i]caloria];
        }
        esseDia = [(Refeicoes*)[fetchedData objectAtIndex:i] data];
    }
    [_dados addObject:[NSNumber numberWithDouble:calorias/4000]];
    NSLog(@"Valor %f dia %@", calorias, [[fetchedData lastObject]data]);
    if(fetchedData.count > 0){
        [_dias addObject:[(Refeicoes*)[fetchedData lastObject]data]];
    }
    else{
        [_dados addObject:@0.0]; // Workaround para a primeira vez (arrumar isso)
    }
	// ------------------------------------------------


    float varStepX = kDefaultGraphWidth/_dados.count;
    NSLog(@"%f",varStepX);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //configura como serão traçadas as linhas da grid
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    
    //numero de linhas que cabem no grafico
    int linhasGrid = (kDefaultGraphWidth - kOffsetX) / varStepX;
    
    //desenhar a grid
    for (int i = 0; i <= linhasGrid; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * varStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * varStepX, kGraphBottom);
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
    //formato: tamanho do traço, tamanho do espaço entre traços
    CGFloat tracejado[] = {1.0, 1.0};
    CGContextSetLineDash(context, 0.0, tracejado, 2);
    
    CGContextStrokePath(context);
    
    //faz as proximas linhas não serem tracejadas
    CGContextSetLineDash(context, 0, NULL, 0);
    
    [self lineGraphWithContext:context];
    
}


@end
