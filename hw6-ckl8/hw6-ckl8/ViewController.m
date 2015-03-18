//
//  ViewController.m
//  hw6-ckl8
//
//  Created by rlam on 3/12/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import "ViewController.h"
@import CoreData;
#import "ConfigurableCoreDataStack.h"
#import "CoreDataStackConfiguration.h"
@interface ViewController ()
@property (weak) IBOutlet NSButtonCell *addItem;

@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *items;
@end
@implementation ViewController
-(CoreDataStackConfiguration*)mainConfig
{
    CoreDataStackConfiguration *config =
    [CoreDataStackConfiguration configurationWithStoreType:NSSQLiteStoreType
                                                 modelName:@"Inventory"
                                             appIdentifier:@"rlam.ckl8"
                                 dataFileNameWithExtension:@"Data.sqlite"
                                       searchPathDirectory:NSApplicationSupportDirectory];
    
    return config;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. create core data stack
    // 2. get moc
    ConfigurableCoreDataStack *stack = [ConfigurableCoreDataStack stackWithConfiguration:[self mainConfig]];
    self.moc = [stack managedObjectContext];
    
    
    // 3. make a fetch request
    NSFetchRequest *usrRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    // 4. execute fetch request
    NSArray *fetchItems = [self.moc executeFetchRequest:usrRequest error:nil];
    self.items = fetchItems;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
