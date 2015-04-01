//
//  DiaTableViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "DiaTableViewController.h"
#import "Alimento.h"
#import "ComidasTableViewController.h"
#import "../Business/HojeSingleton.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/RefeicoesAlimento.h"
#import "../Persistencia/CoreDataPersistence.h"

@interface DiaTableViewController ()

@end

@implementation DiaTableViewController


NSMutableArray *tudo;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(saveMeal)];
    self.navigationItem.rightBarButtonItem = btn;

    //PREENCHER OS ARRAYS COM OS DADOS DO BD
    tudo = [HojeSingleton sharedInstance].historicoDoDia;
    
    [self.tableView setSectionHeaderHeight:20];
    
    
    self.navigationItem.title = @"Refeicoes";
    
    float totalCalorias = 0.0;
//    for(NSMutableArray *lista in tudo){
//        if([lista count] > 0){
//            for(Refeicoes *refeicao in lista){
//                totalCalorias += [refeicao caloria];
//            }
//        }
//    }
    for(int section = 0; section < [tudo count]; section++){
        for(int i = 0; i < [[tudo objectAtIndex:section] count]; i++){
            RefeicoesAlimento *refeicao = [[tudo objectAtIndex:section] objectAtIndex:i];
            totalCalorias += [[refeicao.contains energia] floatValue];
        }

    }
    NSLog(@"TOTAL DE CALORIAS: %f kcal",totalCalorias);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[HojeSingleton sharedInstance] saveMeals];

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tudo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [[tudo objectAtIndex:section] count];
    return [[tudo objectAtIndex:section] count] + 1;
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
    [header setBackgroundColor:[UIColor grayColor]];
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    
    if([indexPath row] == [self tableView:[self tableView] numberOfRowsInSection:indexPath.section]-1){
        cell.textLabel.text = @"Adicionar novo alimento...";
        
    }
    else{
        RefeicoesAlimento *r = [[tudo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = r.contains.descricao;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kcal", [[r.contains energia] floatValue]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == [[tudo objectAtIndex:indexPath.section] count]){
        [self.navigationController pushViewController:[[ComidasTableViewController alloc]initWithRefeicao:(int)indexPath.section] animated:YES];

    }
}

-(void)saveMeal{
    [[HojeSingleton sharedInstance] saveMeals];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
