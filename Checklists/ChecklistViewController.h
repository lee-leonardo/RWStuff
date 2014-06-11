//
//  ViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 6/2/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class  Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>
//-(IBAction)addItem;
@property (nonatomic,strong) Checklist *checklist;
@end
