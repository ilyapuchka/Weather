//
//  COOLLocationsDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLDataSourceDelegate.h"

@class Location;

@protocol COOLLocationsDataSource <NSObject>

@property (nonatomic, weak) id<COOLDataSourceDelegate> delegate;

@property (nonatomic, copy) NSString *query;

- (NSURLSessionDataTask *)loadLocationsWithQuery:(NSString *)query;
- (NSURLSessionDataTask *)loadLocationsWithLatitude:(CGFloat)latitude longituted:(CGFloat)longitude;

- (NSArray *)locations;

@end
