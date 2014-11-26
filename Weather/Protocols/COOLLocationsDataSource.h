//
//  COOLLocationsDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLDataSourceDelegate.h"

@protocol COOLLocationsDataSource <NSObject>

@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

@property (nonatomic, copy) NSString *query;

- (NSURLSessionDataTask *)loadLocationsWithQuery:(NSString *)query;

- (NSArray *)locations;

@end
