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
    
    [self setupMapView];
    
}

- (void)setupMapView {
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];

    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake (self.currentLocation.coordinate, span);
    
    [self.mapView setRegion:region];
    
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinates:self.place.location.coordinate];
    
    annotation.title = self.place.address;
    annotation.subtitle = self.place.isOpen ? @"Open" : @"Closed";
    
    [self.mapView addAnnotation:annotation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
