//
//  MainMapViewController.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "MainMapViewController.h"

@interface MainMapViewController ()

@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//give it nice rounded borders
	[[_backerOutlet layer] setCornerRadius:12];
	[[_mapOutlet layer] setCornerRadius:12];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonOneAction
{
	//move the camera
	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(25, -71);
	MKCoordinateSpan spanTo = MKCoordinateSpanMake(15, 15);
	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
	[_mapOutlet setRegion:regionTo animated:YES];
}

- (IBAction)buttonTwoAction
{
	//move the camera
	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(36.4511, 28.2278);
	MKCoordinateSpan spanTo = MKCoordinateSpanMake(0.1, 0.1);
	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
	[_mapOutlet setRegion:regionTo animated:YES];
}

- (IBAction)buttonThreeAction
{
	//move the camera
	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(-90, 0);
	MKCoordinateSpan spanTo = MKCoordinateSpanMake(10, 10);
	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
	[_mapOutlet setRegion:regionTo animated:YES];
}

@end
