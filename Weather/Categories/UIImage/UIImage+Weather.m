//
//  UIImage+Weather.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "UIImage+Weather.h"

@implementation UIImage (Weather)

+ (UIImage *)weatherIconImage:(NSString *)weatherDesc
{
    static NSDictionary *dict;
    if (!dict) {
        dict = @{
                 @"sun": @"Sun_Big",
                 @"clear": @"Sun_Big",
                 @"cloud": @"Cloudy_Big",
                 @"wind": @"Wind_Big",
                 @"thunder": @"Lightning_Big",
                 @"rain": @"CR"
                 };
        
    }
    __block NSString *imageName = @"Cloudy_Big";
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([weatherDesc rangeOfString:key].location != NSNotFound) {
            imageName = obj;
            *stop = YES;
        }
    }];
    return [UIImage imageNamed:imageName];
}


@end
