//
//  PizzaPlace.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface PizzaPlace : NSObject

@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *distance;

@property (strong, nonatomic) NSString *formattedPhone;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *status;
@property (nonatomic) BOOL isOpen;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *urlAddress;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
