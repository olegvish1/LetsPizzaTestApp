//
//  PizzaPlace.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PizzaPlace.h"

@implementation PizzaPlace

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        NSDictionary *venue = [dictionary objectForKey:@"venue"];
        self.placeID = [venue objectForKey:@"id"];
        self.name = [venue objectForKey:@"name"];
        self.distance = [[venue objectForKey:@"location"] objectForKey:@"distance"];
    }
    return self;
}

@end
