//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/24/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()

@end

@implementation AddReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CLLocationCoordinate2D loc = [self.annotation.annotation coordinate];
	self.label.text = [NSString stringWithFormat:@" (%f, %f)?", loc.latitude, loc.longitude];
}

- (IBAction)addReminderAction
{
	//TODO: add a reminder
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
