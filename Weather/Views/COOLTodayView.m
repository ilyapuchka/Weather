//
//  COOLTodayView.m
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLTodayView.h"

@interface COOLTodayView()

@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chanceOfRainIcon;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;

@end

@implementation COOLTodayView

- (void)awakeFromNib
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if (self.contentView.contentSize.height < self.contentView.bounds.size.height) {
        CGFloat top = (self.contentView.bounds.size.height - self.contentView.contentSize.height) / 2;
        self.contentView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    }
}

- (void)setWithViewModel:(COOLTableViewModel *)viewModel
{
    self.weatherIconImageView.image = viewModel.weatherIconImage;
    self.locationLabel.attributedText = viewModel.locationString;
    self.weatherDescLabel.attributedText = viewModel.weatherDescString;
    self.chanceOfRainLabel.text = viewModel.chanceOfRainString;
    self.precipLabel.text = viewModel.precipString;
    self.pressureLabel.text = viewModel.pressureString;
    self.windSpeedLabel.text = viewModel.windSpeedString;
    self.windDirectionLabel.text = viewModel.windDirectionString;
}

@end
