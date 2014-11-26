//
//  COOLSearchAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLSearchAPIResponse.h"
#import "EKObjectMapping+Transfromers.h"
#import "Location.h"
#import "EKMapper.h"

@implementation COOLSearchAPIResponse

- (NSArray *)locations
{
    return [self.mappedResponseObject valueForKey:@"locations"];
}

+ (id)responseMapping
{
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withRootPath:@"search_api" withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKey:@"result" toField:@"locations" withValueBlock:^id(NSString *key, NSArray *value) {
            NSMutableArray *locations = [@[] mutableCopy];
            for (NSDictionary *dict in value) {
                Location *loc = [Location modelObjectWithDictionary:dict];
                if (loc) [locations addObject:loc];
            }
            return [locations copy];
        }];
    }];
}

- (BOOL)succes
{
    return [super succes] && self.locations != nil && self.locations.count > 0;
}

- (BOOL)noContent
{
    return [super noContent] || self.locations == nil || self.locations.count == 0;
}

@end
