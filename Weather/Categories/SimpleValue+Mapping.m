//
//  SimpleValue+Mapping.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "SimpleValue+Mapping.h"

@implementation SimpleValue (Mapping)

+ (EKObjectMapping *)mapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"value"]];
    }];
}

@end
