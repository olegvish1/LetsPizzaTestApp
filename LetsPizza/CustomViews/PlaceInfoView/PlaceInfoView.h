//
//  PlaceInfoView.h
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 24/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PizzaPlace;

@interface PlaceInfoView : UIView

- (void)setupWithPlace:(PizzaPlace *)place;

@end
