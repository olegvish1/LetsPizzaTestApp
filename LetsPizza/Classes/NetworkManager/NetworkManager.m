//
//  NetworkManager.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "NetworkManager.h"

NSString *const NetworkManagerClientID = @"OOPNZQCHDMQRYAM1UOZ0DJB5W3HIOBCFL4AYKB4GOKOA5E01";

NSString *const NetworkManagerClientSecret = @"FWO15W0YWED4DU1TMTSG4ZVFK34UW5OVAWCIQHPLQSA44ZP2";

NSString *const VersionParameter = @"20130815";

NSString *const NetworkManagerBaseURL = @"https://api.foursquare.com/v2";

NSString *const NetworkManagerVenuesSearch = @"/venues/search";

NSString *const NetworkManagerVenuesExplore = @"/venues/explore";

NSString *const ClientIDKey = @"client_id";
NSString *const ClientSecretKey = @"client_secret";
NSString *const QueryKey = @"query";
NSString *const VersionParameterKey = @"v";
NSString *const LimitKey = @"limit";

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
    [allParameters setObject:NetworkManagerClientID forKey:ClientIDKey];
    [allParameters setObject:NetworkManagerClientSecret forKey:ClientSecretKey];
    [allParameters setObject:VersionParameter forKey:VersionParameterKey];
    
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
    
    NSDictionary *dict = @{@"ll" : [NSString stringWithFormat:@"%0.1f,%0.1f", latitude, longitude], @"query" : search, LimitKey : @(2)};
    
    [self GET:NetworkManagerVenuesSearch parameters:dict success:success failure:failure];
}

- (void)exploreVenuesWithSearchWord:(NSString *)search parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    CGFloat latitude = 40.7;
    CGFloat longitude = -74.0;
    
    NSDictionary *dict = @{@"ll" : [NSString stringWithFormat:@"%0.1f,%0.1f", latitude, longitude], @"query" : search, LimitKey : @(10), @"sortByDistance" : @(1)};
    
    [self GET:NetworkManagerVenuesExplore parameters:dict success:success failure:failure];
}

@end
