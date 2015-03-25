//
//  ViewController.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Persistencia/EntityManager.h"

@interface ViewController : UIViewController

@property EntityManager *em;

- (IBAction)salvarOMundo:(id)sender;

@end

