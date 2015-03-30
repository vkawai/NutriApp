//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataPersistence.h"
#import "Entidades/Historico.h"
#import "DiaTableViewController.h"
#import "ComidasTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollGrafico.contentSize = CGSizeMake(kDefaultGraphWidth, kGraphHeight);
    float dados[] = {0.7, 0.4, 0.5, 0.7, 0.7, 0.4, 0.5, 0.7, 0.67, 0.81, 0.76, 0.9, 1.0, 0.33, 0.85, 0.41, 0.75};
    NSMutableArray *dados2 = [[NSMutableArray alloc]init];
    
    
    float dadosLength = sizeof(dados)/sizeof(dados[0]);
    
    for(int i=0; i<dadosLength; i++){
        [dados2 addObject:[NSNumber numberWithFloat:dados[i] ]];
    }
    _graficoView = [[GraficoView alloc]initWithDados:dados2];
    
    _em = [EntityManager sharedInstance];
    [_em loadDatabase:@"alimento.db"];
    HistoricoDAO *dao = [[HistoricoDAO alloc] init];
    NSArray *r = [dao getAllData];
    for(Historico *a in r){
        NSLog(@"%d, %@, %lu",a.codigo, a.data, (unsigned long)[a.alimentos count]);
        for(Alimento *ali in a.alimentos){
            NSLog(@"%d, %d, %@",ali.id_alimento, ali.id_categoria, ali.descricao);
        }
    }

    CoreDataPersistence *cdp = [CoreDataPersistence sharedInstance];
    [cdp dbInit];

    NSLog(@"%@",[[NSBundle mainBundle] pathForResource:@"alimento" ofType:@"db"]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)salvarOMundo:(id)sender {
//    bool certo = [_em changeData:@"INSERT INTO historico(id_historico,data) VALUES (101, 'hoje');"];
//    NSLog(@"%d",certo);
//    certo = [_em changeData:@"INSERT INTO alimento_historico VALUES (101, 1, 40);"];
//    NSLog(@"%d",certo);
//    certo = [_em changeData:@"INSERT INTO alimento_historico VALUES (101, 2, 40);"];
//    NSLog(@"%d",certo);
    [self.navigationController pushViewController:[[DiaTableViewController alloc]init] animated:YES];
}
@end
