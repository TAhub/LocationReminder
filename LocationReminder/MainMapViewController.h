//
//  MainMapViewController.h
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapOutlet;

@property (weak, nonatomic) IBOutlet UIView *backerOutlet;

- (IBAction)buttonOneAction;

- (IBAction)buttonTwoAction;

- (IBAction)buttonThreeAction;


@end
