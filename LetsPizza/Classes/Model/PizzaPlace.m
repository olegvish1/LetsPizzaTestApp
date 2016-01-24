//
//  PizzaPlace.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PizzaPlace.h"
#import <CoreLocation/CoreLocation.h>

@implementation PizzaPlace

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSDictionary *venue = [dictionary objectForKey:@"venue"];
        self.placeID = [venue objectForKey:@"id"];
        self.name = [venue objectForKey:@"name"];
        self.distance = [[venue objectForKey:@"location"] objectForKey:@"distance"];
        
        self.formattedPhone = [[[dictionary objectForKey:@"venue"] objectForKey:@"contact"] objectForKey:@"formattedPhone"];
        self.phoneNumber = [[[dictionary objectForKey:@"venue"] objectForKey:@"contact"] objectForKey:@"phone"];
        self.isOpen = [[[[dictionary objectForKey:@"venue"] objectForKey:@"hours"] objectForKey:@"isOpen"] boolValue];
        self.status = [[[dictionary objectForKey:@"venue"] objectForKey:@"hours"] objectForKey:@"status"];
        self.address = [[[venue objectForKey:@"location"] objectForKey:@"formattedAddress"] firstObject];
        
        
        double lat = [[[venue objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        double lng = [[[venue objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        self.location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        self.urlAddress = [venue objectForKey:@"url"];
        
    }
    return self;
}

@end
