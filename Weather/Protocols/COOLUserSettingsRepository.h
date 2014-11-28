//
//  COOLUserSettingsRepository.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COOLUnits.h"

@protocol COOLUserSettingsRepository <NSObject>

- (COOLTemperatureUnit)defaultTemperatureUnit;
- (void)setDefaultTemperatureUnit:(COOLTemperatureUnit)unit;

- (COOLDistanceUnit)defaultDistanceUnit;
- (void)setDefaultDistanceUnit:(COOLDistanceUnit)unit;

@end
