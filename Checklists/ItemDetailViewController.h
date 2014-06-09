//
//  DetailItemViewControllerTableViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController
-(IBAction)cancel;
-(IBAction)done;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ItemDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) ChecklistItem *itemToEdit;

@end
