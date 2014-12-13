//
//  UIApplication+Extensions.h
//  Weather
//
//  Created by Ilya Puchka on 13.12.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Extensions)

+ (NSString *)appVersion;
+ (NSString *)appBuildNumber;
+ (NSString *)appFullVersion;
+ (NSString *)appName;
+ (NSString *)copyright;

@end
