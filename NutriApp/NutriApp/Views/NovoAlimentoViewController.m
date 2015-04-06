//
//  NovoAlimentoViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 06/04/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "NovoAlimentoViewController.h"
#import "../Business/HojeSingleton.h"
#import "../Persistencia/CoreDataPersistence.h"
#import "../Entidades/GrupoAlimento.h"
@interface NovoAlimentoViewController (){

    HojeSingleton *singleton;
    CoreDataPersistence *persistence;
    NSArray *categorias;
    GrupoAlimento *theChosenOne;
}
@end

@implementation NovoAlimentoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    singleton = [HojeSingleton sharedInstance];
    persistence = [CoreDataPersistence sharedInstance];

    categorias = [persistence fetchDataForEntity:@"GrupoAlimento" usingPredicate:nil];
    [_picker setDelegate:self];
    [_picker setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Picker View
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [categorias count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[categorias objectAtIndex:row] nomeGrupo];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    theChosenOne = [categorias objectAtIndex:row];
}

#pragma mark - Navigation

- (IBAction)btnSalvar:(id)sender {
    Alimento *alimento = [NSEntityDescription insertNewObjectForEntityForName:@"Alimento" inManagedObjectContext:[persistence managedObjectContext]];

    alimento.descricao = _txtNome.text;
    alimento.umidade = 0;
    alimento.energia = [[NSNumberFormatter alloc]numberFromString: _txtEnergia.text];
    alimento.proteina = 0;
    alimento.lipideos = [[NSNumberFormatter alloc]numberFromString: _txtLipideos.text];
    alimento.colesterol = 0;
    alimento.carboidrato = [[NSNumberFormatter alloc]numberFromString: _txtCarboidrato.text];
    alimento.fibraAlimentar = 0;
    alimento.cinzas = 0;
    alimento.calcio = 0;
    alimento.magnesio = 0;
    alimento.manganes = 0;
    alimento.fosforo = 0;
    alimento.ferro = 0;
    alimento.sodio = 0;
    alimento.potassio = 0;
    alimento.cobre = 0;
    alimento.zinco = 0;
    alimento.retinol = 0;
    alimento.tiamina = 0;
    alimento.riboflavina = 0;
    alimento.piridoxina = 0;
    alimento.niacina = 0;
    alimento.vitaminaC = 0;

    [alimento setCategoria:theChosenOne];
    [theChosenOne addContemAlimentoObject:alimento];

    [persistence saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
