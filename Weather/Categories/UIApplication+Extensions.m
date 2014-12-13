//
//  UIApplication+Extensions.m
//  Weather
//
//  Created by Ilya Puchka on 13.12.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "UIApplication+Extensions.h"

@implementation UIApplication (Extensions)

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildNumber
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
}

+ (NSString *)appFullVersion
{
    return [NSString stringWithFormat:@"%@.%@", [self appVersion], [self appBuildNumber]];
}

+ (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleDisplayName"];
}

+ (NSString *)copyright
{
    return [[[NSBundle mainBundle] infoDictionary] valueForKey:@"NSHumanReadableCopyright"];
}

@end
