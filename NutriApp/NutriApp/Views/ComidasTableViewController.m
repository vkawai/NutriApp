//
//  ComidasTableViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ComidasTableViewController.h"
#import "../Entidades/Alimento.h"
#import "../Business/HojeSingleton.h"
#import "../Persistencia/CoreDataPersistence.h"

@interface ComidasTableViewController ()

@end

@implementation ComidasTableViewController

NSArray *tudo2;
NSMutableArray *tudoFormatado;

-(instancetype)initWithRefeicao:(int)numRefeicao{
    self = [super init];
    if(self){
        _num=numRefeicao;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    //CARREGA ESSE TAL DESSE TUDO2 COM TODOS OS ALIMENTOS, DE PREFERENCIA COM O NOME DA CATEGORIA JA COLOCADO LA

    CoreDataPersistence *coreData = [CoreDataPersistence sharedInstance];
    tudo2 = [coreData fetchDataForEntity:@"Alimento" usingPredicate:nil];
    tudoFormatado = [[NSMutableArray alloc]init];
    GrupoAlimento *cur = nil;
    for(Alimento *a in tudo2){
        if(a.partOf != cur){
            cur = a.partOf;
            [tudoFormatado addObject:[[NSMutableArray alloc]init]];
        }
        [[tudoFormatado lastObject]addObject:a];
    }
    
    [self.tableView setSectionHeaderHeight:20];
    
    switch(_num){
        case 0:
            self.navigationItem.title = @"Cafe da manha";
            break;
        case 1:
            self.navigationItem.title = @"Almoco";
            break;
        case 2:
            self.navigationItem.title = @"Lanche";
            break;
        default:
            self.navigationItem.title = @"Janta";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return tudoFormatado.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[tudoFormatado objectAtIndex:section]count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -20, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *tituloSection = [[[[tudoFormatado objectAtIndex:section]firstObject]partOf]nomeGrupo];
    [label setText:NSLocalizedString(tituloSection, nil)];
    [header addSubview:label];
    [header setBackgroundColor:[UIColor grayColor]];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    
    cell.textLabel.text = [[[tudoFormatado objectAtIndex:[indexPath section] ]objectAtIndex:indexPath.row] descricao];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", [[[[tudoFormatado objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] energia] floatValue]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Alimento *esteAlimento = [[tudoFormatado objectAtIndex:[indexPath section]]objectAtIndex:indexPath.row];
    NSLog(@"%@", esteAlimento.descricao);
    [[[HojeSingleton sharedInstance].historicoDoDia objectAtIndex:_num] addObject:esteAlimento];
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
