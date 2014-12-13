//
//  Location+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Location+Mapping.h"
#import "SimpleValue+Mapping.h"

@implementation Location (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping hasMany:[SimpleValue class] forKeyPath:@"region" forProperty:@"region" withObjectMapping:[SimpleValue mapping]];
        [mapping hasMany:[SimpleValue class] forKeyPath:@"country" forProperty:@"country" withObjectMapping:[SimpleValue mapping]];
        [mapping hasMany:[SimpleValue class] forKeyPath:@"areaName" forProperty:@"areaName" withObjectMapping:[SimpleValue mapping]];
        [mapping hasMany:[SimpleValue class] forKeyPath:@"region" forProperty:@"region" withObjectMapping:[SimpleValue mapping]];
        [mapping mapPropertiesFromArray:@[@"longitude", @"latitude"]];
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    if ([key isEqualToString:@"longitude"] ||
        [key isEqualToString:@"latitude"]) {
        return nil;
    }
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[SimpleValue class]];
}

@end
