//
//  COOLComposedDataSource.h
//  CoolEvents
//
//  Created by Ilya Puchka on 08.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLDataSource.h"
#import "COOLComposition.h"

/**
 *  Data sources composition using COOLComposition of COOLDataSource instances.
 
    Base implementation of -missingTransitionFromState:toState: method returns COOLLoadingStateRefreshingContent if previous loading completed with success or COOLLoadingStateLoadingContent otherwise.
 
    Base implementation of -didCompleteLoadingWithSuccess returns YES if at least one data source completed loading with success.
    
    Base implementation of -didCompleteLoadingWithNoContent returns YES if all data sources completed loading with no content.
 */
@interface COOLComposedDataSource : COOLDataSource <COOLDataSourceDelegate> {
    id<COOLComposition> _dataSources;
    NSArray *_objects;
    NSDictionary *_dataSourcesByStates;
}

//Data sources should be instances of COOLDataSource or it's subclass.
- (instancetype)initWithDataSources:(NSArray *)dataSources NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) COOLComposition *dataSources;

- (COOLComposition *)composition;

//COOLDataSourceDelegate method default implementation. Subclasses should call super.
- (void)dataSourceWillLoadContent:(COOLDataSource *)dataSource NS_REQUIRES_SUPER;

//COOLDataSourceDelegate method default implementation. Subclasses should call super.
- (void)dataSource:(COOLDataSource *)dataSource didLoadContentWithError:(NSError *)error NS_REQUIRES_SUPER;

//for subclasses
- (void)completeLoadingIfNeeded:(COOLLoadingProcess *)loadingProcess;

@end
