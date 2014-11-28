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

@interface Location ()

@property (nonatomic, copy, readwrite) NSArray *region;
@property (nonatomic, copy, readwrite) NSArray *country;
@property (nonatomic, copy, readwrite) NSString *longitude;
@property (nonatomic, copy, readwrite) NSString *latitude;
@property (nonatomic, copy, readwrite) NSArray *areaName;

@end

@implementation Location

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
    return (object != nil &&
            ((self.longitude == nil && object.longitude == nil) || [self.longitude isEqual:object.longitude]) &&
            ((self.latitude == nil && object.latitude == nil) || [self.latitude isEqual:object.latitude]));
}

- (NSUInteger)hash
{
    return [self.longitude hash] ^ [self.latitude hash];
}

@end
