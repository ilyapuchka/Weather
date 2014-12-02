//
//  COOLAPIResponse.h
//  COOLNetworkStack
//
//  Created by Ilya Puchka on 04.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COOLAPIResponse <NSObject>

- (instancetype)initWithTask:(NSURLSessionDataTask *)task
                    response:(NSHTTPURLResponse *)response
              responseObject:(id)responseObject
                       error:(NSError *)error;

//returns YES in no error and mappedResponseObject is not nil. Subclasses should override.
- (BOOL)succes;

//returns YES if no error and mappedResponseObject is nil. Subclasses should override.
- (BOOL)noContent;

//returns YES if request was canceled (by default checks error code to be NSURLErrorCancelled)
- (BOOL)cancelled;

- (NSURLSessionDataTask *)task;
- (NSError *)error;
- (NSHTTPURLResponse *)response;
- (id)responseObject;

@end

@interface COOLAPIResponse : NSObject <COOLAPIResponse, NSCopying> {
    id _mappedResponseObject;
    id _responseObject;
}

-(id)mappedResponseObject;

@end
