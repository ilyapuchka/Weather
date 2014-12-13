//
//  COOLSearchAPIResponse.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsSearchAPIResponse.h"
#import "Location+Mapping.h"
#import "Mantle.h"

@interface COOLLocationsSearchAPIResponse()

@property (nonatomic, strong) NSArray *mappedResponseObject;

@end

@implementation COOLLocationsSearchAPIResponse

- (BOOL)mapResponseObject:(NSError *__autoreleasing *)error
{
    NSError *mappingError;
    NSArray *array = [MTLJSONAdapter modelsOfClass:[Location class] fromJSONArray:[self.responseObject valueForKeyPath:@"search_api.result"] error:&mappingError];
    self.mappedResponseObject = array;
    if (error) *error = mappingError;
    return (mappingError == nil);
}

- (NSArray *)locations
{
    return self.mappedResponseObject;
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
