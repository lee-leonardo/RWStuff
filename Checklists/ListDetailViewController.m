//
//  ListDetailViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
	NSString *_iconName;
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
    
	if (self.checklistToEdit != nil) {
		self.title = @"Edit Checklist";
		self.textField.text = self.checklistToEdit.name;
		self.doneBarButton.enabled = YES;
		_iconName = self.checklistToEdit.iconName;
	}
	self.iconImageView.image = [UIImage imageNamed:_iconName];
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.textField becomeFirstResponder];
}
-(IBAction)cancel
{
	[self.delegate listDetailviewControllerDidCancel:self];
}

-(IBAction)done
{
	if (self.checklistToEdit == nil) {
		Checklist *checklist = [[Checklist alloc] init];
		checklist.name = self.textField.text;
		checklist.iconName = _iconName;
		[self.delegate listDetailviewController:self didFinishAddingChecklists:checklist];
	} else {
		self.checklistToEdit.name = self.textField.text;
		self.checklistToEdit.iconName = _iconName;
		[self.delegate listDetailviewController:self didFinishEditingChecklists:self.checklistToEdit];
	}
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		return indexPath;
	} else {
		return nil;
	}
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
	self.doneBarButton.enabled = ([newText length] > 0);
	return YES;
}
#pragma mark - Decoders
-(id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) {
		_iconName = @"Folder";
	}
	return self;
}
#pragma mark - iconPickerDelegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"PickIcon"]) {
		IconPickerViewController *controller = segue.destinationViewController;
		controller.delegate = self;
	}
}
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
	_iconName = theIconName;
	self.iconImageView.image = [UIImage imageNamed:_iconName];
	[self.navigationController popViewControllerAnimated:YES];
}

@end





