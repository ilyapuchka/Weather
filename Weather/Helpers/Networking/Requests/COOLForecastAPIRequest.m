//
//  COOLForecastAPIRequest.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastAPIRequest.h"

@implementation COOLForecastAPIRequest

- (instancetype)initWithQuery:(NSString *)query
{
    NSCParameterAssert(query);
    if (!query) {
        return nil;
    }
    
    return [self initWithMethod:COOLAPIGETRequest path:@"weather.ashx" parameters:@{@"q": query, @"tp": @"24", @"cc": @"no"}];
}

@end
