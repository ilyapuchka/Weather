//
//  Hourly.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Hourly.h"
#import "WeatherDesc.h"


NSString *const kHourlyWinddir16Point = @"winddir16Point";
NSString *const kHourlyHumidity = @"humidity";
NSString *const kHourlyTempF = @"tempF";
NSString *const kHourlyChanceofthunder = @"chanceofthunder";
NSString *const kHourlyWindChillF = @"WindChillF";
NSString *const kHourlyWindspeedKmph = @"windspeedKmph";
NSString *const kHourlyPressure = @"pressure";
NSString *const kHourlyWindspeedMiles = @"windspeedMiles";
NSString *const kHourlyChanceofsnow = @"chanceofsnow";
NSString *const kHourlyChanceofrain = @"chanceofrain";
NSString *const kHourlyWeatherDesc = @"weatherDesc";
NSString *const kHourlyTempC = @"tempC";
NSString *const kHourlyPrecipMM = @"precipMM";
NSString *const kHourlyChanceofsunshine = @"chanceofsunshine";
NSString *const kHourlyTime = @"time";


@interface Hourly ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Hourly

@synthesize winddir16Point = _winddir16Point;
@synthesize humidity = _humidity;
@synthesize tempF = _tempF;
@synthesize chanceofthunder = _chanceofthunder;
@synthesize windspeedKmph = _windspeedKmph;
@synthesize pressure = _pressure;
@synthesize windspeedMiles = _windspeedMiles;
@synthesize chanceofsnow = _chanceofsnow;
@synthesize chanceofrain = _chanceofrain;
@synthesize weatherDesc = _weatherDesc;
@synthesize tempC = _tempC;
@synthesize precipMM = _precipMM;
@synthesize chanceofsunshine = _chanceofsunshine;
@synthesize time = _time;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.winddir16Point = [self objectOrNilForKey:kHourlyWinddir16Point fromDictionary:dict];
        self.humidity = [self objectOrNilForKey:kHourlyHumidity fromDictionary:dict];
        self.tempF = [self objectOrNilForKey:kHourlyTempF fromDictionary:dict];
        self.chanceofthunder = [self objectOrNilForKey:kHourlyChanceofthunder fromDictionary:dict];
        self.windspeedKmph = [self objectOrNilForKey:kHourlyWindspeedKmph fromDictionary:dict];
        self.pressure = [self objectOrNilForKey:kHourlyPressure fromDictionary:dict];
        self.windspeedMiles = [self objectOrNilForKey:kHourlyWindspeedMiles fromDictionary:dict];
        self.chanceofsnow = [self objectOrNilForKey:kHourlyChanceofsnow fromDictionary:dict];
        self.chanceofrain = [self objectOrNilForKey:kHourlyChanceofrain fromDictionary:dict];

        NSObject *receivedWeatherDesc = [dict objectForKey:kHourlyWeatherDesc];
        NSObject *localizedWeatherDesc = [dict objectForKey:[NSString stringWithFormat:@"lang_%@", [[NSLocale preferredLanguages] firstObject]?:@"en"]];
        if (localizedWeatherDesc) {
            receivedWeatherDesc = localizedWeatherDesc;
        }
        NSMutableArray *parsedWeatherDesc = [NSMutableArray array];
        if ([receivedWeatherDesc isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedWeatherDesc) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedWeatherDesc addObject:[WeatherDesc modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedWeatherDesc isKindOfClass:[NSDictionary class]]) {
           [parsedWeatherDesc addObject:[WeatherDesc modelObjectWithDictionary:(NSDictionary *)receivedWeatherDesc]];
        }

        self.weatherDesc = [NSArray arrayWithArray:parsedWeatherDesc];
        self.tempC = [self objectOrNilForKey:kHourlyTempC fromDictionary:dict];
        self.precipMM = [self objectOrNilForKey:kHourlyPrecipMM fromDictionary:dict];
        self.chanceofsunshine = [self objectOrNilForKey:kHourlyChanceofsunshine fromDictionary:dict];
        self.time = [self objectOrNilForKey:kHourlyTime fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.winddir16Point forKey:kHourlyWinddir16Point];
    [mutableDict setValue:self.humidity forKey:kHourlyHumidity];
    [mutableDict setValue:self.tempF forKey:kHourlyTempF];
    [mutableDict setValue:self.chanceofthunder forKey:kHourlyChanceofthunder];
    [mutableDict setValue:self.windspeedKmph forKey:kHourlyWindspeedKmph];
    [mutableDict setValue:self.pressure forKey:kHourlyPressure];
    [mutableDict setValue:self.windspeedMiles forKey:kHourlyWindspeedMiles];
    [mutableDict setValue:self.chanceofsnow forKey:kHourlyChanceofsnow];
    [mutableDict setValue:self.chanceofrain forKey:kHourlyChanceofrain];
    NSMutableArray *tempArrayForWeatherDesc = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weatherDesc) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeatherDesc addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeatherDesc addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeatherDesc] forKey:kHourlyWeatherDesc];
    [mutableDict setValue:self.tempC forKey:kHourlyTempC];
    [mutableDict setValue:self.precipMM forKey:kHourlyPrecipMM];
    [mutableDict setValue:self.chanceofsunshine forKey:kHourlyChanceofsunshine];
    [mutableDict setValue:self.time forKey:kHourlyTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.winddir16Point = [aDecoder decodeObjectForKey:kHourlyWinddir16Point];
    self.humidity = [aDecoder decodeObjectForKey:kHourlyHumidity];
    self.tempF = [aDecoder decodeObjectForKey:kHourlyTempF];
    self.chanceofthunder = [aDecoder decodeObjectForKey:kHourlyChanceofthunder];
    self.windspeedKmph = [aDecoder decodeObjectForKey:kHourlyWindspeedKmph];
    self.pressure = [aDecoder decodeObjectForKey:kHourlyPressure];
    self.windspeedMiles = [aDecoder decodeObjectForKey:kHourlyWindspeedMiles];
    self.chanceofsnow = [aDecoder decodeObjectForKey:kHourlyChanceofsnow];
    self.chanceofrain = [aDecoder decodeObjectForKey:kHourlyChanceofrain];
    self.weatherDesc = [aDecoder decodeObjectForKey:kHourlyWeatherDesc];
    self.tempC = [aDecoder decodeObjectForKey:kHourlyTempC];
    self.precipMM = [aDecoder decodeObjectForKey:kHourlyPrecipMM];
    self.chanceofsunshine = [aDecoder decodeObjectForKey:kHourlyChanceofsunshine];
    self.time = [aDecoder decodeObjectForKey:kHourlyTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_winddir16Point forKey:kHourlyWinddir16Point];
    [aCoder encodeObject:_humidity forKey:kHourlyHumidity];
    [aCoder encodeObject:_tempF forKey:kHourlyTempF];
    [aCoder encodeObject:_chanceofthunder forKey:kHourlyChanceofthunder];
    [aCoder encodeObject:_windspeedKmph forKey:kHourlyWindspeedKmph];
    [aCoder encodeObject:_pressure forKey:kHourlyPressure];
    [aCoder encodeObject:_windspeedMiles forKey:kHourlyWindspeedMiles];
    [aCoder encodeObject:_chanceofsnow forKey:kHourlyChanceofsnow];
    [aCoder encodeObject:_chanceofrain forKey:kHourlyChanceofrain];
    [aCoder encodeObject:_weatherDesc forKey:kHourlyWeatherDesc];
    [aCoder encodeObject:_tempC forKey:kHourlyTempC];
    [aCoder encodeObject:_precipMM forKey:kHourlyPrecipMM];
    [aCoder encodeObject:_chanceofsunshine forKey:kHourlyChanceofsunshine];
    [aCoder encodeObject:_time forKey:kHourlyTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    Hourly *copy = [[Hourly alloc] init];
    
    if (copy) {

        copy.winddir16Point = [self.winddir16Point copyWithZone:zone];
        copy.humidity = [self.humidity copyWithZone:zone];
        copy.tempF = [self.tempF copyWithZone:zone];
        copy.chanceofthunder = [self.chanceofthunder copyWithZone:zone];
        copy.windspeedKmph = [self.windspeedKmph copyWithZone:zone];
        copy.pressure = [self.pressure copyWithZone:zone];
        copy.windspeedMiles = [self.windspeedMiles copyWithZone:zone];
        copy.chanceofsnow = [self.chanceofsnow copyWithZone:zone];
        copy.chanceofrain = [self.chanceofrain copyWithZone:zone];
        copy.weatherDesc = [self.weatherDesc copyWithZone:zone];
        copy.tempC = [self.tempC copyWithZone:zone];
        copy.precipMM = [self.precipMM copyWithZone:zone];
        copy.chanceofsunshine = [self.chanceofsunshine copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
    }
    
    return copy;
}


@end
