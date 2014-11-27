//
//  COOLForecastTableViewCellPresentation.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COOLForecastTableViewCellPresentation <NSObject>

- (UIImageView *)weatherIconImageView;
- (UILabel *)titleLabel;
- (UILabel *)subtitleLabel;
- (UILabel *)temperatureLabel;

@end
