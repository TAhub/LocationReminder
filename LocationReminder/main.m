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
#import "StandaloneFunctions.h"

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
	
	//test the anagram tester
	NSLog(@"Hello vs ellHo: %i", AnagramCheck(@"Hello", @"ellHo"));
	NSLog(@"Cat vs Tac: %i", AnagramCheck(@"Cat", @"Tac"));
	NSLog(@"Not vs An Anagram: %i", AnagramCheck(@"Not", @"An Anagram"));
	NSLog(@"NAME PALINDROME CHECK: %i", AnagramCheck(@"Theodore Abshire", @"Dab Theories Hero"));
	
	//test the digit summer
	NSLog(@"171aaaazzz1 = %i", DigitSummer(@"17	1aaaazzz1"));
	NSLog(@"qq = %i", DigitSummer(@"qq"));
	
	
	//the thursday code challenge was to implement a linked list
	//but technically my implementations for queue and stack are both linked-list based
	//so I already did it
	//so... yay, thursday's work complete!
	
	
	@autoreleasepool {
	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}
