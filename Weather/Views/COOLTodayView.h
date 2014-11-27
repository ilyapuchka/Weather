//
//  COOLTodayView.h
//  Weather
//
//  Created by Ilya Puchka on 27.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

@import UIKit;
#import "COOLTableViewModel.h"

@interface COOLTodayView : UIView

@property (nonatomic, weak) IBOutlet UIScrollView *contentView;

- (void)setWithViewModel:(COOLTableViewModel *)viewModel;

@end
