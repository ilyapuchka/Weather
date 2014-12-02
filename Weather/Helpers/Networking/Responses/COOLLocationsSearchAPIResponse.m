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

@implementation COOLLocationsSearchAPIResponse

- (instancetype)initWithTask:(NSURLSessionDataTask *)task response:(NSHTTPURLResponse *)response responseObject:(id)responseObject error:(NSError *)error
{
    self = [super initWithTask:task response:response responseObject:responseObject error:error];
    if (self) {
        _mappedResponseObject = [MTLJSONAdapter modelsOfClass:[Location class] fromJSONArray:[self.responseObject valueForKeyPath:@"search_api.result"] error:NULL];
    }
    return self;
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
