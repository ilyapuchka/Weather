//
//  COOLLocationsViewController.m
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLLocationsViewController.h"
#import "COOLLocationsDataSource.h"
#import "COOLForecastComposedDataSource.h"
#import "COOLUserLocationsRepository.h"
#import "COOLTableViewDataSource.h"

#import "COOLLocationsTableViewDataSource.h"

#import "Location.h"
#import "Weather.h"
#import "Forecast.h"

#import "COOLStoryboardIdentifiers.h"
#import "COOLNotifications.h"

@interface COOLLocationsViewController() <UISearchBarDelegate, COOLDataSourceDelegate, COOLLocationsSelectionOutput, COOLLocationsTableViewDataSourceEditingDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *addButton;
@property (nonatomic, strong) UIBarButtonItem *doneItem;

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) Location *currentUserLocation;
@property (nonatomic, copy) Location *selectedLocation;

@property (nonatomic, weak) IBOutlet id<COOLForecastTableViewDataSource, COOLLocationsSelection, COOLLocationsTableViewDataSourceInput> locationsTableViewDataSource;
@property (nonatomic, weak) IBOutlet id<COOLTableViewDataSource, COOLLocationsSelection> searchResultsTableViewDataSource;
@property (nonatomic, weak) id<COOLTableViewDataSource, COOLLocationsSelection> currentDataSource;

@end

@implementation COOLLocationsViewController

@synthesize output = _output;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.title = NSLocalizedString(@"Locations", nil);
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:COOLUserSettingsChangedNotification object:nil];
    
    self.doneItem = self.navigationItem.rightBarButtonItem;
    self.locationsDataSource.delegate = self;
    self.forecastDataSource.delegate = self;
    
    [self.locationsTableViewDataSource setSettings:self.userSettingsRepository];
    
    UINib *nib = [UINib nibWithNibName:@"COOLForecastTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:COOLForecastTableViewCellReuseId];

    self.currentDataSource = self.locationsTableViewDataSource;
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
}

- (void)reloadData
{
    self.tableView.dataSource = self.currentDataSource;
    self.tableView.delegate = self.currentDataSource;
    
    [self.tableView reloadData];
}

- (void)setCurrentUserLocation:(Location *)location
{
    NSCParameterAssert(location);
    if (!location) {
        return;
    }
    _currentUserLocation = location;
    _locations = nil;
}

- (NSArray *)locations
{
    if (!_locations) {
        _locations = [self.userLocationsRepository userLocations];
        if (self.currentUserLocation) {
            _locations = [@[self.currentUserLocation] arrayByAddingObjectsFromArray:_locations];
        }
    }
    return _locations;
}

- (IBAction)closeTapped:(id)sender
{
    [self dismissAndNotify:NO];
}

- (void)dismissAndNotify:(BOOL)notify
{
    if (notify && self.selectedLocation) {
        if ([[self.userLocationsRepository userLocations] containsObject:self.selectedLocation]) {
            [self.userLocationsRepository setSelectedLocation:self.selectedLocation];
            [self.output didSelectLocation:self.selectedLocation];
        }
        else {
            //no location means we selected current user location, not custom location added by user
            [self.userLocationsRepository setSelectedLocation:nil];
            [self.output didSelectLocation:nil];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showLocations
{
    [self.view endEditing:YES];
    self.navigationItem.titleView = nil;
    self.addButton.hidden = NO;
    self.navigationItem.title = @"Locations";
    [self.navigationItem setRightBarButtonItem:self.doneItem animated:YES];
    [self.forecastDataSource loadDailyForecastsWithQueries:self.locations days:1];
    self.currentDataSource = self.locationsTableViewDataSource;
    [self reloadData];
}

- (void)showSearch
{
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [searchBar becomeFirstResponder];
    self.addButton.hidden = YES;
    self.currentDataSource = self.searchResultsTableViewDataSource;
    [self.currentDataSource setItems:nil];
    [self reloadData];
}

- (IBAction)addPlaceTapped:(id)sender
{
    [self showSearch];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self showLocations];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    static NSURLSessionDataTask *task;
    if (task && task.state == NSURLSessionTaskStateRunning) {
        [task cancel];
    }
    task = [self.locationsDataSource loadLocationsWithQuery:searchText];
}

#pragma mark - COOLDataSourceDelegate

- (void)dataSourceWillLoadContent:(id)dataSource
{
    
}

- (void)dataSource:(id)dataSource didLoadContentWithError:(NSError *)error
{
    NSArray *items;
    if (dataSource == self.locationsDataSource) {
        items = [self.locationsDataSource locations];
    }
    else if (dataSource == self.forecastDataSource) {
        items = [self.forecastDataSource forecasts];
        [self.locationsTableViewDataSource setCurrentUserLocation:self.currentUserLocation];
    }
    [self.currentDataSource setItems:items];
    [self reloadData];
}

#pragma mark - COOLLocationsTableViewDataSourceOutput

- (void)didSelectLocation:(Location *)location
{
    if (self.currentDataSource == self.searchResultsTableViewDataSource) {
        if (![[self.userLocationsRepository userLocations] containsObject:location]) {
            [self.userLocationsRepository addUserLocation:location];
            self.locations = nil;
        }
        [self showLocations];
    }
    else {
        self.selectedLocation = location;
        //there is a strange bug in UITableView that sometimes makes it freeze for short time before dismissing, if dismiss is called from didSelectRowAtIndexPath...
        [self dismissAndNotify:YES];
    }
}

- (void)didDeleteLocation:(Location *)location
{
    [self.userLocationsRepository removeUserLocation:location];
    _locations = nil;
}

- (void)defaultsChanged:(NSNotification *)note
{
    if (self.currentDataSource == self.locationsTableViewDataSource) {
        [self reloadData];
    }
}

@end
