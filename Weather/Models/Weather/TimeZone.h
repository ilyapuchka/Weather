//
//  TimeZone.h
//
//  Created by Ilya Puchka on 27.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface TimeZone : MTLModel

@property (nonatomic, copy, readonly) NSString *utcOffset;
@property (nonatomic, copy, readonly) NSString *localtime;

@end
