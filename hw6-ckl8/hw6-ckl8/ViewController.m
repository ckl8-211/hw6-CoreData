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
#import "TodoItem.h"
#import "TodoList.h"
#import "Item.h"

@interface ViewController () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>
@property (weak) IBOutlet NSButtonCell *addItem;

@property (weak) IBOutlet NSTextField *inputTextField;


@property (weak) IBOutlet NSTableView *tableView;
@property (strong, nonatomic) TodoList *list;
@property (strong, nonatomic) NSManagedObjectContext *moc;
@property (strong, nonatomic) NSArray *items;
@end
@implementation ViewController

-(CoreDataStackConfiguration*)mainConfig
{
    CoreDataStackConfiguration *config =
    [CoreDataStackConfiguration configurationWithStoreType:NSSQLiteStoreType
                                                 modelName:@"Inventory"
                                             appIdentifier:@"rlam.ckl8.hw6"
                                 dataFileNameWithExtension:@"Data.sqlite"
                                       searchPathDirectory:NSApplicationSupportDirectory];
    return config;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _list = [[TodoList alloc] initWithTitle:@"Craigslist List"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 1. create core data stack
    // 2. get moc
    ConfigurableCoreDataStack *stack = [ConfigurableCoreDataStack stackWithConfiguration:[self mainConfig]];
    self.moc = [stack managedObjectContext];
    // 3. make a fetch request
    NSFetchRequest *usrRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    // 4. execute fetch request
    NSArray *fetchItems = [self.moc executeFetchRequest:usrRequest error:nil];
    self.items = fetchItems;
    for  ( NSManagedObject *mitems in fetchItems ) {
        NSLog(@"fetched item title %@", [mitems valueForKey:@"title"]);
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)addItem:(id)sender {
    
    
    [self tryToInsertNewItem];
    
}
-(TodoItem*)todoItemFromCurrentInput
{
    TodoItem *todoItem = [TodoItem todoItemWithTitle:self.inputTextField.stringValue];
    Item *itemObject = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.moc];
    itemObject.title = todoItem.title;
    [self.moc save:nil];
    
    NSFetchRequest *usrRequest = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSArray *fetchItems = [self.moc executeFetchRequest:usrRequest error:nil];
    todoItem = [fetchItems valueForKey:@"title"];
    return (todoItem);
}
-(void)updateInterface
{
//    TodoItem *currentItem = [self todoItemFromCurrentInput];
//    self.addItem.enabled = [self.list canAddItem:currentItem];
    [self viewDidLoad];
    [self viewWillAppear]; // If viewWillAppear also contains code
    [self.tableView reloadData];

    
}
-(void)tryToInsertNewItem
{
    TodoItem *item = [self todoItemFromCurrentInput];
    if ([self.list canAddItem:item]) {
        [self.list addItem:item];
        
        // update table view
        NSUInteger nextRow = self.tableView.numberOfRows;
        NSIndexSet *nextRowSet = [NSIndexSet indexSetWithIndex:nextRow];
        [self.tableView insertRowsAtIndexes:nextRowSet withAnimation:NSTableViewAnimationSlideDown];
        
        // clear text input
    }
    
    [self updateInterface];
    
}

@end
