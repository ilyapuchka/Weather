//
//  COOLAPIResponse+Package.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 06.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponse+Package.h"
#import "COOLAPIResponse_Private.h"
#import "COOLAPIResponseBuilder.h"

@implementation COOLAPIResponse (Package)

- (instancetype)initWithBuilder:(COOLAPIResponseBuilder *)builder
{
    self = [super init];
    if (self) {
        self.task = builder.task;
        self.response = builder.response;
        self.error = builder.error;
        self.responseObject = builder.responseObject;
        self.mappedResponseObject = builder.mappedResponseObject;
    }
    return self;
}

@end
