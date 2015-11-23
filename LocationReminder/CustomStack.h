//
//  CustomStack.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

@interface CustomStack: NSObject

- (id)init;
- (void)push:(NSObject *)toPush;
- (NSObject *)pop;
- (NSObject *)peep;

@end