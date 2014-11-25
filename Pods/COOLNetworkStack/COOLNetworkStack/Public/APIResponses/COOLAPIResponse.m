//
//  COOLAPIResponse.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponse.h"
#import "COOLAPIResponse_Private.h"
#import "COOLAPIResponse+Package.h"
#import "COOLAPIResponseBuilder.h"

@implementation COOLAPIResponse

+ (instancetype)responseWithBlock:(void (^)(COOLAPIResponseBuilder *))buildBlock
{
    COOLAPIResponseBuilder *builder = [COOLAPIResponseBuilder new];
    buildBlock(builder);
    return [builder build:self];
}

+ (id)responseMapping
{
    return nil;
}

- (BOOL)succes
{
    return self.error == nil && self.mappedResponseObject != nil;
}

- (BOOL)noContent
{
    return self.error == nil && self.mappedResponseObject == nil;
}

@end
