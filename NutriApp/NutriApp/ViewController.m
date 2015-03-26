//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "Persistencia/AlimentoDAO.h"
#import "Entidades/Historico.h"
#import "Persistencia/HistoricoDAO.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)salvarOMundo:(id)sender {
    bool certo = [_em changeData:@"INSERT INTO historico(id_historico,data) VALUES (101, '01/01/1990');"];
    NSLog(@"%d",certo);
    certo = [_em changeData:@"INSERT INTO alimento_historico VALUES (101, 1, 40);"];
    NSLog(@"%d",certo);
    certo = [_em changeData:@"INSERT INTO alimento_historico VALUES (101, 2, 40);"];
    NSLog(@"%d",certo);
}
@end
