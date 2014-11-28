//
//  Country.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface Country : MTLModel

@property (nonatomic, copy, readonly) NSString *value;

@end
