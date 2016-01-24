//
//  PizzaDetailViewController.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PizzaPlace;
@class CLLocation;

@interface PizzaDetailViewController : UIViewController

@property (strong, nonatomic) PizzaPlace *place;
@property (strong, nonatomic) CLLocation *currentLocation;

@end
