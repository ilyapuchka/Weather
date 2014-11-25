//
//  COOLTodayForecastAPIRequest.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecastAPIRequest.h"

@implementation COOLTodayForecastAPIRequest

- (instancetype)initWithQuery:(NSString *)query
{
    NSCParameterAssert(query);
    if (!query) {
        return nil;
    }
    
    return [self initWithMethod:COOLAPIGETRequest path:@"weather.ashx" parameters:@{@"q": query, @"tp": @"24", @"cc": @"no", @"num_of_days":@"1", @"date":@"today"}];
}

@end
