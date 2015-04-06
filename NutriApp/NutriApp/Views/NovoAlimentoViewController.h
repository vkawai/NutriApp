//
//  NovoAlimentoViewController.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 06/04/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NovoAlimentoViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtEnergia;
@property (weak, nonatomic) IBOutlet UITextField *txtCarboidrato;
@property (weak, nonatomic) IBOutlet UITextField *txtLipideos;
- (IBAction)btnSalvar:(id)sender;

@end
