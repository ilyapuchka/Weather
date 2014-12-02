//
//  COOLJSONResponseSerializer.m
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 05.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLJSONResponseSerializer.h"
#import "COOLAPIRequest.h"
#import "COOLAPIResponse.h"

@interface COOLJSONResponseSerializer()

@property (nonatomic, copy) NSDictionary *responsesRegisteredForRequests;

@end

@implementation COOLJSONResponseSerializer

- (instancetype)init
{
    return [self initWithResponsesRegisteredForRequests:@{}];
}

- (instancetype)initWithResponsesRegisteredForRequests:(NSDictionary *)responsesRegisteredForRequests
{
    self = [super init];
    if (self) {
        self.removesKeysWithNullValues = YES;
        self.responsesRegisteredForRequests = responsesRegisteredForRequests;
    }
    return self;
}

- (void)registerAPIResponseClass:(Class)apiResponseClass forAPIRequestClass:(Class)apiRequestClass
{
    NSAssert([apiRequestClass isSubclassOfClass:[COOLAPIRequest class]], @"apiRequestClass should be subclass of COOLAPIRequest");
    NSAssert([apiResponseClass isSubclassOfClass:[COOLAPIResponse class]], @"apiResponseClass should be subclass of COOLAPIResponse");
    if ([apiRequestClass isSubclassOfClass:[COOLAPIRequest class]] &&
        [apiResponseClass isSubclassOfClass:[COOLAPIResponse class]]) {
        NSMutableDictionary *mDict = [self.responsesRegisteredForRequests mutableCopy];
        mDict[NSStringFromClass(apiRequestClass)] = NSStringFromClass(apiResponseClass);
        self.responsesRegisteredForRequests = mDict;
    }
}

- (Class)APIResponseClassForAPIRequestClass:(Class)apiRequestClass
{
    return NSClassFromString(self.responsesRegisteredForRequests[NSStringFromClass(apiRequestClass)]);
}

- (id<COOLAPIResponse>)responseForRequest:(COOLAPIRequest *)request task:(NSURLSessionDataTask *)task httpResponse:(NSHTTPURLResponse *)httpResponse responseObject:(id)responseObject httpError:(NSError *)httpError error:(NSError *__autoreleasing *)error
{
    Class responseClass = [self APIResponseClassForAPIRequestClass:[request class]];
    if (responseClass == Nil) responseClass = [COOLAPIResponse class];
    
    id<COOLAPIResponse> apiResponse = [[responseClass alloc] initWithTask:task response:httpResponse responseObject:responseObject error:httpError];
    return apiResponse;
}

@end
