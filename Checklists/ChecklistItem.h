//
//  ChecklistItem.h
//  Checklists
//
//  Created by Leonardo Lee on 6/4/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

-(void)toggleChecked;
@end
