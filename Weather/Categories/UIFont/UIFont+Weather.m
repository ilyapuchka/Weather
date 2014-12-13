//
//  UIFont+Weather.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "UIFont+Weather.h"

@implementation UIFont (Weather)

+ (UIFont *)lightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"ProximaNova-Light" size:size];
}

+ (UIFont *)regularFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"ProximaNova-Regular" size:size];
}

+ (UIFont *)semiboldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:size];
}

@end
