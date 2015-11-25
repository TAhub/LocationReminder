//
//  Reminder.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/25/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic text;
@dynamic location;
@dynamic radius;

+ (void) load
{
	[self registerSubclass];
}

+ (NSString *)parseClassName
{
	return @"Reminder";
}

@end