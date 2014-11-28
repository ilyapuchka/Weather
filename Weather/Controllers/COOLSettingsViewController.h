//
//  COOLSettingsViewController.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COOLUserSettingsRepository;

@interface COOLSettingsViewController : UITableViewController

@property (nonatomic, strong) id<COOLUserSettingsRepository> userSettingsRepository;

@end
