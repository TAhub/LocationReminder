//
//  AddReminderViewController.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/24/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddReminderViewController : UIViewController

@property (weak) MKAnnotationView *annotation;

@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)addReminderAction;

- (IBAction)cancelAction;


@end
