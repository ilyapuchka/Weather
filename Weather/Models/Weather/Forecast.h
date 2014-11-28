//
//  BaseClass.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@class Hourly;

@interface Forecast : MTLModel

@property (nonatomic, copy, readonly) NSArray *weather;
@property (nonatomic, copy, readonly) NSArray *timeZone;

- (Hourly *)currentHourly;

@end
