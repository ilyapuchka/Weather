//
//  BaseClass.m
//
//  Created by Ilya Puchka on 26.11.14
//  Copyright (c) 2014 Rambler&Co. All rights reserved.
//

#import "Location.h"
#import "Region.h"
#import "Country.h"
#import "AreaName.h"


NSString *const kBaseClassRegion = @"region";
NSString *const kBaseClassCountry = @"country";
NSString *const kBaseClassLongitude = @"longitude";
NSString *const kBaseClassLatitude = @"latitude";
NSString *const kBaseClassAreaName = @"areaName";


@interface Location ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Location

@synthesize region = _region;
@synthesize country = _country;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize areaName = _areaName;


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
        NSObject *receivedRegion = [dict objectForKey:kBaseClassRegion];
        NSMutableArray *parsedRegion = [NSMutableArray array];
        if ([receivedRegion isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRegion) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRegion addObject:[Region modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedRegion isKindOfClass:[NSDictionary class]]) {
           [parsedRegion addObject:[Region modelObjectWithDictionary:(NSDictionary *)receivedRegion]];
        }

        self.region = [NSArray arrayWithArray:parsedRegion];
        NSObject *receivedCountry = [dict objectForKey:kBaseClassCountry];
        NSMutableArray *parsedCountry = [NSMutableArray array];
        if ([receivedCountry isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedCountry) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedCountry addObject:[Country modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedCountry isKindOfClass:[NSDictionary class]]) {
           [parsedCountry addObject:[Country modelObjectWithDictionary:(NSDictionary *)receivedCountry]];
        }

        self.country = [NSArray arrayWithArray:parsedCountry];
        self.longitude = [self objectOrNilForKey:kBaseClassLongitude fromDictionary:dict];
        self.latitude = [self objectOrNilForKey:kBaseClassLatitude fromDictionary:dict];

        NSObject *receivedAreaName = [dict objectForKey:kBaseClassAreaName];
        NSMutableArray *parsedAreaName = [NSMutableArray array];
        if ([receivedAreaName isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedAreaName) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedAreaName addObject:[AreaName modelObjectWithDictionary:item]];
                }
           }
        } else if ([receivedAreaName isKindOfClass:[NSDictionary class]]) {
           [parsedAreaName addObject:[AreaName modelObjectWithDictionary:(NSDictionary *)receivedAreaName]];
        }

        self.areaName = [NSArray arrayWithArray:parsedAreaName];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForRegion = [NSMutableArray array];
    for (NSObject *subArrayObject in self.region) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRegion addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRegion addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRegion] forKey:kBaseClassRegion];
    NSMutableArray *tempArrayForCountry = [NSMutableArray array];
    for (NSObject *subArrayObject in self.country) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCountry addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCountry addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCountry] forKey:kBaseClassCountry];
    [mutableDict setValue:self.longitude forKey:kBaseClassLongitude];
    [mutableDict setValue:self.latitude forKey:kBaseClassLatitude];
    NSMutableArray *tempArrayForAreaName = [NSMutableArray array];
    for (NSObject *subArrayObject in self.areaName) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAreaName addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAreaName addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAreaName] forKey:kBaseClassAreaName];

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

    self.region = [aDecoder decodeObjectForKey:kBaseClassRegion];
    self.country = [aDecoder decodeObjectForKey:kBaseClassCountry];
    self.longitude = [aDecoder decodeObjectForKey:kBaseClassLongitude];
    self.latitude = [aDecoder decodeObjectForKey:kBaseClassLatitude];
    self.areaName = [aDecoder decodeObjectForKey:kBaseClassAreaName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_region forKey:kBaseClassRegion];
    [aCoder encodeObject:_country forKey:kBaseClassCountry];
    [aCoder encodeObject:_longitude forKey:kBaseClassLongitude];
    [aCoder encodeObject:_latitude forKey:kBaseClassLatitude];
    [aCoder encodeObject:_areaName forKey:kBaseClassAreaName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Location *copy = [[Location alloc] init];
    
    if (copy) {

        copy.region = [self.region copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.areaName = [self.areaName copyWithZone:zone];
    }
    
    return copy;
}

- (NSString *)displayName
{
    NSMutableArray *nameComponents = [@[] mutableCopy];
    void(^addBlock)(NSString *) = ^ void(NSString *string){
        if (string.length > 0) {
            [nameComponents addObject:string];
        }
    };
    addBlock([self.areaName.lastObject value]);
    addBlock([self.region.lastObject value]);
    return [nameComponents componentsJoinedByString:@", "];
}

- (BOOL)isEqual:(Location *)object
{
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.longitude == object.longitude && self.latitude == object.latitude;
}

- (NSUInteger)hash
{
    return [self.longitude hash] ^ [self.latitude hash];
}

@end
