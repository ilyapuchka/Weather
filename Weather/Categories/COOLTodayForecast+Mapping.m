//
//  COOLTodayForecast+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayForecast+Mapping.h"
#import "EKObjectMapping.h"
#import "EKMapper.h"

@interface COOLCurrentCondition (Mapping) <COOLMapping>

@end

@implementation COOLCurrentCondition (Mapping)

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"weatherDesc" toField:@"weatherCondition" withValueBlock:self.weatherConditionMappingBlock];
        
        [mapping mapKey:@"temp_C" toField:@"temperatureC"];
        [mapping mapKey:@"temp_F" toField:@"temperatureF"];
        
        [mapping mapKey:@"precipMM" toField:@"precip"];
        [mapping mapKey:@"pressure" toField:@"pressure"];
        [mapping mapKey:@"humidity" toField:@"humidity"];
        [mapping mapKey:@"winddir16Point" toField:@"windDirection"];
        [mapping mapKey:@"windspeedKmph" toField:@"windSpeedKmph"];
        [mapping mapKey:@"windspeedMiles" toField:@"windSpeedMiles"];
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

#pragma mark -

@interface COOLTodayForecastWeather (Mapping) <COOLMapping>

@end

@implementation COOLTodayForecastWeather (Mapping)

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"date" toField:@"date" withDateFormat:@"yyyy-MM-dd"];
        
        [mapping hasOneMapping:[EKObjectMapping mappingForClass:[COOLTodayForecastWeatherHourly class] withBlock:^(EKObjectMapping *mapping) {
            [mapping mapFieldsFromDictionary:@{@"chanceofrain": @"chanceOfRain",
                                               @"chanceofsnow": @"chanceOfSnow",
                                               @"chanceofthunder": @"chanceOfThunder",
                                               @"chanceofsunshine": @"chanceOfSunshine"}];
        }] forKey:@"hourly.@lastObject" forField:@"hourly"];
    }];
}

@end

#pragma mark -

@implementation COOLTodayForecast (Mapping)

+ (id)mapping
{
    return [EKObjectMapping mappingForClass:self withRootPath:nil withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"request.@lastObject" toField:@"cityName" withValueBlock:self.cityMappingBlock];
        [mapping mapKey:@"current_condition.@lastObject" toField:@"currentCondition" withValueBlock:self.currentConditionMappingBlock];
        [mapping mapKey:@"weather.@lastObject" toField:@"weather" withValueBlock:self.weatherMappingBlock];
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

+ (id(^)(NSString *key, id value))currentConditionMappingBlock
{
    return ^id(NSString *key, NSDictionary *value) {
        COOLCurrentCondition *cond = [EKMapper objectFromExternalRepresentation:value withMapping:[COOLCurrentCondition mapping]];
        return cond;
    };
}

+ (id(^)(NSString *key, id value))weatherMappingBlock
{
    return ^id(NSString *key, NSDictionary *value) {
        COOLTodayForecastWeather *weather = [EKMapper objectFromExternalRepresentation:value withMapping:[COOLTodayForecastWeather mapping]];
        return weather;
    };
}

@end
