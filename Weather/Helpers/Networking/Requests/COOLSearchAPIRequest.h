//
//  COOLSearchAPIRequest.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIRequest.h"
@import UIKit;

@interface COOLSearchAPIRequest : COOLAPIRequest

- (instancetype)initWithQuery:(NSString *)query;
- (instancetype)initWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude;

@end
