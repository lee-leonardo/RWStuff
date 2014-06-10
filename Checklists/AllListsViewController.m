//
//  AllListsViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/9/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "AllListsViewController.h"
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
	[self performSegueWithIdentifier:@"ShowChecklist" sender:nil];
}

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

@end
