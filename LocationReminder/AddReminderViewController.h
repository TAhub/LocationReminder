//
//  AddReminderViewController.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/24/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef void(^DetailViewControllerCompletion)(MKCircle *circle);

@interface AddReminderViewController : UIViewController

@property (weak) MKAnnotationView *annotation;
@property CLLocationManager *locationManager;

@property (copy, nonatomic) DetailViewControllerCompletion completion;

@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)addReminderAction;

- (IBAction)cancelAction;

@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;

@property (weak, nonatomic) IBOutlet UITextField *textOutlet;

@end
