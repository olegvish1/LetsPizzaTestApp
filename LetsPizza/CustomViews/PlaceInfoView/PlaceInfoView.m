//
//  PlaceInfoView.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 24/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PlaceInfoView.h"
#import "PizzaPlace.h"
#import "UIColor+CustomColors.h"

@interface PlaceInfoView ()

@property (weak, nonatomic) IBOutlet UIButton *phoneNumberButton;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) PizzaPlace *place;

@end

@implementation PlaceInfoView


- (void)setupWithPlace:(PizzaPlace *)place {
    self.place = place;
    [self.phoneNumberButton setTitle:place.formattedPhone forState:UIControlStateNormal];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m",[place.distance stringValue]];
    
    if (place.isOpen) {
        self.statusLabel.text = place.status != nil ? place.status : @"Open";
        self.statusLabel.textColor = [UIColor openTitleColor];
    } else {
        self.statusLabel.text = place.status != nil ? place.status : @"Closed";
        self.statusLabel.textColor = [UIColor closedTitleColor];
    }
}


- (IBAction)visitSiteAction:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.place.urlAddress]];
}

- (IBAction)phoneButtonAction:(UIButton *)sender {
    if (!TARGET_IPHONE_SIMULATOR) {
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.place.phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

@end
