//
//  AllListsViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/9/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "AllListsViewController.h"
#import "ChecklistViewController.h"
#import "Checklist.h"
#import "ChecklistItem.h"
#import "DataModel.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController
//{
//	NSMutableArray *_lists;
//}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	self.navigationController.delegate = self;
	
//	NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
//	
//	if (index != -1) {
//		Checklist *checklist = self.dataModel.lists[index];
//		[self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
//	}
	NSInteger index = [self.dataModel indexOfSelectedChecklist];
	if (index >= 0 && index < [self.dataModel.lists count]) { //Defensive programming, because it protects the app defaults from calling a nonexistent object.
		Checklist *checklist = self.dataModel.lists[index];
		[self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
	}
//	cell.textLabel.text = [NSString stringWithFormat:@"List %d", indexPath.row];
	Checklist *checklist = self.dataModel.lists[indexPath.row];
	cell.textLabel.text = checklist.name;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"ChecklistIndex"];
	[self.dataModel setIndexOfSelectedChecklist:indexPath.row];
	Checklist *checklist = self.dataModel.lists[indexPath.row];
	[self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
		ChecklistViewController *controller = segue.destinationViewController;
		controller.checklist = sender;
	} else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
		UINavigationController *navigationController = segue.destinationViewController;
		ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
		
		controller.delegate = self;
		controller.checklistToEdit = nil;
	}
}

//#pragma mark - Loading and Saving
//-(NSString *)documentsDirectory
//{
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths firstObject];
//	return documentsDirectory;
//}
//-(NSString *)dataFilePath
//{
//	return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
//}
//-(void)saveChecklists
//{
//	NSMutableData *data = [[NSMutableData alloc] init];
//	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//	[archiver encodeObject:_lists forKey:@"Checklists"];
//	[archiver finishEncoding];
//	[data  writeToFile:[self dataFilePath] atomically:YES];
//}
//-(void)loadChecklists
//{
//	NSString *path = [self dataFilePath];
//	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//		NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//		_lists = [unarchiver decodeObjectForKey:@"Checklists"];
//		[unarchiver finishDecoding];
//	} else {
//		_lists = [[NSMutableArray alloc] initWithCapacity:20];
//	}
//}

//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//	if((self = [super initWithCoder:aDecoder])) {
//		[self loadChecklists];
////		_lists = [[NSMutableArray alloc] initWithCapacity:20];
////		
////		Checklist *list;
////		
////		list = [[Checklist alloc] init];
////		list.name = @"Birthdays";
////		[_lists addObject:list];
////		
////		list = [[Checklist alloc] init];
////		list.name = @"Groceries";
////		[_lists addObject:list];
////		
////		list = [[Checklist alloc] init];
////		list.name = @"Cool Apps";
////		[_lists addObject:list];
////		
////		list = [[Checklist alloc] init];
////		list.name = @"To Do";
////		[_lists addObject:list];
////		
////		for (Checklist *list in _lists) {
////			ChecklistItem *item = [[ChecklistItem alloc] init];
////			item.text =[NSString stringWithFormat:@"Item for %@", list.name];
////			[list.items addObject:item];
////		}
//	}
//	return self;
//}

#pragma mark - Delegate
-(void)listDetailviewControllerDidCancel:(ListDetailViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishAddingChecklists:(Checklist *)checklist
{
	NSInteger newRowIndex = [self.dataModel.lists count];
	[self.dataModel.lists addObject:checklist];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishEditingChecklists:(Checklist *)checklist
{
	NSInteger index = [self.dataModel.lists indexOfObject:checklist];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	cell.textLabel.text = checklist.name;
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.dataModel.lists removeObjectAtIndex:indexPath.row];
	
	NSArray *indexPaths = @[indexPath];
	[self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
	ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
	controller.delegate = self;
	
	Checklist *checklist = self.dataModel.lists[indexPath.row];
	controller.checklistToEdit = checklist;
	[self presentViewController:navigationController animated:YES completion:nil];
	
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (viewController == self) {
//		[[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"ChecklistIndex"];
		[self.dataModel setIndexOfSelectedChecklist:-1];
	}
}

@end





