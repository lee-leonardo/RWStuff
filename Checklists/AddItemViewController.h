//
//  AddItemViewControllerTableViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;
@class ChecklistItem;

@protocol AddItemViewControllerDelegate <NSObject>

-(void)addItemViewControllerDidCancel:(AddItemViewController *)controller;
-(void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

@end

@interface AddItemViewController : UITableViewController
-(IBAction)cancel;
-(IBAction)done;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <AddItemViewControllerDelegate> delegate;

@end
