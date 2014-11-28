//
//  COOLTableViewDataSource.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

@import UIKit;

@protocol COOLUserSettingsRepository;

@protocol COOLTableViewDataSource <UITableViewDataSource, UITableViewDelegate>

- (void)setItems:(NSArray *)items;

@end

@protocol COOLForecastTableViewDataSource <COOLTableViewDataSource>

- (void)setSettings:(id<COOLUserSettingsRepository>)settings;

@end
