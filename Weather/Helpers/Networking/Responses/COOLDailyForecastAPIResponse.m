//
//  COOLDailyForecastAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDailyForecastAPIResponse.h"
#import "Forecast+Mapping.h"
#import "Mantle.h"

@implementation COOLDailyForecastAPIResponse

- (instancetype)initWithTask:(NSURLSessionDataTask *)task response:(NSHTTPURLResponse *)response responseObject:(id)responseObject error:(NSError *)error
{
    self = [super initWithTask:task response:response responseObject:responseObject error:error];
    if (self) {
        _mappedResponseObject = [MTLJSONAdapter modelOfClass:[Forecast class] fromJSONDictionary:[self.responseObject valueForKey:@"data"] error:NULL];
    }
    return self;
}

- (Forecast *)forecast
{
    return self.mappedResponseObject;
}

- (BOOL)succes
{
    return [super succes] && self.forecast != nil && self.forecast.weather.count != 0;
}

- (BOOL)noContent
{
    return [super noContent] || self.forecast == nil || self.forecast.weather.count == 0;
}

@end
