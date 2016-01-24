//
//  UIColor+CustomColors.m
//  LetsPizza
//
//  Created by Oleg Vishnivetskiy on 24/01/16.
//  Copyright © 2016 Oleg Vishnivetskiy. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+(UIColor *)r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+(UIColor *)grayColorWithValue:(CGFloat)value {
    return [self r:value g:value b:value];
}

+(UIColor *)openTitleColor {
    return [self r:0.0 g:225.0 b:0.0];
}

+(UIColor *)closedTitleColor {
    return [self r:225.0 g:0.0 b:0.0];
}

+(UIColor *)openBackGroundColor {
    return [self grayColorWithValue:245.0];
}

+(UIColor *)closedBackGroundColor {
    return [self grayColorWithValue:225.0];
}

@end
