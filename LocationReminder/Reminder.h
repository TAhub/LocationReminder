//
//  Reminder.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/25/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;

@end