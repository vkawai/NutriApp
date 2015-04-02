//
//  ConfigViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/30/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarItem.selectedImage =[UIImage imageNamed:@"User Male Circle Filled-32"];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_limiteText resignFirstResponder];
}

- (IBAction)salvar:(id)sender {
    NSError *erroRegex=nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:&erroRegex];
    
    if(![regex numberOfMatchesInString:_limiteText.text options:0 range:NSMakeRange(0, _limiteText.text.length)]){
        UIAlertView *termoInvalido = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Termo inválido!",nil) message:NSLocalizedString(@"Por favor, insira apenas números inteiros.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [termoInvalido show];
        return;
    }
    NSLog(@"Voce escolheu um limite de %@ do tipo %ld",_limiteText.text, (long)_tipoSelector.selectedSegmentIndex);
    
    //guarda as configs do usuario no userDefault
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    [useDef setValue:[NSNumber numberWithLong:_tipoSelector.selectedSegmentIndex] forKey:@"tipoNutricao"];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *limiteNum = [f numberFromString:_limiteText.text];
    [useDef setValue:limiteNum forKey:@"limiteNutricao"];
    NSLog(@"SALVO");
    
}

- (IBAction)limpar:(id)sender {
    _limiteText.text = @"";
}
@end
