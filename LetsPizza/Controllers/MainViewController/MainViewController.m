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

static NSString *cellIdentifier = @"PlaceCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *places;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlaceCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
//    [self.tableView registerClass:[PlaceCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.navigationItem.title = @"Pizza plases";
    __weak __typeof(self)weakSelf = self;
    [[NetworkManager sharedManager] exploreVenuesWithSearchWord:@"pizza" parameters:nil success:^(id JSON) {
//        NSLog(@"%@", JSON);
        NSArray *items = [[[[JSON objectForKey:@"response"] objectForKey:@"groups"] objectAtIndex:0] objectForKey:@"items"];
        NSLog(@"%@", [items objectAtIndex:0]);
        [weakSelf fetchPlaces:items];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPlaces:(NSArray *)items {
    NSMutableArray *places = [NSMutableArray new];
    for (NSDictionary *item in items) {
        PizzaPlace *place = [[PizzaPlace alloc] initWithDictionary:item];
        [places addObject:place];
    }
    self.places = [NSArray arrayWithArray:places];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    PizzaPlace *place = [self.places objectAtIndex:indexPath.row];
    
    cell.place = place;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0f;
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
