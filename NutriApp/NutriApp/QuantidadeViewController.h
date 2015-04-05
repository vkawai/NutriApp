//
//  QuantidadeViewController.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 4/4/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuantidadeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nomeAlimento;

@property (weak, nonatomic) IBOutlet UITextField *textoQuant;

- (IBAction)confirmar:(id)sender;

@end
