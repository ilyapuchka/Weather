//
//  Weather.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Weather.h"
#import "Hourly.h"


NSString *const kWeatherHourly = @"hourly";
NSString *const kWeatherDate = @"date";


@interface Weather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Weather

@synthesize hourly = _hourly;
@synthesize date = _date;

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
        NSObject *receivedHourly = [dict objectForKey:kWeatherHourly];
        NSMutableArray *parsedHourly = [NSMutableArray array];
        if ([receivedHourly isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedHourly) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedHourly addObject:[Hourly modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedHourly isKindOfClass:[NSDictionary class]]) {
           [parsedHourly addObject:[Hourly modelObjectWithDictionary:(NSDictionary *)receivedHourly]];
        }

        self.hourly = [NSArray arrayWithArray:parsedHourly];
        self.date = [self objectOrNilForKey:kWeatherDate fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForHourly = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hourly) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHourly addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHourly addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHourly] forKey:kWeatherHourly];
    [mutableDict setValue:self.date forKey:kWeatherDate];

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

    self.hourly = [aDecoder decodeObjectForKey:kWeatherHourly];
    self.date = [aDecoder decodeObjectForKey:kWeatherDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hourly forKey:kWeatherHourly];
    [aCoder encodeObject:_date forKey:kWeatherDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    Weather *copy = [[Weather alloc] init];
    
    if (copy) {

        copy.hourly = [self.hourly copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
