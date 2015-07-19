//
//  ViewController.m
//  ShoppingList
//
//  Created by NP ECE BME Centre on 19/7/15.
//  Copyright (c) 2015 NP ECE BME Centre. All rights reserved.
//

#import "ViewController.h"
#import "InventoryList.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property NSMutableArray *itemsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"InventoryList" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    //[self.itemsArray removeAllObjects];
    self.itemsArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:nil]];
}

// Default Method to be called upon for TableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemsArray.count;
}

// Default Method to be called upon for TableView
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    NSManagedObject *fetchedObject = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [fetchedObject valueForKey:@"name"];
    
    return cell;
}

- (IBAction)onSaveButtonPressed:(UIButton *)sender {
    
    NSManagedObject *inventoryList = [NSEntityDescription insertNewObjectForEntityForName:@"InventoryList" inManagedObjectContext:self.managedObjectContext];
    
    [inventoryList setValue:self.itemTextField.text forKey:@"name"];
    
    [self.managedObjectContext save:Nil];
    
    [self.itemsArray addObject:inventoryList];
    
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
