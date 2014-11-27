//
//  COOLForecastTableViewCell.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOLForecastTableViewCellPresentation.h"

@interface COOLForecastTableViewCell : UITableViewCell <COOLForecastTableViewCellPresentation>

@property (nonatomic, weak) IBOutlet UIImageView *weatherIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;

@end
