//
//  COOLJSONResponseSerializer.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 05.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLAPIResponseSerialization.h"
#import "COOLMapper.h"

@interface COOLJSONResponseSerializer : AFJSONResponseSerializer <COOLAPIResponseSerialization>

@property (nonatomic, copy, readonly) NSDictionary *responsesRegisteredForRequests;
@property (nonatomic, strong) id<COOLMapper> responseMapper;

- (instancetype)initWithResponsesRegisteredForRequests:(NSDictionary *)responsesRegisteredForRequests NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithResponsesAndRequests:(Class)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

- (void)registerAPIResponseClass:(Class)apiResponseClass
              forAPIRequestClass:(Class)apiRequestClass;

@end
