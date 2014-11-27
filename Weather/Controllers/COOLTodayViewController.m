//
//  COOLTodayViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayViewController.h"
#import "COOLForecastDataSource.h"
#import "COOLLocationsDataSource.h"
#import "COOLUserLocationsRepository.h"

#import "INTULocationManager.h"
#import "Location.h"

#import "COOLStoryboardIdentifiers.h"
#import "UIViewController+SegueUserInfo.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

#import "COOLTodayView.h"
#import "COOLTableViewModel.h"

#import "CLLocation+Extensions.h"
#import "INTULocationManager+Extensions.h"

@interface COOLTodayViewController() <COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, copy) Location *selectedLocation;
@property (nonatomic, copy) Location *userLocation;

@property (nonatomic, copy) CLLocation *lastKnownLocation;

@property (nonatomic, retain) COOLTodayView *view;

@end

@implementation COOLTodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Today" image:[[UIImage imageNamed:@"Today-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Today-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.selectedLocation = [self.userLocationsRepository selectedLocation];
    [self reloadData];
}

- (void)reloadData
{
    if (self.selectedLocation) {
        [self loadForecastForLocation:self.selectedLocation];
    }
    
    if (!self.lastKnownLocation || [[INTULocationManager sharedInstance] needsUpdateCurrentLocation]) {
        [self getUserLocation];
    }
    else if (!self.selectedLocation) {
        [self loadForecastForLocation:self.userLocation];
    }
}

- (void)getUserLocation
{
    __weak typeof(self) wself = self;
    static NSInteger locationRequestId;
    if (locationRequestId == 0) {
        if (!self.userLocation) {
            self.view.contentView.hidden = YES;
        }
        locationRequestId = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            __weak typeof(self) sself = wself;
            if (status == INTULocationStatusSuccess) {
                if (!sself.lastKnownLocation ||
                    [currentLocation differsSignificantly:sself.lastKnownLocation]) {
                    sself.lastKnownLocation = currentLocation;
                    if (!sself.selectedLocation) {
                        [sself loadLocationsForLocation:sself.lastKnownLocation];
                    }
                }
            }
            locationRequestId = 0;
        }];
    }
}

- (void)getLocationForCurrentLocation
{
    __weak typeof(self) wself = self;
    static NSInteger locationRequestId;
    if (locationRequestId == 0) {
        if (!self.userLocation) {
            self.view.contentView.hidden = YES;
        }
        locationRequestId = [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            __weak typeof(self) sself = wself;
            if (status == INTULocationStatusSuccess) {
                [sself loadLocationsForLocation:currentLocation];
            }
            locationRequestId = 0;
        }];
    }
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

- (void)loadForecastForLocation:(Location *)location
{
    if (!location) {
        return;
    }
    
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        return;
    }
    task = [self.forecastDataSource loadTodayForecastWithQuery:location];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceDidEnterLoadingState:(id)dataSource
{
    self.view.contentView.hidden = YES;
}

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
    else if (dataSource == self.forecastDataSource) {
        Forecast *forecast = [self.forecastDataSource todayForecast];
        if (!error && forecast) {
            self.view.contentView.hidden = NO;
            COOLTableViewModel *model;
            if (self.selectedLocation) {
                model = [[COOLTableViewModel alloc] initWithForecast:forecast location:self.selectedLocation isCurrentLocation:([self.selectedLocation isEqual: self.userLocation])];
            }
            else if (self.userLocation) {
                model = [[COOLTableViewModel alloc] initWithForecast:forecast location:self.userLocation isCurrentLocation:YES];
            }
            else {
                return;
            }
            [model setup:self.view];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:COOLShowLocations]) {
        id vc = [(UINavigationController *)segue.destinationViewController topViewController];
        if (self.userLocation) {
            [(id<COOLLocationsViewInput>)vc setCurrentUserLocation:self.userLocation];
        }
        [(id<COOLLocationsSelection>)vc setOutput:self];
    }
}

- (void)didSelectLocation:(Location *)location
{
    self.selectedLocation = location;
}

- (IBAction)shareTapped:(id)sender
{
    
}

@end
