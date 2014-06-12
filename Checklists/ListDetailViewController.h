//
//  ListDetailViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 6/11/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>

-(void)listDetailviewControllerDidCancel:(ListDetailViewController *)controller;
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishAddingChecklists:(Checklist *)checklist;
-(void)listDetailviewController:(ListDetailViewController *)controller didFinishEditingChecklists:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Checklist *checklistToEdit;

-(IBAction)cancel;
-(IBAction)done;

@end
