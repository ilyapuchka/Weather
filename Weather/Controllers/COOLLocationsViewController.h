//
//  COOLLocationsViewController.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLLocationsViewInput.h"
#import "COOLLocationsSelection.h"

@class Location;

@protocol COOLLocationsDataSource;
@protocol COOLForecastComposedDataSource;
@protocol COOLUserLocationsRepository;

@interface COOLLocationsViewController : UIViewController <COOLLocationsViewInput>

@property (nonatomic, strong) id<COOLLocationsDataSource> locationsDataSource;
@property (nonatomic, strong) id<COOLForecastComposedDataSource> forecastDataSource;
@property (nonatomic, strong) id<COOLUserLocationsRepository> userLocationsRepository;

@end
