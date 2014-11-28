//
//  SimpleValue.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface SimpleValue : MTLModel

@property (nonatomic, copy, readonly) NSString *value;

@end
