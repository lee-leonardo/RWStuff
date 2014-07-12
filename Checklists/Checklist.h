//
//  Checklist.h
//  Checklists
//
//  Created by Leonardo Lee on 6/9/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;

@end
