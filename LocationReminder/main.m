//
//  main.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//test code challenges
#import "CustomStack.h"
#import "CustomQueue.h"

int main(int argc, char * argv[]) {
	
	//test the custom stack
	CustomStack *s = [[CustomStack alloc] init];
	[s push:@(0)];
	[s push:@(1)];
	[s push:@(2)];
	NSLog(@"The first thing popped is %@\n", [s pop]);
	
	//test the custom queue
	CustomQueue *q = [[CustomQueue alloc] init];
	[q enqueue:@(0)];
	[q enqueue:@(1)];
	[q enqueue:@(2)];
	NSLog(@"The first thing dequeued is %@\n", [q dequeue]);
	
	
	@autoreleasepool {
	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}
