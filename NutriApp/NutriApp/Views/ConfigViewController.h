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

- (IBAction)salvar:(id)sender;

- (IBAction)limpar:(id)sender;


@end
