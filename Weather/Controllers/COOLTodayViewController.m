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

@interface COOLTodayViewController() <COOLDataSourceDelegate, COOLLocationsSelectionOutput>

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
    }
    return self;
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
    self.view.contentView.hidden = YES;
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
        self.userLocation = [[self.locationsDataSource locations] firstObject];
        if (!self.location) {
            self.location = self.userLocation;
        }
        [self loadForecastForLocation:self.location];
    }
    else if (dataSource == self.forecastDataSource) {
        self.view.contentView.hidden = NO;
        COOLTableViewModel *model = [[COOLTableViewModel alloc] initWithForecast:[self.forecastDataSource todayForecast] location:self.location isCurrentLocation:(self.location == self.userLocation)];
        [(COOLTodayView *)self.view setWithViewModel:model];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:COOLShowLocations]) {
        id vc = [(UINavigationController *)segue.destinationViewController topViewController];
        [(id<COOLLocationsViewInput>)vc setCurrentLocation:self.location];
        [(id<COOLLocationsSelection>)vc setOutput:self];
    }
}

#pragma mark - COOLLocationsSelectionOutput

- (void)didSelectLocation:(Location *)location
{
    self.location = location;
    [self reloadData];
}

- (IBAction)shareTapped:(id)sender
{
    
}

@end
