//
//  Hourly.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Hourly.h"
#import "WeatherDesc.h"

@interface Hourly ()

@property (nonatomic, copy, readwrite) NSString *winddir16Point;
@property (nonatomic, copy, readwrite) NSString *humidity;
@property (nonatomic, copy, readwrite) NSString *tempF;
@property (nonatomic, copy, readwrite) NSString *chanceofthunder;
@property (nonatomic, copy, readwrite) NSString *chanceofsnow;
@property (nonatomic, copy, readwrite) NSString *chanceofrain;
@property (nonatomic, copy, readwrite) NSString *chanceofsunshine;
@property (nonatomic, copy, readwrite) NSString *windspeedKmph;
@property (nonatomic, copy, readwrite) NSString *pressure;
@property (nonatomic, copy, readwrite) NSString *windspeedMiles;
@property (nonatomic, copy, readwrite) NSArray *weatherDesc;
@property (nonatomic, copy, readwrite) NSArray *localizedWeatherDesc;
@property (nonatomic, copy, readwrite) NSString *tempC;
@property (nonatomic, copy, readwrite) NSString *precipMM;
@property (nonatomic, copy, readwrite) NSString *time;

@end

@implementation Hourly

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        self.localizedWeatherDesc = self.localizedWeatherDesc?:self.weatherDesc;
    }
    return self;
}

- (NSArray *)localizedWeatherDesc
{
    if (!_localizedWeatherDesc) {
        return _weatherDesc;
    }
    return _localizedWeatherDesc;
}

@end
