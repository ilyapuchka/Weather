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
        [mapping mapPropertiesFromArray:@[@"winddir16Point", @"humidity", @"tempF", @"chanceofthunder", @"chanceofsnow", @"chanceofrain", @"chanceofsunshine", @"windspeedKmph", @"pressure", @"windspeedMiles", @"tempC", @"precipMM", @"time"]];
        [mapping hasMany:[SimpleValue class] forKeyPath:@"weatherDesc" forProperty:@"weatherDesc" withObjectMapping:[SimpleValue mapping]];
        
        NSString *localizedWeatherDescKey = [NSString stringWithFormat:@"lang_%@", [[NSLocale preferredLanguages] firstObject]];
        [mapping hasMany:[SimpleValue class] forKeyPath:localizedWeatherDescKey forProperty:@"localizedWeatherDesc" withObjectMapping:[SimpleValue mapping]];
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
