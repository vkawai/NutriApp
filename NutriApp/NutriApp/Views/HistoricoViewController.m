//
//  HistoricoViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/30/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "HistoricoViewController.h"
#import "../Business/HojeSingleton.h"
#import "../Entidades/Alimento.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/RefeicoesAlimento.h"

@interface HistoricoViewController ()

@end

NSMutableArray *historicoDia;

@implementation HistoricoViewController

#pragma view Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.selectedImage =[UIImage imageNamed:@"Watch Filled-32"];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.calendarioView calendarView];
    
    //MAGIA PARA CARREGAR OS DADOS DO DIA ESCOLHIDO NO CALENDARIO
    //el señor placeholder
    self.calendarioView.selectedDay=self.calendarioView.today;// garante que o dia selecionado é o today
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dateUpdated:)
                                                 name:@"DateUpdated"
                                               object:nil];

    [self updateData:_calendarioView.selectedDay];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    _textoTipo.text = @"Total de calorias: ";
    float totalCalorias = 0.0;
    for(Refeicoes *r in historicoDia){
        for(RefeicoesAlimento *ra in r){
            totalCalorias += [[ra.alimento energia]floatValue];
        }
    }
    _labelValorTotal.text = [NSString stringWithFormat:@"%.2f",totalCalorias];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return historicoDia.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[historicoDia objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    if (section == 0){
        [label setText:NSLocalizedString(@"Café da manha", nil)];
    }
    if (section == 1){
        [label setText:NSLocalizedString(@"Almoço", nil)];
    }
    if (section == 2){
        [label setText:NSLocalizedString(@"Lanche", nil)];
    }
    if (section == 3){
        [label setText:NSLocalizedString(@"Jantar", nil)];
    }
    [header addSubview:label];
    [header setBackgroundColor:[UIColor colorWithRed:.15 green:.48 blue:.8 alpha:1]];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];

    RefeicoesAlimento *r = [[historicoDia objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = r.alimento.descricao;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kcal", [[r.alimento energia] floatValue]];

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dateUpdated:(NSNotification *)notification{
    NSLog(@"%@",[notification object]);
    [self updateData:[notification object]];
    [_tableView reloadData];
    
}

-(void)updateData:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    formatter.dateFormat=@"dd/MM/yyyy";
    [[HojeSingleton sharedInstance] loadPastData:[formatter stringFromDate:date]];
    historicoDia = [HojeSingleton sharedInstance].historicoDoDia;
}

@end

