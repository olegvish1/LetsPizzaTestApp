//
//  PizzaPlace.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PizzaPlace : NSObject

@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSNumber *distance;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
