//
//  CustomQueue.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

@interface CustomQueue: NSObject

- (id)init;
- (void)enqueue:(NSObject *)toEnqueue;
- (NSObject *)dequeue;

@end