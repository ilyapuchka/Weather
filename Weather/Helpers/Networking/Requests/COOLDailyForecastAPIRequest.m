//
//  COOLForecastAPIRequest.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDailyForecastAPIRequest.h"

@implementation COOLDailyForecastAPIRequest

- (instancetype)initWithQuery:(NSString *)query days:(NSInteger)days
{
    NSCParameterAssert(query);
    if (!query) {
        return nil;
    }
    
    return [self initWithMethod:COOLAPIGETRequest path:@"weather.ashx" parameters:@{@"q": query, @"tp": @"24", @"cc": @"no", @"date": @"today", @"num_of_days": [@(MAX(0, days)) stringValue]}];
}

@end
