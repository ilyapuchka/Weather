//
//  COOLAppDelegate.m
//  Weather
//
//  Created by Ilya Puchka on 11/26/14
//  Copyright (c) 2014 Ilya Puchka. All rights reserved.
//

#import "COOLAppDelegate.h"
#import "UIColor+Weather.h"
#import "UIFont+Weather.h"

@interface COOLAppDelegate()

@end

@implementation COOLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont semiboldFontOfSize:18], NSForegroundColorAttributeName: [UIColor darkBlackTextColor]}];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont semiboldFontOfSize:10], NSForegroundColorAttributeName: [UIColor darkBlackTextColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont semiboldFontOfSize:10], NSForegroundColorAttributeName: [UIColor blueTextColor]} forState:UIControlStateSelected];
    
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"Input"] forState:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"Search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"Close"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [[UISearchBar appearance] setSearchTextPositionAdjustment:UIOffsetMake(5, 0)];

    return YES;
}

@end
