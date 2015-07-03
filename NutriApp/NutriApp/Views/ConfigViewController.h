//
//  ConfigViewController.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/30/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoSelector;
@property (weak, nonatomic) IBOutlet UITextField *limiteText;
@property (strong, nonatomic) IBOutlet UILabel *qtdLimite;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong) NSUserDefaults *useDef;

- (IBAction)salvar:(NSString*)limite;

- (IBAction)limpar:(id)sender;

- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)textValueChanged:(UITextField *)sender;

@end
