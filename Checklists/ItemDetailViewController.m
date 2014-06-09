//
//  AddItemViewControllerTableViewController.m
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
	}
}

-(IBAction)cancel
{
	[self.delegate addItemViewControllerDidCancel:self];
}

-(IBAction)done
{
	if (self.itemToEdit == nil) {
		//	NSLog(@"Contents of the text field: %@", self.textField.text);
		ChecklistItem *item = [[ChecklistItem alloc] init];
		item.text = self.textField.text;
		item.checked = NO;
		
		[self.delegate addItemViewController:self didFinishAddingItem:item];
	} else {
		self.itemToEdit.text = self.itemToEdit.text;
		[self.delegate addItemViewController:self didFinishEditingItem:self.itemToEdit];
	}
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndex:(NSIndexPath *)indexPath
{
	return nil;
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
	
	self.doneBarButton.enabled = ( [newText length] > 0 );

	return YES;
}

@end
