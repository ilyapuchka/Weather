//
//  Forecast+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Forecast+Mapping.h"
#import "TimeZone+Mapping.h"
#import "Weather+Mapping.h"

@implementation Forecast (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping hasManyMapping:[TimeZone mapping] forKey:@"time_zone" forField:@"timeZone"];
        [mapping hasManyMapping:[Weather mapping] forKey:@"weather"];
    }];
}

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"timeZone": @"time_zone"};
}

+ (NSValueTransformer *)weatherJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather class]];
}

+ (NSValueTransformer *)timeZoneJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[TimeZone class]];
}

@end
