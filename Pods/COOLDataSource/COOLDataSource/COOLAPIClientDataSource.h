//
//  COOLAPIClientDataSource.h
//  CoolEvents
//
//  Created by Ilya Puchka on 08.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDataSource.h"
#import "COOLAPIClientImpl.h"
#import "COOLAPIResponse.h"
#import "COOLLoadingProcess.h"

/**
 *  COOLDataSource implementation based on loading using COOLAPIClientImpl. Implements COOLAPIClientDataSource methods. Returns YES from -didCompleteLoadingWithSuccess if recieved response returns YES from -success. Returns YES from -didCompleteLoadingWithNoContent if recieved response returns YES from -noContent. Subclasses should override these methods.
 
    @see COOLAPIResponse
 */
@interface COOLAPIClientDataSource : COOLDataSource

/**
 *  Instance of COOLAPIClientImpl used for loading content.
 */
@property (nonatomic, strong) COOLAPIClientImpl *apiClient;

/**
 *  Performs basic completion of loading. Calls COOLAPIClientDataSource methods. Then based on these methods return values calls it's loadingProcess instance methods to transit to corresponding state.
 
 Subclasses must call this methed when they complete loading content.
 *
 *  @param task
 *  @param response
 */
- (void)completeLoadingWithTask:(NSURLSessionDataTask *)task response:(COOLAPIResponse *)response;

@end
