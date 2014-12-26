//
//  COOLForecastViewController.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLLocationsSelection.h"
#import "COOLDataSource.h"
#import "COOLLoadableContentViewController.h"

@protocol COOLForecastDataSource;
@protocol COOLLocationsDataSource;
@protocol COOLUserLocationsRepository;
@protocol COOLUserSettingsRepository;

@class Location;
@class Forecast;

@interface COOLForecastViewController : COOLLoadableContentViewController <COOLLocationsSelectionOutput, COOLDataSourceDelegate>

@property (nonatomic, strong) id<COOLForecastDataSource> forecastDataSource;
@property (nonatomic, strong) id<COOLLocationsDataSource> locationsDataSource;
@property (nonatomic, strong) id<COOLUserLocationsRepository> userLocationsRepository;
@property (nonatomic, strong) id<COOLUserSettingsRepository> userSettingsRepository;

@property (nonatomic, copy) Location *selectedLocation;
@property (nonatomic, copy) Location *userLocation;

//starts loading new data or updating user location
- (void)reloadData NS_REQUIRES_SUPER;

//will be called after recieving Location corrseponding to current user location
- (void)loadForecastForLocation:(Location *)location;

//will be called at the end of reload data passing TRUE if during reload data user locaton update was called
- (void)willUpdateUserLocation:(BOOL)willUpdateUserLocation;

//COOLLocationsSelectionOutput
- (void)didSelectLocation:(Location *)location;

//will be called on COOLUserSettingsChangedNotification notification
- (void)defaultsChanged:(NSNotification *)note;

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error NS_REQUIRES_SUPER;

@end
