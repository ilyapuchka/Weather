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
    NSString *title;
    NSString *message;
    if (status == INTULocationStatusServicesDenied) {
        title = NSLocalizedStringFromTable(@"App Permission Denied", @"Errors", @"Location Denied Alert Title");
        message = NSLocalizedStringFromTable(@"To re-enable, please go to Settings and turn on Location Service for this app.", @"Errors", @"Location Denied Alert Message");
    }
    else {
        title = NSLocalizedStringFromTable(@"Location Services Unavailable", @"Errors", @"Location Denied Alert Title");
        message = NSLocalizedStringFromTable(@"The location services seems to be disabled from the settings.", @"Errors", @"Location Denied Alert Message");
    }
    return [self showError:YES force:force withTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
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
