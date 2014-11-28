//
//  COOLSearchAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsSearchAPIResponse.h"
#import "Location+Mapping.h"

@implementation COOLLocationsSearchAPIResponse

- (NSArray *)locations
{
    return [self.mappedResponseObject valueForKey:@"locations"];
}

+ (id)responseMapping
{
    return [EKObjectMapping mappingForClass:[NSMutableDictionary class] withRootPath:@"search_api" withBlock:^(EKObjectMapping *mapping) {
        [mapping hasManyMapping:[Location mapping] forKey:@"result" forField:@"locations"];
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
