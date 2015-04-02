//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "../Persistencia/CoreDataPersistence.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/Alimento.h"
#import "../Entidades/RefeicoesAlimento.h"
#import "DiaTableViewController.h"
#import "ComidasTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NutriApp";
    
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    if([useDef valueForKey:@"limiteNutricao"]==nil){
        [useDef setValue:[NSNumber numberWithInt:0] forKey:@"tipoNutricao"];
        [useDef setValue:[NSNumber numberWithInt:-1] forKey:@"limiteNutricao"];
    }

    NSLog(@"Tipo selecionado: %@,  limite selecionado %@",[useDef valueForKey:@"tipoNutricao"],[useDef valueForKey:@"limiteNutricao"]);

    _scrollGrafico.contentSize = CGSizeMake(kDefaultGraphWidth, 300);
//    float dados[] = {0.7, 0.4, 0.5, 0.7, 0.7, 0.4, 0.5, 0.7, 0.67, 0.81, 0.76, 0.9, 1.0, 0.33, 0.85, 0.41, 0.75};
//    NSMutableArray *dados2 = [[NSMutableArray alloc]init];

    
//    float dadosLength = sizeof(dados)/sizeof(dados[0]);
//
//    for(int i=0; i<dadosLength; i++){
//        [dados2 addObject:[NSNumber numberWithFloat:dados[i] ]];
//    }

//    _em = [EntityManager sharedInstance];
//    [_em loadDatabase:@"alimento.db"];
//    HistoricoDAO *dao = [[HistoricoDAO alloc] init];
//    NSArray *r = [dao getAllData];
//    for(Historico *a in r){
//        NSLog(@"%d, %@, %lu",a.codigo, a.data, (unsigned long)[a.alimentos count]);
//        for(Alimento *ali in a.alimentos){
//            NSLog(@"%d, %d, %@",ali.id_alimeanto, ali.id_categoria, ali.descricao);
//        }
//    }

    CoreDataPersistence *cdp = [CoreDataPersistence sharedInstance];
    [cdp dbInit];

    NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"alimento" ofType:@"db"]);
    
    
    
    


}

-(void)viewDidAppear:(BOOL)animated{
    [_graficoView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidLayoutSubviews{
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (IBAction)salvarOMundo:(id)sender {
    
//    CoreDataPersistence *cdp = [CoreDataPersistence sharedInstance];
//
//    Refeicoes *refeicao = [NSEntityDescription insertNewObjectForEntityForName:@"Refeicoes" inManagedObjectContext:[cdp managedObjectContext]];
//
//    RefeicoesAlimento *ra = [NSEntityDescription insertNewObjectForEntityForName:@"RefeicoesAlimento" inManagedObjectContext:[cdp managedObjectContext]];
//
//    Alimento *a = [[cdp fetchDataForEntity:@"Alimento" usingPredicate:[NSPredicate predicateWithFormat:@"descricao CONTAINS[c] 'Batata'"]] firstObject];
//
//    refeicao.nome = @"Refeição 01";
//
//    ra.quantidade = @2;
//    ra.contains = a;
//
//    [a addIgredientOfObject:ra];
//
//    [refeicao addContainsObject:ra];
//    ra.partOf = refeicao;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
//    refeicao.data = [formatter dateFromString:@"31/03/2015 00:00"];
//    refeicao.tipoRefeicao = REFEICAO_CAFEMANHA;
//
//    [cdp saveContext];

    [self.navigationController pushViewController:[[DiaTableViewController alloc]init] animated:YES];
}
@end
