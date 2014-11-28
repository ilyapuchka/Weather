//
//  UIAlertView+Extensions.m
//  Weather
//
//  Created by Ilya Puchka on 28.11.14.
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "UIAlertView+Extensions.h"
#import <CoreLocation/CoreLocation.h>
#import "INTULocationRequestDefines.h"

@implementation UIAlertView (Extensions)

static NSMutableArray *showAlertsHashes;

+ (instancetype)showLocationErrorWithStatus:(NSInteger)status force:(BOOL)force
{
    if (status == INTULocationStatusServicesDenied) {
        return [self showError:YES force:force withTitle:@"App Permission Denied" message:@"To re-enable, please go to Settings and turn on Location Service for this app." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    }
    else {
        return [self showError:YES force:force withTitle:@"Location Services Unavailable" message:@"The location services seems to be disabled from the settings." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    }
}

+ (void)clearShowAlertsCache
{
    showAlertsHashes = [@[] mutableCopy];
}

+ (instancetype)showError:(BOOL)once force:(BOOL)force withTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (!showAlertsHashes) {
        showAlertsHashes = [@[] mutableCopy];
    }
    if (!force) {
        NSInteger hash = [title hash] ^ [message hash];
        if ([showAlertsHashes containsObject:@(hash)]) {
            return nil;
        }
        [showAlertsHashes addObject:@(hash)];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    [alertView show];
    return alertView;
}

@end
