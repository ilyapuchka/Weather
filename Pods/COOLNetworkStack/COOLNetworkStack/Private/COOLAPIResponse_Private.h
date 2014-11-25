//
//  COOLAPIResponse_Private.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 06.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAPIResponse.h"

@interface COOLAPIResponse ()

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *task;
@property (nonatomic, copy, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, copy, readwrite) NSError *error;

@property (nonatomic, copy, readwrite) id mappedResponseObject;

@end
