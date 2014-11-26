//
//  COOLBatchForecastsAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLBatchForecastsAPIResponse.h"
#import "EKObjectMapping.h"

@implementation COOLBatchForecastsAPIResponse

- (NSArray *)forecasts
{
    return [self.mappedResponseObject valueForKey:@"forecasts"];
}

+ (id)responseMapping
{
#warning TODO
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"data" toField:@"forecast" withValueBlock:^id(NSString *key, NSDictionary *value) {
            Forecast *forecast = [Forecast modelObjectWithDictionary:value];
            return forecast;
        }];
    }];
}

@end
