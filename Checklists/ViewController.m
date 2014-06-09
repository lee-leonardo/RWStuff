//
//  ViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/2/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
	NSMutableArray *_items;
}
#pragma mark - Saving Data
-(NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths firstObject];
	return documentsDirectory;
}

-(NSString *)dataFilePath
{
	return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklistItems
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:_items forKey:@"ChecklistItems"];
	[data writeToFile:[self dataFilePath] atomically:YES];
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSLog(@"Documents folder is %@", [self documentsDirectory]);
	NSLog(@"Data file is %@", [self dataFilePath]);
	
	_items = [[NSMutableArray alloc] initWithCapacity:20];
	
	ChecklistItem *item;
	
	item = [[ChecklistItem alloc] init];
	item.text = @"Walk the Dog.";
	item.checked = NO;
	[_items addObject:item];
	
	item = [[ChecklistItem alloc] init];
	item.text = @"Brush my Teeth";
	item.checked = YES;
	[_items addObject:item];

	
	item = [[ChecklistItem alloc] init];
	item.text = @"Learn iOS development";
	item.checked = YES;
	[_items addObject:item];

	
	item = [[ChecklistItem alloc] init];
	item.text = @"Soccer practice";
	item.checked = NO;
	[_items addObject:item];

	
	item = [[ChecklistItem alloc] init];
	item.text = @"Eat ice cream";
	item.checked = YES;
	[_items addObject:item];

}

#pragma mark - Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
	
	ChecklistItem *item = _items[indexPath.row];
	
	[self configureTextForCell:cell withChecklistItem:item];
	[self configureCheckmarkForCell:cell withChecklistItem:item];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	ChecklistItem *item = _items[indexPath.row];
	[item toggleChecked];
	
	[self configureCheckmarkForCell:cell withChecklistItem:item];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView Manipulation
#pragma mark Configure
-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
	UILabel *label = (UILabel *) [cell viewWithTag:1000];
	label.text = item.text;
}

-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
//	if (item.checked) {
//		cell.accessoryType = UITableViewCellAccessoryCheckmark;
//	} else {
//		cell.accessoryType = UITableViewCellAccessoryNone;
//	}
	UILabel *label = (UILabel *)[cell viewWithTag:1001];
	
	if (item.checked) {
		label.text = @"√";
	} else {
		label.text =@"";
	}
}
//#pragma mark Add Item
//-(IBAction)addItem
//{
//	NSInteger newRowIndex = [_items count];
//	
//	ChecklistItem *item = [[ChecklistItem alloc] init];
//	item.text = @"New Row";
//	item.checked = NO;
//	[_items addObject:item];
//	
////	Makes an indexPath item, which is put into an array, then the table is refreshed accordingly.
//	NSIndexPath *indexPath = [NSIndexPath indexPathForItem:newRowIndex inSection:0];
//	NSArray *indexPaths = @[indexPath];
//	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark Delete Item
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[_items removeObjectAtIndex:indexPath.row];
	
	NSArray *indexPaths = @[indexPath];
	[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - ItemDetailViewControllerDelegate
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
	NSInteger newRowIndex = [_items count];
	[_items addObject:item];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	[self saveChecklistItems];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
	NSInteger index = [_items indexOfObject:item];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	[self configureTextForCell:cell withChecklistItem:item];
	[self saveChecklistItems];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddItem"]) {
//		1
		UINavigationController *navigationController = segue.destinationViewController;
//		2
		ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
//		3
		controller.delegate = self;
		
	} else if ([segue.identifier isEqualToString:@"EditItem"]) {
		UINavigationController *navigationController = segue.destinationViewController;
		
		ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
		
		controller.delegate = self;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		controller.itemToEdit = _items[indexPath.row];
	}
}

@end





