//
//  AllListsViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 6/9/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
@class DataModel;

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) DataModel *dataModel;

//-(void)saveChecklists;
@end
