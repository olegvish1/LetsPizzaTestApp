//
//  NetworkManager.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^SuccessBlock)(id JSON);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)searchVenuesWithSearchWord:(NSString *)search parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

- (void)exploreVenuesWithSearchWord:(NSString *)search parameters:(NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
