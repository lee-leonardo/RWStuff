//
//  ChecklistItem.h
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

@property (nonatomic,strong) NSDate *dueDate;
@property (nonatomic,assign) BOOL shouldRemind;
@property (nonatomic, assign) NSInteger itemId;

-(void)toggleChecked;
@end
