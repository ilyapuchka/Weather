//
//  Weather.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface Weather : MTLModel

@property (nonatomic, copy, readonly) NSArray *hourly;
@property (nonatomic, copy, readonly) NSString *date;

@end
