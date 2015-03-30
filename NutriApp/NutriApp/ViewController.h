//
//  ViewController.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

- (IBAction)salvarOMundo:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollGrafico;

@property (strong, nonatomic) IBOutlet GraficoView *graficoView;

@end

