//
//  ComidasTableViewController.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/26/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComidasTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property int num;
@property UITableView *tableView;

-(instancetype)initWithRefeicao:(int)numRefeicao;

@end
