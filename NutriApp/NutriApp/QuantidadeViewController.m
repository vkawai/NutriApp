//
//  QuantidadeViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 4/4/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "QuantidadeViewController.h"
#import "HojeSingleton.h"
#import "Alimento.h"
#import "CoreDataPersistence.h"

@interface QuantidadeViewController ()

@end

@implementation QuantidadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nomeAlimento.text = [HojeSingleton sharedInstance].thisAlimento.descricao;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textoQuant resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmar:(id)sender {
    Alimento *esteAlimento = [HojeSingleton sharedInstance].thisAlimento;
    RefeicoesAlimento *refeicaoAlimento = [NSEntityDescription insertNewObjectForEntityForName:@"RefeicoesAlimento" inManagedObjectContext:[[CoreDataPersistence sharedInstance] managedObjectContext]];
    
    [esteAlimento addIgredientOfObject:refeicaoAlimento];
    [refeicaoAlimento setAlimento:esteAlimento];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *quant = [formatter numberFromString:_textoQuant.text];
    [refeicaoAlimento setQuantidade:quant];
    
    NSLog(@"NUMERO DA REFEICAO: %d",[[HojeSingleton sharedInstance]numeroRefeicao]);
    [[[HojeSingleton sharedInstance].historicoDoDia objectAtIndex:[HojeSingleton sharedInstance].numeroRefeicao] addObject:refeicaoAlimento];
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
