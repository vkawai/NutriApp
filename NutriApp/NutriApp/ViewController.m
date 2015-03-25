//
//  ViewController.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 24/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ViewController.h"
#import "Persistencia/HistoricoDAO.h"
#import "Entidades/Historico.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _em = [EntityManager sharedInstance];
    [_em loadDatabase:@"alimento.db"];
    HistoricoDAO *dao = [[HistoricoDAO alloc] init];
    NSArray *r = [dao getAllData];
    for(Historico *h in r){
        NSLog(@"%d\n",h.codigo);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)salvarOMundo:(id)sender {
    bool certo = [_em saveData:@"INSERT INTO historico(id_historico,data) VALUES (101, 'hoje');"];
    NSLog(@"%d",certo);
}
@end
