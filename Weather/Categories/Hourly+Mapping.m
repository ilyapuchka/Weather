//
//  Hourly+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Hourly+Mapping.h"
#import "SimpleValue+Mapping.h"
#import "EKObjectMapping+Transfromers.h"
#import "EKMapper.h"

@implementation Hourly (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"winddir16Point", @"humidity", @"tempF", @"chanceofthunder", @"chanceofsnow", @"chanceofrain", @"chanceofsunshine", @"windspeedKmph", @"pressure", @"windspeedMiles", @"tempC", @"precipMM", @"time"]];
        [mapping hasManyMapping:[SimpleValue mapping] forKey:@"weatherDesc"];
        [mapping mapKey:@"@self" toField:@"localizedWeatherDesc" withValueBlock:^id(NSString *key, NSDictionary *value) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] 'lang_'"];
            key = [[value.allKeys filteredArrayUsingPredicate:predicate] lastObject];
            if (key) {
                return [[EKObjectMapping defaultMapperClass] objectFromExternalRepresentation:value[key] withMapping:[SimpleValue mapping]];
            }
            else {
                return [[EKObjectMapping defaultMapperClass] objectFromExternalRepresentation:value[@"weatherDesc"] withMapping:[SimpleValue mapping]];
            }
        }];
    }];
}

@end
