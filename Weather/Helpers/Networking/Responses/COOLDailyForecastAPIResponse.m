//
//  COOLDailyForecastAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDailyForecastAPIResponse.h"
#import "EKObjectMapping.h"

@implementation COOLDailyForecastAPIResponse

- (Forecast *)forecast
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

@end
