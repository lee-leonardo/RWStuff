//
//  DataModel.m
//  Checklists
//
//  Created by Leonardo Lee on 7/12/14.
//  Copyright (c) 2014 Leonardo Lee. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

#pragma mark - Init
-(void)registerDefaults
{
	NSDictionary *dictionary = @{@"ChecklistIndex": @-1};
	[[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(id)init
{
	if ((self = [super init])) {
		[self loadChecklists];
		[self registerDefaults];
	}
	return self;
}

#pragma mark - Encoding
-(NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths firstObject];
	return documentsDirectory;
}
-(NSString *)dataFilePath
{
	return [[self documentsDirectory] stringByAppendingString:@"Checklists.plist"];
}
-(void)saveChecklists
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:self.lists forKey:@"Checklists"];
	[archiver finishEncoding];
	[data writeToFile:[self dataFilePath] atomically:YES];
}
-(void)loadChecklists
{
	NSString *path = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSData *data = [[NSData alloc] initWithContentsOfFile:path];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
		self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
		[unarchiver finishDecoding];
	} else {
		self.lists = [[NSMutableArray alloc] initWithCapacity:20];
	}
}

#pragma mark - NSUserDefaults
//Code stuck here so that it is readily mobile in the future compared to spaghettiing it in other code.
-(NSInteger)indexOfSelectedChecklist
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}
-(void)setIndexOfSelectedChecklist:(NSInteger)index
{
	[[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

@end
