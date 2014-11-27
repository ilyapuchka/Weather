//
//  COOLForecastTableViewCell.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COOLForecastTableViewCellModel;

@interface COOLForecastTableViewCell : UITableViewCell

- (void)setWithViewModel:(COOLForecastTableViewCellModel *)viewModel;

@end
