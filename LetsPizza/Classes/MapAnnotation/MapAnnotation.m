//
//  MapAnnotation.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 24/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordainate
{
    if (self = [super init]) {
        self.coordinate = coordainate;
    }
    
    return self;
}

@end
