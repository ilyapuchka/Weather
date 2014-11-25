//
//  COOLAPIResponse.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COOLAPIResponseBuilder;

@interface COOLAPIResponse : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;
@property (nonatomic, copy, readonly) NSHTTPURLResponse *response;
@property (nonatomic, copy, readonly) NSError *error;
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, copy, readonly) id mappedResponseObject;

+ (instancetype)responseWithBlock:(void(^)(COOLAPIResponseBuilder *builder))buildBlock;

+ (id)responseMapping;

//returns YES in no error and mappedResponseObject is not nil. Subclasses should override.
- (BOOL)succes;

//returns YES if no error and mappedResponseObject is nil. Subclasses should override.
- (BOOL)noContent;

@end
