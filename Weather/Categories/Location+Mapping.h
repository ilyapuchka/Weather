//
//  Location+Mapping.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "Location.h"
#import "EKObjectMapping.h"

@interface Location (Mapping)

+ (EKObjectMapping *)mapping;

@end
