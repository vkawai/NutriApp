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
    _nutriapp.alpha=0;
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _nutriapp.alpha=1;
        [_faca setTransform:CGAffineTransformMakeTranslation(0, -50)];
        [_garfo setTransform:CGAffineTransformMakeTranslation(0, 50)];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(loadTabBarController)
                   withObject:nil
                   afterDelay:0.3];
    }];
    
    
    
    
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
