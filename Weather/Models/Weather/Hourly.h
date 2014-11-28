//
//  Hourly.h
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"

@interface Hourly : MTLModel

@property (nonatomic, copy, readonly) NSString *winddir16Point;
@property (nonatomic, copy, readonly) NSString *humidity;
@property (nonatomic, copy, readonly) NSString *tempF;
@property (nonatomic, copy, readonly) NSString *chanceofthunder;
@property (nonatomic, copy, readonly) NSString *chanceofsnow;
@property (nonatomic, copy, readonly) NSString *chanceofrain;
@property (nonatomic, copy, readonly) NSString *chanceofsunshine;
@property (nonatomic, copy, readonly) NSString *windspeedKmph;
@property (nonatomic, copy, readonly) NSString *pressure;
@property (nonatomic, copy, readonly) NSString *windspeedMiles;
@property (nonatomic, copy, readonly) NSArray *weatherDesc;
@property (nonatomic, copy, readonly) NSArray *localizedWeatherDesc;
@property (nonatomic, copy, readonly) NSString *tempC;
@property (nonatomic, copy, readonly) NSString *precipMM;
@property (nonatomic, copy, readonly) NSString *time;

@end
