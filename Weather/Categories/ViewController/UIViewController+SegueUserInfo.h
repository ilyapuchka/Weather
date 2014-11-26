//
//  UIViewController+SegueUserInfo.h
//  Restaurants
//
//  Created by Ilya Puchka on 09.10.14.
//  Copyright (c) 2014 Afisha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(SegueUserInfo)

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender userInfo:(NSDictionary *)userInfo;
- (NSDictionary *)segueUserInfo:(UIStoryboardSegue *)segue;

@end
