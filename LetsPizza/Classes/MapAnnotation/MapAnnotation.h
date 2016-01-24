//
//  MapAnnotation.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 24/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordainate;

@end
