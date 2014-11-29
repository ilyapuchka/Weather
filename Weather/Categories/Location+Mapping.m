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
        [mapping hasManyMapping:[SimpleValue mapping] forKey:@"region"];
        [mapping hasManyMapping:[SimpleValue mapping] forKey:@"country"];
        [mapping hasManyMapping:[SimpleValue mapping] forKey:@"areaName"];
        [mapping mapFieldsFromArray:@[@"longitude", @"latitude"]];
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
