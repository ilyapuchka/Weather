//
//  COOLTodayViewPresentation.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COOLTodayViewPresentation <NSObject>

//- (UIScrollView *)contentView;
- (UIImageView *)weatherIconImageView;
- (UILabel *)locationLabel;
- (UILabel *)weatherDescLabel;
- (UIImageView *)chanceOfRainIcon;
- (UILabel *)chanceOfRainLabel;
- (UILabel *)precipLabel;
- (UILabel *)pressureLabel;
- (UILabel *)windSpeedLabel;
- (UILabel *)windDirectionLabel;

@end
