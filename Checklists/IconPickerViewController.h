//
//  IconPickerViewController.h
//  Checklists
//
//  Created by Leonardo Lee on 7/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName;

@end

@interface IconPickerViewController : UITableViewController
@property (nonatomic, weak) id <IconPickerViewControllerDelegate> delegate;

@end
