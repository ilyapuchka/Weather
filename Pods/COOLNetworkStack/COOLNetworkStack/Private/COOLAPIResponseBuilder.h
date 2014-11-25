//
//  COOLAPIResponseBuilder.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 06.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLMapper.h"
#import "COOLAPIResponse.h"

@interface COOLAPIResponseBuilder : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) id<COOLMapper> responseMapper;
@property (nonatomic, strong) id responseMapping;
@property (nonatomic, strong, readonly) id mappedResponseObject;

- (COOLAPIResponse *)build:(Class)classToBuild;

@end
