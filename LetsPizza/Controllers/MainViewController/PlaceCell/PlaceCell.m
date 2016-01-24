//
//  PlaceCell.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PlaceCell.h"
#import "PizzaPlace.h"
#import "UIColor+CustomColors.h"

@interface PlaceCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end

@implementation PlaceCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setPlace:(PizzaPlace *)place {
    _place = place;
    self.nameLabel.text = place.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", place.distance];
    if (place.isOpen) {
        self.statusLabel.text = place.status != nil ? place.status : @"Open";
        self.statusLabel.textColor = [UIColor openTitleColor];
        self.backgroundColor = [UIColor openBackGroundColor];
    } else {
        self.statusLabel.text = place.status != nil ? place.status : @"Closed";
        self.statusLabel.textColor = [UIColor closedTitleColor];
        self.backgroundColor = [UIColor closedBackGroundColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
