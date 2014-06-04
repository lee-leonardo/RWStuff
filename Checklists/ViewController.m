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

- (void)viewDidLoad
{
    [super viewDidLoad];
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

-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
	UILabel *label = (UILabel *) [cell viewWithTag:1000];
	label.text = item.text;
}

-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
	if (item.checked) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}


@end
