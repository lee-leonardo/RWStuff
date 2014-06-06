//
//  AddItemViewControllerTableViewController.m
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "AddItemViewController.h"
#import "ChecklistItem.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

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
}

-(IBAction)cancel
{
	[self.delegate addItemViewControllerDidCancel:self];
}

-(IBAction)done
{
//	NSLog(@"Contents of the text field: %@", self.textField.text);
	ChecklistItem *item = [[ChecklistItem alloc] init];
	item.text = self.textField.text;
	item.checked = NO;
	
	[self.delegate addItemViewController:self didFinishAddingItem:item];
	
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
