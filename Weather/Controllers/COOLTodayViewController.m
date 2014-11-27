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

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

#import "COOLTodayView.h"
#import "COOLTableViewModel.h"

#import "COOLNotifications.h"

@interface COOLTodayViewController() <COOLDataSourceDelegate>

@property (nonatomic, copy) Location *location;
@property (nonatomic, copy) Location *userLocation;

@property (nonatomic, retain) COOLTodayView *view;

@end

@implementation COOLTodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Today" image:[[UIImage imageNamed:@"Today-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Today-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectLocation:) name:COOLLocationSelectedNotification object:nil];
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
    
    [self reloadData];
}

- (void)reloadData
{
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
            [self loadForecastForLocation:self.userLocation];
        }
    }
    else if (dataSource == self.forecastDataSource) {
        Forecast *forecast = [self.forecastDataSource todayForecast];
        if (!error && forecast) {
            self.view.contentView.hidden = NO;
            COOLTableViewModel *model;
            if (self.location) {
                model = [[COOLTableViewModel alloc] initWithForecast:forecast location:self.location isCurrentLocation:([self.location isEqual: self.userLocation])];
            }
            else if (self.userLocation) {
                model = [[COOLTableViewModel alloc] initWithForecast:forecast location:self.userLocation isCurrentLocation:YES];
            }
            else {
                return;
            }
            [(COOLTodayView *)self.view setWithViewModel:model];
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
    }
}

- (void)didSelectLocation:(NSNotification *)note
{
    self.location = note.userInfo[COOLLocationSelectedNotificationLocationKey];
    [self reloadData];
}

- (IBAction)shareTapped:(id)sender
{
    
}

@end
