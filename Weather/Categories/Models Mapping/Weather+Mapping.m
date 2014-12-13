//
//  Weather+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Weather+Mapping.h"
#import "Hourly+Mapping.h"

@implementation Weather (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping hasMany:[Hourly class] forKeyPath:@"hourly" forProperty:@"hourly" withObjectMapping:[Hourly mapping]];
        [mapping mapPropertiesFromArray:@[@"date"]];
    }];
}

#pragma mark - Mantle

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)hourlyJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[Hourly class]];
}

@end
