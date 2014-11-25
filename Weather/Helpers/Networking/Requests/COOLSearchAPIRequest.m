//
//  COOLSearchAPIRequest.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLSearchAPIRequest.h"

@implementation COOLSearchAPIRequest

- (instancetype)initWithQuery:(NSString *)query
{
    NSCParameterAssert(query);
    if (!query) {
        return nil;
    }
    
    return [self initWithMethod:COOLAPIGETRequest path:@"search.ashx" parameters:@{@"q": query}];
}

@end
