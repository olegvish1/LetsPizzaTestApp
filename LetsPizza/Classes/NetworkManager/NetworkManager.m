//
//  NetworkManager.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import <CoreLocation/CoreLocation.h>

NSString *const NetworkManagerClientID = @"OOPNZQCHDMQRYAM1UOZ0DJB5W3HIOBCFL4AYKB4GOKOA5E01";

NSString *const NetworkManagerClientSecret = @"FWO15W0YWED4DU1TMTSG4ZVFK34UW5OVAWCIQHPLQSA44ZP2";

NSString *const VersionParameter = @"20130815";

NSString *const NetworkManagerBaseURL = @"https://api.foursquare.com/v2";

NSString *const NetworkManagerVenuesSearch = @"/venues/search";

NSString *const NetworkManagerVenuesExplore = @"/venues/explore";

NSUInteger const limit = 10;

NSString *const clientIDKey = @"client_id";
NSString *const clientSecretKey = @"client_secret";
NSString *const queryKey = @"query";
NSString *const versionParameterKey = @"v";
NSString *const limitKey = @"limit";
NSString *const locationKey = @"ll";
NSString *const sortKey = @"sortByDistance";
NSString *const offsetKey = @"offset";

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation NetworkManager

+ (instancetype)sharedManager
{
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestManager = [[AFHTTPRequestOperationManager alloc] init];

    }
    return self;
}


- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    NSMutableDictionary *allParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [allParameters setObject:NetworkManagerClientID forKey:clientIDKey];
    [allParameters setObject:NetworkManagerClientSecret forKey:clientSecretKey];
    [allParameters setObject:VersionParameter forKey:versionParameterKey];
    
    NSLog(@"URL: %@\nParameters: %@", URLString, allParameters);
    
    [self.requestManager GET:[NSString stringWithFormat:@"%@%@", NetworkManagerBaseURL, URLString] parameters:allParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);

        failure(error);
    }];
}


- (void)searchVenuesWithSearchWord:(NSString *)search parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    CGFloat latitude = 40.7;
    CGFloat longitude = -74.0;
    
    NSDictionary *dict = @{locationKey : [NSString stringWithFormat:@"%0.1f,%0.1f", latitude, longitude], queryKey : search, limitKey : @(2)};
    
    [self GET:NetworkManagerVenuesSearch parameters:dict success:success failure:failure];
}

- (void)exploreVenuesWithSearchWord:(NSString *)search location:(CLLocation *)location success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [self exploreVenuesWithSearchWord:search location:location offset:@(0) success:success failure:failure];
}

- (void)exploreVenuesWithSearchWord:(NSString *)search location:(CLLocation *)location offset:(NSNumber *)offset success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString *coordinateString = [NSString stringWithFormat:@"%0.1f,%0.1f", location.coordinate.latitude, location.coordinate.longitude];
    NSDictionary *parameters = @{locationKey : coordinateString,
                                 queryKey : search,
                                 limitKey : @(limit),
                                 sortKey : @(1),
                                 offsetKey : offset};
    
    [self GET:NetworkManagerVenuesExplore parameters:parameters success:^(id JSON) {
        NSArray *items = [[[[JSON objectForKey:@"response"] objectForKey:@"groups"] objectAtIndex:0] objectForKey:@"items"];
        success(items);
    } failure:failure];
}

@end
