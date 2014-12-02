//
//  COOLAPIResponse.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponse.h"

@interface COOLAPIResponse ()

@property (nonatomic, copy, readwrite) NSURLSessionDataTask *task;
@property (nonatomic, copy, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, copy, readwrite) NSError *error;
@property (nonatomic, strong, readwrite) id responseObject;

@end

@implementation COOLAPIResponse

- (instancetype)initWithTask:(NSURLSessionDataTask *)task
                    response:(NSHTTPURLResponse *)response
              responseObject:(id)responseObject
                       error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.task = task;
        self.responseObject = responseObject;
        self.response = response;
        self.error = error;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithTask:self.task response:self.response responseObject:self.responseObject error:self.error];
}

- (id)mappedResponseObject
{
    return self.responseObject;
}

- (BOOL)succes
{
    return self.error == nil && self.mappedResponseObject != nil;
}

- (BOOL)noContent
{
    return self.error == nil && self.mappedResponseObject == nil;
}

- (BOOL)cancelled
{
    return ([self.error.domain isEqualToString:NSURLErrorDomain] &&
            self.error.code == NSURLErrorCancelled);
}

@end
