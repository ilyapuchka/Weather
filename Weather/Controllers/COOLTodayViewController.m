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
#import "COOLForecastShareModel.h"

#import "COOLStoryboardIdentifiers.h"
#import "UIViewController+SegueUserInfo.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

#import "COOLTodayView.h"
#import "COOLTodayViewModel.h"

#import "UIAlertView+Extensions.h"
#import "COOLNotifications.h"

@interface COOLTodayViewController() <COOLDataSourceDelegate, COOLLocationsSelectionOutput>

@property (nonatomic, copy) Location *selectedLocation;
@property (nonatomic, copy) Location *userLocation;

@property (nonatomic, retain) COOLTodayView *view;
@property (nonatomic, strong) COOLTodayViewModel *viewModel;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:COOLUserSettingsChangedNotification object:nil];
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
    
    BOOL updatingLocation = [self.userLocationsRepository updateCurrentUserLocation:NO withCompletion:^(INTULocationStatus status, CLLocation *location, BOOL changed) {
        if (status != INTULocationStatusSuccess) {
            [UIAlertView showLocationErrorWithStatus:status force:NO];
            self.selectedLocation = [[self.userLocationsRepository userLocations] firstObject];
            [self.userLocationsRepository setSelectedLocation:self.selectedLocation];
            [self loadForecastForLocation:self.selectedLocation];
        }
        else if (changed || !self.userLocation) {
            [self loadLocationsForLocation:location];
        }
    }];
    
    if (updatingLocation) {
        if (!self.userLocation) {
            self.view.contentView.hidden = YES;
        }
    }
    else {
        if (!self.selectedLocation && self.userLocation) {
            [self loadForecastForLocation:self.userLocation];
        }
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
            COOLTodayViewModel *model;
            if (self.selectedLocation) {
                model = [[COOLTodayViewModel alloc] initWithForecast:forecast location:self.selectedLocation isCurrentLocation:([self.selectedLocation isEqual: self.userLocation])];
            }
            else if (self.userLocation) {
                model = [[COOLTodayViewModel alloc] initWithForecast:forecast location:self.userLocation isCurrentLocation:YES];
            }
            else {
                return;
            }
            [model setup:self.view setting:self.userSettingsRepository];
            self.viewModel = model;
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
    COOLForecastShareModel *model = [[COOLForecastShareModel alloc] initWithForecast:self.viewModel.forecast location:self.viewModel.location settings:self.userSettingsRepository];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[model.shareText] applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)defaultsChanged:(NSNotification *)note
{
    [self.viewModel setup:self.view setting:self.userSettingsRepository];
}

@end
