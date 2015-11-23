//
//  CustomQueue.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomQueue.h"
#import "CustomQueueNode.h"

@interface CustomQueue ()
@property CustomQueueNode *head;
@property CustomQueueNode *tail;
@end

@implementation CustomQueue
- (id)init
{
	self = [super init];
	if (self)
	{
		_head = nil;
		_tail = nil;
	}
	return self;
}

- (void)enqueue:(NSObject *)toEnqueue
{
	CustomQueueNode *newNode = [[CustomQueueNode alloc] init];
	newNode.contents = toEnqueue;
	newNode.lastNode = nil;
	if (!self.tail)
	{
		self.head = newNode;
		self.tail = newNode;
	}
	else
	{
		self.head.lastNode = newNode;
		self.head = newNode;
	}
}

- (NSObject *)dequeue
{
	if (self.tail)
	{
		NSObject *dequeued = self.tail.contents;
		self.tail = self.tail.lastNode;
		if (!self.tail)
		{
			self.head = nil;
		}
		return dequeued;
	}
	return nil;
}

@end