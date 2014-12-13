//
//  TimeZone+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "TimeZone+Mapping.h"

@implementation TimeZone (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromArray:@[@"utcOffset", @"localtime"]];
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

@end
