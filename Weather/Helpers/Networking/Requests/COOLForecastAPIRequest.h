//
//  COOLForecastAPIRequest.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIRequest.h"

@interface COOLForecastAPIRequest : COOLAPIRequest

- (instancetype)initWithQuery:(NSString *)query;

@end
