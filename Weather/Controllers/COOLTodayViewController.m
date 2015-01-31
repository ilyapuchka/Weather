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

#import "INTULocationRequestDefines.h"
#import "Location.h"
#import "COOLForecastShareModel.h"

#import "COOLStoryboardIdentifiers.h"

#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

#import "COOLTodayContentView.h"
#import "COOLTodayViewModel.h"

#import "UIAlertView+Extensions.h"
#import "COOLNotifications.h"

@interface COOLTodayViewController()

@property (nonatomic, retain) IBOutlet COOLTodayContentView *todayView;
@property (nonatomic, strong) COOLTodayViewModel *viewModel;

@end

@implementation COOLTodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"Today", nil);
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[[UIImage imageNamed:@"Today-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Today-selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
    
    self.selectedLocation = [self.userLocationsRepository selectedLocation];
    [self reloadData];
}

- (void)reloadData
{
    [super reloadData];
}

- (void)willUpdateUserLocation:(BOOL)willUpdateUserLocation
{
    if (willUpdateUserLocation) {
        if (!self.userLocation) {
            [self.loadableContentView beginUpdateContent];
        }
    }
    else {
        if (!self.selectedLocation && self.userLocation) {
            [self loadForecastForLocation:self.userLocation];
        }
    }
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
    task = [self.forecastDataSource loadDailyForecastWithQuery:location days:1];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceDidEnterLoadingState:(id)dataSource
{
    [self.loadableContentView beginUpdateContent];
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    [super dataSource:dataSource didLoadContentWithError:error];
    
    if (dataSource == self.forecastDataSource) {
        Forecast *forecast = [self.forecastDataSource dailyForecast];
        if (!error && forecast) {
            [self.loadableContentView endUpdateContentWithNewState:COOLLoadingStateContentLoaded];
            
            COOLTodayViewModel *model = [self viewModelForForecast:forecast
                                              withSelectedLocation:self.selectedLocation
                                                      userLocation:self.userLocation
                                                          settings:self.userSettingsRepository];
            [self setupView:self.todayView withModel:model];
            self.viewModel = model;
        }
        else if (error) {
            [self.loadableContentView endUpdateContentWithNewState:COOLLoadingStateError];
        }
        else {
            [self.loadableContentView endUpdateContentWithNewState:COOLLoadingStateNoContent];
        }
    }
}

- (COOLTodayViewModel *)viewModelForForecast:(Forecast *)forecast withSelectedLocation:(Location *)selectedLocation userLocation:(Location *)userLocation settings:(id<COOLUserSettingsRepository>)settings
{
    if (!forecast || (!selectedLocation && !userLocation)) {
        return nil;
    }
    
    COOLTodayViewModel *model;
    Location *location;
    BOOL isCurrentLocation;
    
    if (selectedLocation) {
        location = selectedLocation;
        isCurrentLocation = ([selectedLocation isEqual:userLocation]);
    }
    else if (userLocation) {
        location = userLocation;
        isCurrentLocation = YES;
    }
    
    model = [[COOLTodayViewModel alloc] initWithForecast:forecast location:location isCurrentLocation:isCurrentLocation settings:settings];
    
    return model;
}

- (void)setupView:(COOLTodayContentView *)view withModel:(COOLTodayViewModel *)model
{
    view.weatherIconImageView.image = model.weatherIconImage;
    view.locationLabel.attributedText = model.locationString;
    view.weatherDescLabel.attributedText = model.weatherDescString;
    view.chanceOfRainLabel.text = model.chanceOfRainString;
    view.chanceOfRainIcon.image = model.chanceOfRainIcon;
    view.precipLabel.text = model.precipString;
    view.pressureLabel.text = model.pressureString;
    view.windSpeedLabel.text = model.windSpeedString;
    view.windDirectionLabel.text = model.windDirectionString;
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

@synthesize selectedLocation = _selectedLocation;

- (void)setSelectedLocation:(Location *)selectedLocation
{
    if (![_selectedLocation isEqual:selectedLocation]) {
        _selectedLocation = selectedLocation;
        [self.loadableContentView beginUpdateContent];
    }
}

- (IBAction)shareTapped:(id)sender
{
    COOLForecastShareModel *model = [[COOLForecastShareModel alloc] initWithForecast:self.viewModel.forecast location:self.viewModel.location settings:self.userSettingsRepository];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[model.shareText] applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)defaultsChanged:(NSNotification *)note
{
    Forecast *forecast = [self.forecastDataSource dailyForecast];
    
    COOLTodayViewModel *model = [self viewModelForForecast:forecast
                                      withSelectedLocation:self.selectedLocation
                                              userLocation:self.userLocation
                                                  settings:self.userSettingsRepository];
    [self setupView:self.todayView withModel:model];
    self.viewModel = model;
}

@end
