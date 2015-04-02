//
//  AnimacaoViewController.m
//  NutriApp
//
//  Created by Guilherme on 02/04/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "AnimacaoViewController.h"

@interface AnimacaoViewController ()

@end

@implementation AnimacaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(loadTabBarController)
               withObject:nil
               afterDelay:1.0];
    
}

-(void)loadTabBarController
{
    [self performSegueWithIdentifier:@"loadTabBarControllerSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
