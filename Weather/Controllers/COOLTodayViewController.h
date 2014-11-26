//
//  COOLTodayViewController.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COOLForecastDataSource;
@protocol COOLLocationsDataSource;

@interface COOLTodayViewController : UIViewController

@property (nonatomic, strong) id<COOLForecastDataSource> forecastDataSource;
@property (nonatomic, strong) id<COOLLocationsDataSource> locationsDataSource;

@end
