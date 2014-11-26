//
//  ApplicationComponents.h
//  Weather
//
//  Created by Ilya Puchka on 26.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

@import UIKit;
#import "TyphoonAssembly.h"

@class NetworkComponents;

@interface ApplicationComponents : TyphoonAssembly

@property (nonatomic, strong) NetworkComponents *networkComponents;

- (UIViewController *)todayViewController;

@end
