//
//  CoreDataPersistence.m
//  NutriApp
//
//  Created by Vitor Kawai Sala on 28/03/15.
//  Copyright (c) 2015 Vitor Kawai Sala. All rights reserved.
//

#import "CoreDataPersistence.h"
#import "PersistenceInit.h"
@implementation CoreDataPersistence

static id instance;

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        instance = [[CoreDataPersistence alloc] init];
        [instance managedObjectContext];
        [instance managedObjectModel];
        [instance persistentStoreCoordinator];

    });
    return instance;
}

//BULLSHITAGEM
//-(void)insertNewEntity:(NSManagedObject *)entity{
//    if([entity entity] == nil){
//        Class class = [entity class];
//
//        NSString *entityName = NSStringFromClass([entity class]);
//        unsigned count;
//        objc_property_t *propertyList = class_copyPropertyList(class, &count);
//
//        NSEntityDescription *description = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
//
//        id obj = [[NSClassFromString(entityName) alloc] initWithEntity:description insertIntoManagedObjectContext:[self managedObjectContext]];
//
//        for(int i = 0 ; i < count ; i++){
//            NSString *property = [NSString stringWithUTF8String:property_getName(propertyList[i])];
//            [obj setValue:[entity valueForKey:property] forKey:property];
//        }
//
//    }
//    [self saveContext];
//}

-(void) dbInit{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults objectForKey:@"isFirstExec"] == nil){
        [defaults setValue:@1 forKey:@"isFirstExec"];
        PersistenceInit *pinit = [PersistenceInit sharedInstance];
        [pinit fillCoreDataDatabase];
    }
}

-(NSArray *)fetchDataForEntity:(NSString *)entity usingPredicate:(NSPredicate *)predicate{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setPredicate:predicate];
    NSEntityDescription *description = [NSEntityDescription entityForName:entity inManagedObjectContext:[self managedObjectContext]];
    [request setEntity:description];

    NSError *error;
    NSArray *resultSet = [[self managedObjectContext] executeFetchRequest:request error:&error];

    if(error){
        NSLog(@"Error %ld: %@",(long)[error code], [error description]);
        return nil;
    }

    return resultSet;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "vkawai.NutriApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NutriApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NutriApp.sqlite"];

    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
