//
//  MainMapViewController.m
//  LocationReminder
//
//  Created by Theodore Abshire on 11/23/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "MainMapViewController.h"
#import "AddReminderViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface MainMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, PFLogInViewControllerDelegate>

@property CLLocationManager *locationManager;

@property UILongPressGestureRecognizer *longPressRecognizer;

-(void)start;
-(void)stop;
-(void)configureSignUpButton;
-(IBAction)longPress:(UILongPressGestureRecognizer *)sender;

@end

@implementation MainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//give it nice rounded borders
	[[self.backerOutlet layer] setCornerRadius:12];
	[[self.mapOutlet layer] setCornerRadius:12];
	self.mapOutlet.delegate = self;
	
	if ([CLLocationManager locationServicesEnabled])
	{
		//I am NOT using the significant-change service
		//because I want to be able to detect when I am in all of my pre-picked locations
		//which include places with no wifi
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
		self.locationManager.distanceFilter = 100.0f;
		
		[self.locationManager requestAlwaysAuthorization];
	}
	
	//add the long press
	self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] init];
	[self.longPressRecognizer addTarget:self action:@selector(longPress:)];
	[self.mapOutlet addGestureRecognizer:self.longPressRecognizer];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//set the sign up button text
	[self configureSignUpButton];
	
	[self start];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[self stop];
}

-(void)start
{
	if (self.locationManager != nil && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
	{
		[self.locationManager startUpdatingLocation];
		self.mapOutlet.showsUserLocation = YES;
	}
}

-(void)stop
{
	if (self.locationManager != nil)
	{
		[self.locationManager stopUpdatingLocation];
		self.mapOutlet.showsUserLocation = NO;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpButtonAction
{
	if ([PFUser currentUser])
	{
		[PFUser logOut];
		[self configureSignUpButton];
	}
	else
	{
		//sign on
		PFLogInViewController *login = [PFLogInViewController new];
		login.delegate = self;
		[self presentViewController:login animated:true completion:nil];
	}
}

-(void)configureSignUpButton
{
	if ([PFUser currentUser])
		[self.signUpButton setTitle:@"Sign Out" forState:UIControlStateNormal];
	else
		[self.signUpButton setTitle:@"Sign On" forState:UIControlStateNormal];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	MKPinAnnotationView *view = (MKPinAnnotationView *)sender;
	AddReminderViewController *dest = (AddReminderViewController *)[segue destinationViewController];
	dest.annotation = view;
	dest.locationManager = self.locationManager;
	
	__weak typeof(self) weakSelf = self;
	
	dest.completion = ^(MKCircle *circle)
	{
		__strong typeof(weakSelf) strongSelf = weakSelf;
		
		if (circle != nil)
		{
			[strongSelf.mapOutlet addOverlay:circle];
			
			//make an annotation
			MKPointAnnotation *newAnnotation = [MKPointAnnotation new];
			newAnnotation.coordinate = view.annotation.coordinate;
			newAnnotation.title = @"Reminder added";
			
			//change the pin
			view.annotation = newAnnotation;
			view.pinTintColor = [UIColor blueColor];
			view.rightCalloutAccessoryView = nil;
		}
		else
		{
			//remove the pin
			[strongSelf.mapOutlet removeAnnotation:view.annotation];
		}
	};
}

//- (IBAction)buttonOneAction
//{
//	//move the camera
//	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(25, -71);
//	MKCoordinateSpan spanTo = MKCoordinateSpanMake(15, 15);
//	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
//	[self.mapOutlet setRegion:regionTo animated:YES];
//}
//
//- (IBAction)buttonTwoAction
//{
//	//move the camera
//	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(36.4511, 28.2278);
//	MKCoordinateSpan spanTo = MKCoordinateSpanMake(0.1, 0.1);
//	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
//	[self.mapOutlet setRegion:regionTo animated:YES];
//}
//
//- (IBAction)buttonThreeAction
//{
//	//move the camera
//	CLLocationCoordinate2D coordTo = CLLocationCoordinate2DMake(-90, 0);
//	MKCoordinateSpan spanTo = MKCoordinateSpanMake(10, 10);
//	MKCoordinateRegion regionTo = MKCoordinateRegionMake(coordTo, spanTo);
//	[self.mapOutlet setRegion:regionTo animated:YES];
//}

#pragma mark - location manager delegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
	//if you just got authorization, start updates
	[self start];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
	
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	UILocalNotification *notification = [UILocalNotification new];
	notification.alertTitle = @"Location reminder!";
	notification.alertBody = region.identifier;
	[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

#pragma mark - map view delegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	//prevent it from turning the user location annotations into pins
	if ([annotation isKindOfClass:[MKUserLocation class]]) { return nil; }
	
	//make the pin
	MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
	pin.annotation = annotation;
	
	//make a new one, if necessary
	if (!pin)
		pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
	
	//give it a callout
	pin.canShowCallout = YES;
	UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	pin.rightCalloutAccessoryView = rightCallout;
		
	pin.pinTintColor = [UIColor redColor];
	
	return pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	if ([PFUser currentUser])
		[self performSegueWithIdentifier:@"addReminder" sender:view];
	else
	{
		//you're not logged in
		//so have an alert
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You're not logged in!" message:@"You need to be logged in to add reminders." preferredStyle:UIAlertControllerStyleAlert];
		[self presentViewController:alert animated:YES completion:nil];
	}
}

-(MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
	MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
	circleRenderer.strokeColor = [UIColor blueColor];
	circleRenderer.fillColor = [UIColor lightGrayColor];
	circleRenderer.alpha = 0.75;
	return circleRenderer;
}

#pragma mark - programatical action selector

-(IBAction)longPress:(UILongPressGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		//find where they long pressed
		CGPoint touchPoint = [sender locationInView:self.mapOutlet];
		CLLocationCoordinate2D touchCoordinate = [self.mapOutlet convertPoint:touchPoint toCoordinateFromView:self.mapOutlet];
		
		//make an annotation
		MKPointAnnotation *newAnnotation = [MKPointAnnotation new];
		newAnnotation.coordinate = touchCoordinate;
		newAnnotation.title = @"Do you want to add a reminder here?";
		
		[self.mapOutlet addAnnotation:newAnnotation];
	}
}

#pragma mark- login view controller delegate

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self configureSignUpButton];
}

@end
