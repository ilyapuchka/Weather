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

@interface COOLDailyForecastAPIResponse()

@property (nonatomic, strong) Forecast *mappedResponseObject;

@end

@implementation COOLDailyForecastAPIResponse

- (BOOL)mapResponseObject:(NSError *__autoreleasing *)error
{
    NSError *mappingError;
    _mappedResponseObject = [MTLJSONAdapter modelOfClass:[Forecast class] fromJSONDictionary:[self.responseObject valueForKey:@"data"] error:&mappingError];
    if (error) *error = mappingError;
    return (mappingError == nil);
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
