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
	ChecklistItem *row_0item;
	ChecklistItem *row_1item;
	ChecklistItem *row_2item;
	ChecklistItem *row_3item;
	ChecklistItem *row_4item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	row_0item = [[ChecklistItem alloc] init];
	row_0item.text = @"Walk the Dog.";
	row_0item.checked = NO;
	
	row_1item = [[ChecklistItem alloc] init];
	row_1item.text = @"Brush my Teeth";
	row_1item.checked = YES;
	
	row_2item = [[ChecklistItem alloc] init];
	row_2item.text = @"Learn iOS development";
	row_2item.checked = YES;
	
	row_3item = [[ChecklistItem alloc] init];
	row_3item.text = @"Soccer practice";
	row_3item.checked = NO;
	
	row_4item = [[ChecklistItem alloc] init];
	row_4item.text = @"Eat ice cream";
	row_4item.checked = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
	
	UILabel *label = (UILabel *)[cell viewWithTag:1000];

	if(indexPath.row == 0){
		label.text =row_0item.text;
	} else if (indexPath.row ==1){
		label.text = row_1item.text;
	} else if (indexPath.row ==2){
		label.text = row_2item.text;
	} else if (indexPath.row ==3){
		label.text = row_3item.text;
	} else if (indexPath.row == 4){
		label.text = row_4item.text;
	}
	
	[self configureCheckmarkForCell:cell atIndexPath:indexPath];
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (indexPath.row == 0) {
		row_0item.checked = !row_0item.checked;
	} else if (indexPath.row == 1) {
		row_1item.checked = !row_1item.checked;
	} else if (indexPath.row == 2) {
		row_2item.checked = !row_2item.checked;
	} else if (indexPath.row == 3) {
		row_3item.checked = !row_3item.checked;
	} else if (indexPath.row == 4) {
		row_4item.checked = !row_4item.checked;
	}
	
	[self configureCheckmarkForCell:cell atIndexPath:indexPath];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)configureCheckmarkForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	BOOL isChecked = NO;
	
	if (indexPath.row == 0) {
		isChecked = row_0item.checked;
	} else if (indexPath.row == 1) {
		isChecked = row_1item.checked;
	} else if (indexPath.row == 2) {
		isChecked = row_2item.checked;
	} else if (indexPath.row == 3) {
		isChecked = row_3item.checked;
	} else if (indexPath.row == 4) {
		isChecked = row_4item.checked;
	}
	
	if (isChecked) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}


@end
