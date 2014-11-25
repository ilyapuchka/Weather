//
//  COOLForecastAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecastAPIResponse.h"
#import "EKObjectMapping.h"
#import "EKMapper.h"
#import "COOLTodayForecast+Mapping.h"

@implementation COOLTodayForecastAPIResponse

- (COOLTodayForecast *)todayForecast
{
    return [self.mappedResponseObject valueForKey:@"forecast"];
}

+ (id)responseMapping
{
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withBlock:^(EKObjectMapping *mapping) {
        [mapping hasOneMapping:[COOLTodayForecast mapping] forKey:@"data" forField:@"forecast"];
    }];
}

@end
