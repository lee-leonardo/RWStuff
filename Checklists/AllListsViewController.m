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

@interface AllListsViewController ()

@end

@implementation AllListsViewController
{
	NSMutableArray *_lists;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
	}
//	cell.textLabel.text = [NSString stringWithFormat:@"List %d", indexPath.row];
	Checklist *checklist = _lists[indexPath.row];
	cell.textLabel.text = checklist.name;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Checklist *checklist = _lists[indexPath.row];
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

#pragma mark - Decoder
-(id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super initWithCoder:aDecoder])) {
		_lists = [[NSMutableArray alloc] initWithCapacity:20];
		
		Checklist *list;
		
		list = [[Checklist alloc] init];
		list.name = @"Birthdays";
		[_lists addObject:list];
		
		list = [[Checklist alloc] init];
		list.name = @"Groceries";
		[_lists addObject:list];
		
		list = [[Checklist alloc] init];
		list.name = @"Cool Apps";
		[_lists addObject:list];
		
		list = [[Checklist alloc] init];
		list.name = @"To Do";
		[_lists addObject:list];
	}
	return self;
}

#pragma mark - Delegate
-(void)listDetailviewControllerDidCancel:(ListDetailViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishAddingChecklists:(Checklist *)checklist
{
	NSInteger newRowIndex = [_lists count];
	[_lists addObject:checklist];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishEditingChecklists:(Checklist *)checklist
{
	NSInteger index = [_lists indexOfObject:checklist];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	cell.textLabel.text = checklist.name;
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[_lists removeObjectAtIndex:indexPath.row];
	
	NSArray *indexPaths = @[indexPath];
	[self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
	ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
	controller.delegate = self;
	
	Checklist *checklist = _lists[indexPath.row];
	controller.checklistToEdit =checklist;
	[self presentViewController:navigationController animated:YES completion:nil];
	
}

@end





