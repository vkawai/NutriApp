//
//  CalendarioView.m
//  NutriApp
//
//  Created by Felipe Marques Ramos on 31/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "CalendarioView.h"

@implementation CalendarioView


#pragma synthesize
@synthesize weekArray,domButton,segButton,tercButton,quartButton,quintButton,sexButton,sabButton,weekView;// semana e seus botoes;
@synthesize selectedDayLabel;// belas Labels
@synthesize today,weekSunday,selectedDay,calendar;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)calendarView{
    
    
    //setando o formato desejado para a string do dia
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];
    //    [format setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    
    today=[[NSDate alloc]init];// o init é sempre o dia atual
    calendar=[NSCalendar currentCalendar];//pega o calendario default do sistema
    //    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    weekArray=@[domButton,segButton,tercButton,quartButton,quintButton,sexButton,sabButton];// seta array de week buttons
    
    [selectedDayLabel setText:[NSString stringWithFormat:@"%@",[format stringFromDate:today]]];// altera o texto para o hoje
    //    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    for (UIButton *botao in weekArray) {
        [botao addTarget:self action:@selector(selectDay:) forControlEvents:UIControlEventTouchDown];
    }
    
    //swypeLeft proximo
    UISwipeGestureRecognizer *recognizerLeft;
    recognizerLeft.delegate=self;
    recognizerLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swypeLeft:)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:recognizerLeft];
    
    
    //swypeRight volta
    UISwipeGestureRecognizer *recognizerRight;
    recognizerRight.delegate=self;
    recognizerRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swypeRight:)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:recognizerRight];
    
    
    //pegando o primeiro dia da semana(weekSunday)
    NSDateComponents *weekDayComp=[calendar components:(NSCalendarUnitWeekday) fromDate:today];
    NSDateComponents *daysToSubstract=[[NSDateComponents alloc]init];
    [daysToSubstract setDay:0-([weekDayComp weekday]-1)];
    weekSunday=[calendar dateByAddingComponents:daysToSubstract toDate:today options:0];
    [self updateDay:0];
    
    //    NSDateComponents *hj=[calendar components:(NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitTimeZone) fromDate:today];
    //    [hj setTimeZone:[NSTimeZone systemTimeZone]];
    //    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    //    [hj setHour:0];
    NSLog(@"DIA SENDO MANDADO%@",today);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DateUpdated"                                                        object:selectedDay];
}

#pragma Gesture Methods
-(void)swypeRight:(id)sender{
    [self myAnimation:kCATransitionFromLeft];
    [self voltar:sender];
}
-(void)swypeLeft:(id)sender{
    [self myAnimation:kCATransitionFromRight];
    [self proximo:sender];
}


#pragma Update Methods
-(void)updateWeek:(int)sinal{
    NSDateComponents *sundayComp=[calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:weekSunday];
    
    [sundayComp setDay:[sundayComp day]+(7*sinal)];
    weekSunday=[calendar dateFromComponents:sundayComp];
    
}

-(void)updateDay:(int)sinal{
    [self updateWeek:sinal];
    NSDateComponents *sundayComp=[calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:weekSunday];;
    NSLog(@"DOMINGO:%@",weekSunday);
    NSDateFormatter *soDia=[[NSDateFormatter alloc]init];
    soDia.dateFormat=@"dd";
    
    NSDateFormatter *diaInt=[[NSDateFormatter alloc]init];
    diaInt.dateFormat=@"dd/MM/YYYY";
    
    NSDateComponents *newComp=[[NSDateComponents alloc]init];
    [newComp setDay:[sundayComp day]];
    
    for (UIButton *botao in weekArray){
        [newComp setMonth:[sundayComp month]];
        [newComp setYear:[sundayComp year]];
        NSDate *newDate=[calendar dateFromComponents:newComp];
        botao.layer.cornerRadius=15;
        long dif =([newComp day]-[sundayComp day]);
        NSLog(@"A GRANDE DIFEreNCa%li \n\n\n",dif);
        [botao setTag:dif];
        
        [botao setTitle:[NSString stringWithFormat:@"%@",[soDia stringFromDate:newDate]] forState:UIControlStateNormal];
        [botao setTintColor:[UIColor blackColor]];
        
        
        
        NSDate *diaTeste=[calendar dateFromComponents:newComp];
        if ([[diaInt stringFromDate:diaTeste] isEqualToString:[diaInt stringFromDate:today]]) {
            [botao setBackgroundColor: [UIColor colorWithRed:.15 green:.48 blue:.8 alpha:1]];
            //            [weekArray[i] setTitle:@"hoje" forState:UIControlStateNormal];
        }
        else{
            [botao setBackgroundColor:nil];
            [botao setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
        }
        [newComp setDay:[newComp day]+1];
        [newComp setMonth:[sundayComp month]];
        [newComp setYear:[sundayComp year]];
    }
    
}
#pragma Actions
- (IBAction)voltar:(id)sender {
    [self updateDay:-1];
    [self animationUpdateEnd:1];
}

- (IBAction)proximo:(id)sender {
    [self updateDay:1];
    [self animationUpdateEnd:-1];
}

-(void)selectDay:(UIButton*)sender{
    [self updateDay:0];
    
    //muda cor do botao
    [sender setTitleColor:[UIColor colorWithRed:.3 green:.63 blue:.98 alpha:1] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];
    
    NSDateComponents *diaSelecComp=[[NSDateComponents alloc]init];
    NSDateComponents *sundayComp=[calendar components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:weekSunday];
    [diaSelecComp setDay:[sundayComp day]+sender.tag];
    
    [diaSelecComp setMonth:[sundayComp month]];
    [diaSelecComp setYear:[sundayComp year]];
    
    NSDate *diaSelec=[calendar dateFromComponents:diaSelecComp];
    
    selectedDay=diaSelec;
    [selectedDayLabel setText:[NSString stringWithFormat:@"%@",[format stringFromDate:diaSelec]]];
    
    selectedDay=[calendar dateFromComponents:diaSelecComp];
    NSLog(@"DIA SENDO MANDADO%@",selectedDay);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DateUpdated"
                                                        object:selectedDay];
}

#pragma animations
-(void)myAnimation:(NSString *)subType{
    CATransition *animation =[CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:subType];
    [animation setDuration:.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [weekView.layer addAnimation:animation forKey:kCATransition];
    [self updateDay:0];
}
-(void)animationUpdateEnd:(int)sinal{
    for (UIButton *botao in weekArray) {
        [botao setTransform:CGAffineTransformMakeTranslation((400*sinal), 0)];
    }
    [UIView animateWithDuration:.2 animations:^{
        for (UIButton *botao in weekArray) {
            [botao setTransform:CGAffineTransformMakeTranslation(0, 0)];
        }
    }];
}



@end
