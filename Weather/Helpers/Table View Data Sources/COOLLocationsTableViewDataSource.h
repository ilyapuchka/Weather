//
//  COOLLocationsTableViewDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

@import UIKit;
#import "COOLLocationsSelection.h"
#import "COOLTableViewDataSource.h"

@class Location;

@protocol COOLLocationsTableViewDataSourceInput <NSObject>

- (void)setCurrentUserLocation:(Location *)location;

@end

@protocol COOLLocationsTableViewDataSourceEditingDelegate <NSObject>

- (void)didDeleteLocation:(Location *)location;

@end

@interface COOLLocationsTableViewDataSource : NSObject <COOLTableViewDataSource, COOLLocationsSelection, COOLLocationsTableViewDataSourceInput>

@property (nonatomic, weak) IBOutlet id<COOLLocationsSelectionOutput> output;
@property (nonatomic, copy) Location *currentUserLocation;
@property (nonatomic, weak) IBOutlet id<COOLLocationsTableViewDataSourceEditingDelegate> editingDelegate;

@end
