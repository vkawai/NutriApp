//
//  ViewController.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Persistencia/EntityManager.h"
#import "GraficoView.h"

@interface ViewController : UIViewController

#define kGraphHeight 300
#define kDefaultGraphWidth 900


@property EntityManager *em;

- (IBAction)salvarOMundo:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollGrafico;

@property (strong, nonatomic) IBOutlet GraficoView *graficoView;

@end

