//
//  COOLForecast+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecast+Mapping.h"
#import "EKObjectMapping.h"
#import "EKMapper.h"

@interface COOLForecastWeather (Mapping) <COOLMapping>

@end

@implementation COOLForecastWeather (Mapping)

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"date" toField:@"date" withDateFormat:@"yyyy-MM-dd"];
        
        [mapping hasOneMapping:[EKObjectMapping mappingForClass:[COOLForecastWeatherHourly class] withBlock:^(EKObjectMapping *mapping) {
            [mapping mapKey:@"tempC" toField:@"temperatureC"];
            [mapping mapKey:@"tempF" toField:@"temperatureF"];
            [mapping mapKey:@"weatherDesc.@lastObject" toField:@"weatherCondition" withValueBlock:self.weatherConditionMappingBlock];
        }] forKey:@"hourly.@lastObject" forField:@"hourly"];
    }];
}

+ (id(^)(NSString *key, id value))weatherConditionMappingBlock
{
    return ^id(NSString *key, NSDictionary *value) {
        if (![value isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        return [value valueForKey:@"value"];
    };
}

@end

@implementation COOLForecast (Mapping)

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:self withRootPath:nil withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"request.@lastObject" toField:@"cityName" withValueBlock:self.cityMappingBlock];
        [mapping hasManyMapping:[COOLForecastWeather mapping] forKey:@"weather" forField:@"weatherByDay"];
    }];
}

+ (id(^)(NSString *key, id value))cityMappingBlock
{
    return ^id(NSString *key, NSDictionary *value) {
        if (![value isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        return [value valueForKey:@"query"];
    };
}

@end
