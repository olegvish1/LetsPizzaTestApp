//
//  MainViewController.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkManager.h"
#import "PizzaPlace.h"
#import "PlaceCell.h"
#import "SpinnerCell.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

static NSString *searchWord = @"pizza";
static NSString *cellIdentifier = @"PlaceCell";
static NSString *spinnerCellIdentifier = @"SpinnerCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *places;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currecntLocation;
@property (nonatomic) NSUInteger offset;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLocation];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.navigationItem.title = @"Pizza plases";
    
}

- (void)setupLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)fetchPlaces {
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    __weak __typeof(self)weakSelf = self;
    [[NetworkManager sharedManager] exploreVenuesWithSearchWord:searchWord location:self.currecntLocation success:^(NSArray *items) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        weakSelf.offset += items.count;
        weakSelf.places = [weakSelf convertPlaces:items];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf showErrorAlert:error.localizedDescription];
    }];
}

- (void)appendPlaces {
    __weak __typeof(self)weakSelf = self;
    [[NetworkManager sharedManager] exploreVenuesWithSearchWord:searchWord location:self.currecntLocation offset:@(self.offset) success:^(NSArray *items) {
        weakSelf.offset += items.count;
        
        [self.places addObjectsFromArray:[weakSelf convertPlaces:items]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf showErrorAlert:error.localizedDescription];
    }];
}

- (NSMutableArray *)convertPlaces:(NSArray *)items {
    NSMutableArray *places = [NSMutableArray new];
    for (NSDictionary *item in items) {
        PizzaPlace *place = [[PizzaPlace alloc] initWithDictionary:item];
        [places addObject:place];
    }
    
    return places;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.places.count) {
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        PizzaPlace *place = [self.places objectAtIndex:indexPath.row];
        
        cell.place = place;
        return cell;
    } else {
        SpinnerCell *cell = [tableView dequeueReusableCellWithIdentifier:spinnerCellIdentifier];
        self.places.count > 0 ? [cell.spinner startAnimating] : [cell.spinner stopAnimating];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.places.count > 0 && indexPath.row == self.places.count) {
        [self appendPlaces];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currecntLocation = [locations lastObject];
    if (self.currecntLocation) {
        [manager stopUpdatingLocation];
        [self fetchPlaces];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied) {
        NSLog(@"not in use");
        [self showErrorAlert:@"Turn on location services"];
        
    } else {
        NSLog(@"In use");
    }
}

#pragma mark - Alert

- (void)showErrorAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:dismissAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
