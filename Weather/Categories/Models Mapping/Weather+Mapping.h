//
//  Weather+Mapping.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Weather.h"
#import "EKObjectMapping.h"
#import "Mantle.h"

@interface Weather (Mapping) <MTLJSONSerializing>

+ (EKObjectMapping *)mapping;

@end
