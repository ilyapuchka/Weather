//
//  COOLLocationsViewController.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLLocationsViewControllerInput.h"

@class Location;

@protocol COOLLocationsDataSource;
@protocol COOLForecastComposedDataSource;
@protocol COOLUserLocationsRepository;

@protocol COOLLocationsViewControllerOutput <NSObject>

- (void)locationsViewControllerSelectedLocation:(Location *)location;

@end

@interface COOLLocationsViewController : UIViewController <COOLLocationsViewControllerInput>

@property (nonatomic, weak) id<COOLLocationsViewControllerOutput> output;
@property (nonatomic, strong) id<COOLLocationsDataSource> locationsDataSource;
@property (nonatomic, strong) id<COOLForecastComposedDataSource> forecastDataSource;
@property (nonatomic, strong) id<COOLUserLocationsRepository> userLocationsRepository;

@end
