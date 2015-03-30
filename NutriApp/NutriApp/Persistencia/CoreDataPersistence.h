//
//  CoreDataPersistence.h
//  NutriApp
//
//  Created by Vitor Kawai Sala on 28/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataPersistence : NSObject

+(instancetype)sharedInstance;


#pragma mark - CoreData
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) dbInit;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)fetchDataForEntity:(NSString *)entity usingPredicate:(NSPredicate *)predicate;

@end
