//
//  AddReminderViewController.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/24/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "AddReminderViewController.h"
#import <Parse/Parse.h>
#import "Reminder.h"

#define MIN_RADIUS 10.0f
#define MAX_RADIUS 200.0f

@interface AddReminderViewController () <UITextFieldDelegate>

@end

@implementation AddReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CLLocationCoordinate2D loc = [self.annotation.annotation coordinate];
	self.label.text = [NSString stringWithFormat:@" (%f, %f)?", loc.latitude, loc.longitude];
	
	self.textOutlet.delegate = self;
}

- (IBAction)addReminderAction
{
	if ([self.textOutlet.text  isEqualToString: @""])
	{
		//it's an empty string
		//so have an alert
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"There's no message!" message:@"You need to have a message for your reminder!" preferredStyle:UIAlertControllerStyleAlert];
		[self presentViewController:alert animated:YES completion:nil];
	}
	else
	{
		CLLocationCoordinate2D loc = [self.annotation.annotation coordinate];
		
		//translate the slider into a radius
		float radius = self.radiusSlider.value * MAX_RADIUS + (1 - self.radiusSlider.value) * MIN_RADIUS;
		
		//upload the info
		Reminder *reminder = [Reminder new];
		reminder.text = self.textOutlet.text;
		reminder.radius = [NSNumber numberWithFloat:radius];
		reminder.location = [PFGeoPoint geoPointWithLatitude:loc.latitude longitude:loc.longitude];
		
		[reminder saveInBackgroundWithBlock: ^(BOOL succeeded, NSError * _Nullable error)
		{
			NSLog(@"Reminder sent to parse.");
			 
			//add the actual reminder
			if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]])
			{
				//make the region
				CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:loc radius:radius identifier:reminder.text];
				[self.locationManager startMonitoringForRegion:region];
				
				//pass it back
				self.completion([MKCircle circleWithCenterCoordinate:loc radius:radius]);
			}
			
			//dismiss
			[self dismissViewControllerAnimated:YES completion:nil];
		}];
	}
}

- (IBAction)cancelAction
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - text field delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end