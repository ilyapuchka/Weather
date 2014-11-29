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

- (Forecast *)forecast
{
    return [self.mappedResponseObject valueForKey:@"forecast"];
}

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"data" toField:@"forecast" withValueBlock:^id(NSString *key, id value) {
            return [MTLJSONAdapter modelOfClass:[Forecast class] fromJSONDictionary:value error:NULL];
        }];
    }];
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
