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
#import "INTULocationManager.h"
#import "Location.h"

#import "COOLStoryboardIdentifiers.h"
#import "UIViewController+SegueUserInfo.h"

#import "COOLLocationsViewControllerInput.h"

@interface COOLTodayViewController() <COOLDataSourceDelegate>

@property (nonatomic, copy) Location *location;
@property (nonatomic, copy) Location *userLocation;

@end

@implementation COOLTodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.forecastDataSource.delegate = self;
    self.locationsDataSource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.location) {
        [self getLocationForCurrentLocation];
    }
    else {
        [self loadForecastForLocation:self.location];
    }
}

- (void)getLocationForCurrentLocation
{
    __weak typeof(self) wself = self;
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10.f delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        __weak typeof(self) sself = wself;
        if (status == INTULocationStatusSuccess) {
            [sself.locationsDataSource loadLocationsWithLatitude:currentLocation.coordinate.latitude longituted:currentLocation.coordinate.longitude];
        }
    }];
}

- (void)loadForecastForLocation:(Location *)location
{
    NSString *query = [location displayName];
    [self.forecastDataSource loadTodayForecastWithQuery:query];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    if (dataSource == self.locationsDataSource) {
        self.userLocation = [[self.locationsDataSource locations] firstObject];
        if (!self.location) {
            self.location = self.userLocation;
        }
        [self loadForecastForLocation:self.location];
    }
    else if (dataSource == self.forecastDataSource) {
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:COOLShowLocations]) {
        [(id<COOLLocationsViewControllerInput>)[(UINavigationController *)segue.destinationViewController topViewController] setCurrentLocation:self.location];
    }
}

@end
