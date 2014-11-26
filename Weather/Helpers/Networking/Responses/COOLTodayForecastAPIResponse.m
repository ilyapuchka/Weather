//
//  COOLForecastAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecastAPIResponse.h"
#import "EKObjectMapping.h"
#import "COOLTodayForecast+Mapping.h"

@implementation COOLTodayForecastAPIResponse

- (COOLTodayForecast *)todayForecast
{
    return [self.mappedResponseObject valueForKey:@"forecast"];
}

+ (id)responseMapping
{
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"data" toField:@"forecast" withValueBlock:^id(NSString *key, NSDictionary *value) {
            Forecast *forecast = [Forecast modelObjectWithDictionary:value];
            return forecast;
        }];
    }];
}

- (BOOL)succes
{
    return [super succes] && self.todayForecast != nil && self.todayForecast.weather.count != 0;
}

- (BOOL)noContent
{
    return [super noContent] || self.todayForecast == nil || self.todayForecast.weather.count == 0;
}

@end
