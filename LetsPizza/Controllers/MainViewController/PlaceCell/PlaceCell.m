//
//  PlaceCell.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 22/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "PlaceCell.h"
#import "PizzaPlace.h"

@interface PlaceCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation PlaceCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setPlace:(PizzaPlace *)place {
    _place = place;
    self.nameLabel.text = place.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ m", place.distance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
