//
//  CustomStack.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomStack.h"
#import "CustomStackNode.h"

@interface CustomStack ()
@property CustomStackNode *head;
@end

@implementation CustomStack

- (id)init
{
	self = [super init];
	if (self)
	{
		_head = nil;
	}
	return self;
}

- (void)push:(NSObject *)toPush
{
	CustomStackNode *newCell = [[CustomStackNode alloc] init];
	newCell.contents = toPush;
	newCell.nextNode = nil;
	if (!self.head)
		self.head = newCell;
	else
	{
		newCell.nextNode = self.head;
		self.head = newCell;
	}
}

- (NSObject *)pop
{
	if (self.head)
	{
		NSObject *popped = self.head.contents;
		self.head = self.head.nextNode;
		return popped;
	}
	return nil;
}

- (NSObject *)peep
{
	if (self.head)
		return self.head.contents;
	return nil;
}

@end