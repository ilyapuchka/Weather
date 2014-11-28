//
//  UIAlertView+Extensions.h
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Extensions)

+ (instancetype)showLocationErrorWithStatus:(NSInteger)status  force:(BOOL)force;
+ (void)clearShowAlertsCache;
+ (instancetype)showError:(BOOL)once force:(BOOL)force withTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
