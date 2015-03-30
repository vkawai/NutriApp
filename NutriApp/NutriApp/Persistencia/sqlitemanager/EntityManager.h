

//  EntityManager.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 25/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface EntityManager : NSObject

@property NSString *path;
@property sqlite3 *sqlite;

+(instancetype)sharedInstance;

-(void)loadDatabase:(NSString *)dataBaseName;
-(BOOL)changeData:(NSString *)query;
-(NSArray *)getData:(NSString *)query andBlk:(id (^)(sqlite3_stmt *stmt))blk;
-(NSNumber *)nextIdForTable:(NSString *)tableName withIdName:(NSString *)idName;
@end
