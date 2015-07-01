//
//  ComidasTableViewController.m
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "ComidasTableViewController.h"
#import "QuantidadeViewController.h"
#import "NovoAlimentoViewController.h"
#import "../Entidades/Alimento.h"
#import "../Entidades/Refeicoes.h"
#import "../Entidades/RefeicoesAlimento.h"
#import "../Entidades/GrupoAlimento.h"
#import "../Business/HojeSingleton.h"
#import "../Persistencia/CoreDataPersistence.h"

@interface ComidasTableViewController ()

@end

@implementation ComidasTableViewController

NSMutableArray *tudo2;
NSMutableArray *tudoFormatado;
NSMutableArray *selected;
CoreDataPersistence *coreData;

UISearchBar *textoBusca;
UIButton *botaoBusca;

-(instancetype)initWithRefeicao:(int)numRefeicao{
    self = [super init];
    if(self){
        _num=numRefeicao;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HojeSingleton sharedInstance] loadTodayData];
    
    //inicializacao da table view - a classe agora é um view controller apenas, para poder ter a search bar
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.view addSubview:_tableView];
    
    //topo da tela que conterá a text bar e o botao de busca
    textoBusca = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 55)];
    textoBusca.placeholder = @"Buscar alimentos";
    textoBusca.delegate = self;

    [self.view addSubview:textoBusca];
    
//    botaoBusca = [UIButton buttonWithType:UIButtonTypeSystem];
//    [botaoBusca setTitle:@"Buscar" forState:UIControlStateNormal];
//    [botaoBusca addTarget:self action:@selector(buscar:) forControlEvents:UIControlEventTouchDown];
//    botaoBusca.frame = CGRectMake(self.view.frame.size.width-90, 70, 80, 40);
//    
//    [self.view addSubview:botaoBusca];
    
    
    coreData = [CoreDataPersistence sharedInstance];
    //CARREGA ESSE TAL DESSE TUDO2 COM TODOS OS ALIMENTOS, DE PREFERENCIA COM O NOME DA CATEGORIA JA COLOCADO LA
//
//    [self fetchDataWithPredicate:nil];

//    tudoFormatado = [[NSMutableArray alloc]init];
//    GrupoAlimento *cur = nil;
//    for(Alimento *a in tudo2){
//        if(a.categoria != cur){
//            cur = a.categoria;
//            [tudoFormatado addObject:[[NSMutableArray alloc]init]];
//        }
//        [[tudoFormatado lastObject]addObject:a];
//    }
//    
//    [self.tableView setSectionHeaderHeight:20];
//    
//    switch(_num){
//        case 0:
//            self.navigationItem.title = @"Cafe da manha";
//            break;
//        case 1:
//            self.navigationItem.title = @"Almoco";
//            break;
//        case 2:
//            self.navigationItem.title = @"Lanche";
//            break;
//        default:
//            self.navigationItem.title = @"Janta";
//            break;
//    }
}

-(void)fetchDataWithPredicate:(NSPredicate *)predicate{
    CoreDataPersistence *coreData = [CoreDataPersistence sharedInstance];

    NSArray *buffer = [[coreData fetchDataForEntity:@"GrupoAlimento" usingPredicate:nil] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(GrupoAlimento *)obj1 nomeGrupo] compare:[(GrupoAlimento *)obj2 nomeGrupo]];
    }];


    tudo2 = [[NSMutableArray alloc]init];

    for(GrupoAlimento *ga in buffer){
        NSArray *aux;
        if(predicate != nil){
            aux = [[[[ga contemAlimento] filteredSetUsingPredicate:predicate] allObjects] sortedArrayUsingComparator:^NSComparisonResult(Alimento *obj1, Alimento *obj2) {
                return [[obj1 descricao] compare:[obj2 descricao]];
            }];
        }
        else{
            aux = [[[ga contemAlimento] allObjects] sortedArrayUsingComparator:^NSComparisonResult(Alimento *obj1, Alimento *obj2) {
                return [[obj1 descricao] compare:[obj2 descricao]];
            }];
        }
        [tudo2 addObjectsFromArray:aux];
    }

    tudoFormatado = [[NSMutableArray alloc]init];
    GrupoAlimento *cur = nil;
    for(Alimento *a in tudo2){
        if(a.categoria != cur){
            cur = a.categoria;
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

-(void)viewWillAppear:(BOOL)animated{
    //PREENCHER OS ARRAYS COM OS DADOS DO BD
    //[[HojeSingleton sharedInstance] loadTodayData];

	if([textoBusca.text isEqual: @""]){
		[self fetchDataWithPredicate:[NSPredicate predicateWithFormat:nil]];
	}
	else{
		[self fetchDataWithPredicate:[NSPredicate predicateWithFormat:@"descricao BEGINSWITH[c] %@",textoBusca.text]];
	}
}

-(void)viewWillDisappear:(BOOL)animated{
    [[HojeSingleton sharedInstance] saveMeals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textoBusca resignFirstResponder];
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Voce buscou por: %@",searchBar.text);
    [textoBusca resignFirstResponder];

    if([searchBar.text isEqual: @""]){
        [self fetchDataWithPredicate:[NSPredicate predicateWithFormat:nil]];
    }
    else{
        [self fetchDataWithPredicate:[NSPredicate predicateWithFormat:@"descricao BEGINSWITH[c] %@",searchBar.text]];
    }

    [_tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"Voce buscou por: %@",searchBar.text);
    if([searchBar.text isEqual: @""]){
        [self fetchDataWithPredicate:[NSPredicate predicateWithFormat:nil]];
    }
    else{
        [self fetchDataWithPredicate:[NSPredicate predicateWithFormat:@"descricao BEGINSWITH[c] %@",searchBar.text]];
    }

    [_tableView reloadData];
    
}

-(void)saveFood{
    [self.navigationController pushViewController:[[NovoAlimentoViewController alloc]init] animated:YES];
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
    if([[tudoFormatado objectAtIndex:section]count]>0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 2, tableView.frame.size.width, 18)];
        [label setFont:[UIFont boldSystemFontOfSize:12]];
        label.textColor = [UIColor whiteColor];
        NSString *tituloSection = [[[[tudoFormatado objectAtIndex:section] firstObject] categoria] nomeGrupo];
        [label setText:NSLocalizedString(tituloSection, nil)];
        [header addSubview:label];
        [header setBackgroundColor:[UIColor colorWithRed:.15 green:.48 blue:.8 alpha:1]];
    }
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
//    NSLog(@"%@", esteAlimento.descricao);

    [HojeSingleton sharedInstance].thisAlimento = esteAlimento;
    [HojeSingleton sharedInstance].numeroRefeicao = _num;
    
    [textoBusca resignFirstResponder];
    
    
    [self.navigationController pushViewController:[[QuantidadeViewController alloc]init] animated:YES];

//    RefeicoesAlimento *refeicaoAlimento = [NSEntityDescription insertNewObjectForEntityForName:@"RefeicoesAlimento" inManagedObjectContext:[coreData managedObjectContext]];
//
//    [esteAlimento addIgredientOfObject:refeicaoAlimento];
//    [refeicaoAlimento setAlimento:esteAlimento];
//
//    [[[HojeSingleton sharedInstance].historicoDoDia objectAtIndex:_num] addObject:refeicaoAlimento];
    [selected addObject:indexPath];
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
