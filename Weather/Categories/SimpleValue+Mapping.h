//
//  SimpleValue+Mapping.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "SimpleValue.h"
#import "EKObjectMapping.h"

@interface SimpleValue (Mapping)

+ (EKObjectMapping *)mapping;

@end
