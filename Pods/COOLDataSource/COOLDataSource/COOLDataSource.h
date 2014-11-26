//
//  COOLDataSource.h
//  CoolEvents
//
//  Created by Ilya Puchka on 08.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLLoadingStateMachine.h"
#import "COOLLoadingProcess.h"
#import "COOLDataSourceDelegate.h"

typedef void (^COOLLoadingBlock)(COOLLoadingProcess *loadingProcess);

/**
 *  
    Base data source implementation.
 
    <b>Subclassing notes.</b>
 
    If your subclass overrides <a>COOLStateMachineDelegate</a> state changing methods (e.g. didEnter..., willEnter... etc.) call super in you implementation. It will call <a>COOLDataSourceDelegate</a> corresponding methods (e.g. dataSourceDidEnter...:, dataSourceWillEnter...:).
 
    If you don't call super then call COOLDataSourceDelegate corresponding methods by yourself.
 
    @see <a>COOLDataSourceDelegate</a>, <a>COOLStateMachineDelegate</a>
 */

@interface COOLDataSource : NSObject <COOLStateMachineDelegate>
{
    COOLLoadingStateMachine *_stateMachine;
    COOLLoadingProcess *_loadingProcess;
}

/**
 *
 Delegate can implement any state changing methods (e.g dataSourceWillEnter...:, dataSourceStateWillChangeFrom...To...:).
 
 See <a>COOLLoadingStateMachine</a> for list of possible states and <a>COOLStateMachine</a> for methods naming conventions.
 
 @see <a>COOLLoadingStateMachine</a>, <a>COOLStateMachine</a>
 
 */
@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

/**
 *  Optional block called if loading completed with success.
 */
@property (nonatomic, copy) COOLLoadingProcessDoneBlock onContentBlock;

/**
 *  Optional block called if loading completed with no content.
 */
@property (nonatomic, copy) COOLLoadingProcessDoneBlock onNoContentBlock;

/**
 *  Optional block called if loading completed with error.
 */
@property (nonatomic, copy) COOLLoadingProcessDoneBlock onErrorBlock;

/**
 *  The current state of the content loading operation
 *
 *  @return
 */
- (NSString *)loadingState;

- (COOLLoadingProcess *)loadingProcess;

- (BOOL)completed;

/**
 *  Always returns YES. Should be overriden by subclasses.
 *
 *  @return
 */
- (BOOL)didCompleteLoadingWithSuccess;

/**
 *  Always returns NO. Should be overriden by subclasses.
 *
 *  @return
 */
- (BOOL)didCompleteLoadingWithNoContent;

/**
 *  Any error that occurred during content loading. Valid only when loadingState is COOLLoadingStateError.
 */
@property (nonatomic, strong) NSError *loadingError;

/**
 *  Will call loadContent
 */
- (void)setNeedsLoadContent;

/**
 *  Base implementation do nothing
 */
- (void)loadContent;

/**
 *  Reset the content and loading state.
 */
- (void)resetContent NS_REQUIRES_SUPER;

/**
 *  Prepares data source for loading.
 *
 *  @param block Block that actually do loading.
 *  @see <a>COOLLoadingProcess</a>
 */
- (void)loadContentWithBlock:(COOLLoadingBlock)block;

@end


