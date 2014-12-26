//
//  COOLForecastViewController.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastViewController.h"
#import "COOLForecastDataSource.h"
#import "COOLLocationsDataSource.h"
#import "COOLUserLocationsRepository.h"

#import "Location.h"
#import "INTULocationRequestDefines.h"

#import "COOLStoryboardIdentifiers.h"
#import "UIViewController+SegueUserInfo.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

#import "COOLTodayContentView.h"
#import "COOLTodayViewModel.h"

#import "UIAlertView+Extensions.h"
#import "COOLNotifications.h"

@interface COOLForecastViewController()

@property (nonatomic, retain) COOLTodayContentView *view;
@property (nonatomic, strong) COOLTodayViewModel *viewModel;

@end

@implementation COOLForecastViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:COOLUserSettingsChangedNotification object:nil];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        Location *location = [[self.locationsDataSource locations] firstObject];
        if (!error && location) {
            if (![self.userLocation isEqual:location]) {
                self.userLocation = location;
            }
            if (!self.selectedLocation) {
                [self loadForecastForLocation:self.userLocation];
            }
        }
    }
}

- (void)didSelectLocation:(Location *)location
{
    self.selectedLocation = location;
}

- (void)reloadData
{
    if (self.selectedLocation) {
        [self loadForecastForLocation:self.selectedLocation];
    }
    
    BOOL updatingLocation = [self.userLocationsRepository updateCurrentUserLocation:NO withCompletion:^(INTULocationStatus status, CLLocation *location, BOOL changed) {
        if (status != INTULocationStatusSuccess) {
            [self failedToGetUserLocationWithStatus:status];
        }
        else if (changed || !self.userLocation) {
            [self loadLocationsForLocation:location];
        }
    }];
    
    [self willUpdateUserLocation:updatingLocation];
}

- (void)willUpdateUserLocation:(BOOL)willUpdateUserLocation
{
}

- (void)failedToGetUserLocationWithStatus:(INTULocationStatus)status
{
    [UIAlertView showLocationErrorWithStatus:status force:NO];
    self.selectedLocation = [[self.userLocationsRepository userLocations] firstObject];
    [self.userLocationsRepository setSelectedLocation:self.selectedLocation];
    [self loadForecastForLocation:self.selectedLocation];
}

- (void)loadLocationsForLocation:(CLLocation *)location
{
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.locationsDataSource loadLocationsWithLatitude:location.coordinate.latitude
                                                    longituted:location.coordinate.longitude];
}

- (void)didLoadLocations:(id<COOLLocationsDataSource>)locationsDataSource withError:(NSError *)error
{
}

- (void)loadForecastForLocation:(Location *)location
{
}

- (void)defaultsChanged:(NSNotification *)note
{
    
}

@end
