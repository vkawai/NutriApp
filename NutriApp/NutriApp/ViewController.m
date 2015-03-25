//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "Persistencia/HistoricoDAO.h"
#import "Persistencia/AlimentoDAO.h"
#import "Entidades/Historico.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _em = [EntityManager sharedInstance];
    [_em loadDatabase:@"alimento.db"];
    AlimentoDAO *dao = [[AlimentoDAO alloc] init];
    NSArray *r = [dao getAllData];
    for(Alimento *a in r){
        NSLog(@"%d, %d, %@",a.id_alimento, a.id_categoria, a.descricao);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)salvarOMundo:(id)sender {
    bool certo = [_em changeData:@"INSERT INTO historico(id_historico,data) VALUES (101, 'hoje');"];
    NSLog(@"%d",certo);
}
@end
