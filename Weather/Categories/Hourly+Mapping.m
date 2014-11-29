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
        
        NSString *localizedWeatherDescKey = [NSString stringWithFormat:@"lang_%@", [[NSLocale preferredLanguages] firstObject]];
        [mapping hasManyMapping:[SimpleValue mapping] forKey:localizedWeatherDescKey forField:@"localizedWeatherDesc"];
    }];
}

#pragma mark - Mantle

+ (NSString *)localizedWeatherDescKey
{
    NSString *localizedWeatherDescKey = [NSString stringWithFormat:@"lang_%@", [[NSLocale preferredLanguages] firstObject]];
    return localizedWeatherDescKey;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"localizedWeatherDesc": [self localizedWeatherDescKey]};
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"weatherDesc"] ||
        [key isEqualToString:@"localizedWeatherDesc"]) {
        return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[SimpleValue class]];
    }
    return nil;
}

@end
