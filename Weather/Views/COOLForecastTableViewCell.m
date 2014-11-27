//
//  COOLForecastTableViewCell.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLForecastTableViewCell.h"
#import "COOLForecastTableViewCellModel.h"

@interface COOLForecastTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *weatherIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;

@end

@implementation COOLForecastTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setWithViewModel:(COOLForecastTableViewCellModel *)viewModel
{
    self.weatherIconImageView.image = viewModel.weatherIconImage;
    self.titleLabel.attributedText = viewModel.titleString;
    self.subtitleLabel.text = viewModel.subtitleString;
    self.temperatureLabel.text = viewModel.temperatureString;
}

@end
