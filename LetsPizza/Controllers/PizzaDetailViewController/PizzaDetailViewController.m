//
//  PizzaDetailViewController.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PizzaDetailViewController.h"
#import "PizzaPlace.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
#import "PlaceInfoView.h"

@interface PizzaDetailViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet PlaceInfoView *placeInfoView;

@end

@implementation PizzaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.place.name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    [self.placeInfoView setupWithPlace:self.place];
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake (self.currentLocation.coordinate, span);
    
    [self.mapView setRegion:region];
    
    
//    NSArray *routeCoordinates = @[self.currentLocation.coordinate, self.place.location.coordinate];
//    MKPolyline *routeLine = [MKPolyline polylineWithCoordinates:routeCoordinates count:2];
//    [self.mapView addOverlay:routeLine];
    
    
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinates:self.place.location.coordinate];
    
    annotation.title = self.place.address;
    
    [self.mapView addAnnotation:annotation];
    
//    [self.mapView selectAnnotation:annotation animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
