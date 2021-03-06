//
//  COOLAPIClient.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLAPIClientBlocks.h"
#import "COOLAPIRequestSerialization.h"
#import "COOLAPIResponseSerialization.h"

@protocol COOLAPIClient <NSObject>

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
              requestSerializer:(id<COOLAPIRequestSerialization>)requestSerializer
             responseSerializer:(id<COOLAPIResponseSerialization>)responseSerializer;

- (NSURLSessionDataTask *)dataTaskWithAPIRequest:(COOLAPIRequest *)request
                                         success:(COOLAPIClientSuccessBlock)success
                                         failure:(COOLAPIClientFailureBlock)failure;

- (NSURLSessionDataTask *)dataTaskWithAPIRequest:(COOLAPIRequest *)request
                               completionHandler:(COOLAPIClientCompletionBlock)completionHandler;

- (id<COOLAPIRequestSerialization>)requestSerializer;
- (id<COOLAPIResponseSerialization>)responseSerializer;

@end
