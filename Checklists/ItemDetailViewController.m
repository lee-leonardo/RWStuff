//
//  ItemDetailViewControllerTableViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
{
	NSDate *_dueDate;
	BOOL _datePickerVisible;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.textField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if (self.itemToEdit != nil) {
		self.title = @"Edit Item";
		self.textField.text = self.itemToEdit.text;
		self.doneBarButton.enabled = YES;
		self.switchControl.on = self.itemToEdit.shouldRemind;
		_dueDate = self.itemToEdit.dueDate;
	} else {
		self.switchControl.on = NO;
		_dueDate = [NSDate date];
	}
	[self updateDueDateLabel];
}



-(IBAction)cancel
{
	[self.delegate itemDetailViewControllerDidCancel:self];
}

-(IBAction)done
{
	if (self.itemToEdit == nil) {
		//	NSLog(@"Contents of the text field: %@", self.textField.text);
		ChecklistItem *item = [[ChecklistItem alloc] init];
		item.text = self.textField.text;
		item.checked = NO;
		item.shouldRemind = self.switchControl.on;
		item.dueDate = _dueDate;
		
		[self.delegate itemDetailViewController:self didFinishAddingItem:item];
	} else {
		self.itemToEdit.text = self.itemToEdit.text;
		self.itemToEdit.shouldRemind = self.switchControl.on;
		self.itemToEdit.dueDate = _dueDate;
		[self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
	}
}
#pragma TableView delegate methods
//Weird usage of CelForRowAtIndexPath and NumberOfRowsInSection... because they are utilizing values from static cells.
//It seems with statics, you have to pretty much program everything by hand.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 && indexPath.row == 2) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
		
		if (cell = nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 216.0f)];
			datePicker.tag = 100;
			[cell.contentView addSubview:datePicker];
			[datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
		}
		return cell;
	} else {
		return [super tableView:tableView cellForRowAtIndexPath:indexPath];
	}
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 1 && _datePickerVisible) {
		return 3;
	} else {
		return [super tableView:tableView numberOfRowsInSection:section];
	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 && indexPath.row == 2) {
		return 217.0f;
	} else {
		return [super tableView:tableView heightForRowAtIndexPath:indexPath];
	}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.textField resignFirstResponder];
	if (indexPath.section == 1 && indexPath.row == 1) {
		[self showDatePicker];
	}
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndex:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1, indexPath.row == 1) {
		return indexPath;
	} else {
		return nil;
	}
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 && indexPath.row == 2) {
		NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: 0 inSection:indexPath.section];
		return [super tableView:tableView indentationLevelForRowAtIndexPath:newIndexPath];
	} else {
		return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
	}
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
	
	self.doneBarButton.enabled = ( [newText length] > 0 );

	return YES;
}
#pragma DatePicker Related
-(void)updateDueDateLabel
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterMediumStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	self.dueDateLabel.text = [formatter stringFromDate:_dueDate];
}
-(void)showDatePicker
{
	_datePickerVisible = YES;
	
	NSIndexPath *indexPathDatePicker= [NSIndexPath indexPathForRow:2 inSection:1];
	[self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
}
-(void)dateChanged:(UIDatePicker *)datePicker
{
	_dueDate = datePicker.date;
	[self updateDueDateLabel];
}
@end





