//
//  BaseClass.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface Location : MTLModel

@property (nonatomic, copy, readonly) NSArray *region;
@property (nonatomic, copy, readonly) NSArray *country;
@property (nonatomic, copy, readonly) NSString *longitude;
@property (nonatomic, copy, readonly) NSString *latitude;
@property (nonatomic, copy, readonly) NSArray *areaName;

- (NSString *)displayName;

@end
