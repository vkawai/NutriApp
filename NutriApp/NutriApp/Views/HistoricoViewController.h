//
//  HistoricoViewController.h
//  NutriApp
//
//  Created by Bruno Omella Mainieri on 3/30/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoricoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
