//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataPersistence.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CoreDataPersistence *cdp = [CoreDataPersistence sharedInstance];
    [cdp dbInit];

    NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"alimento" ofType:@"db"]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)salvarOMundo:(id)sender {
}
@end
