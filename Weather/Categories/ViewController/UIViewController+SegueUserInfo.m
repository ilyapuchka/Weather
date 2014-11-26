//
//  UIViewController+SegueUserInfo.m
//  Restaurants
//
//  Created by Ilya Puchka on 09.10.14.
//  Copyright (c) 2014 Afisha. All rights reserved.
//

#import "UIViewController+SegueUserInfo.h"
#import <objc/runtime.h>

@implementation UIViewController (SegueUserInfo)

- (NSDictionary *)seguesUserInfoDictionary
{
    return objc_getAssociatedObject(self, @selector(seguesUserInfoDictionary));
}

- (void)setSeguesUserInfoDictionary:(NSDictionary *)dict
{
    objc_setAssociatedObject(self, @selector(seguesUserInfoDictionary), dict, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setUserInfo:(NSDictionary *)userInfo forSegueWithIdentifier:(NSString *)identifier
{
    NSMutableDictionary *dict = [[self seguesUserInfoDictionary]?:@{} mutableCopy];
    if (userInfo) {
        dict[identifier] = userInfo;
    }
    else {
        [dict removeObjectForKey:identifier];
    }
    [self setSeguesUserInfoDictionary:dict];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender userInfo:(NSDictionary *)userInfo
{
    [self setUserInfo:userInfo forSegueWithIdentifier:identifier];
    [self performSegueWithIdentifier:identifier sender:sender];
}

- (NSDictionary *)segueUserInfo:(UIStoryboardSegue *)segue
{
    NSDictionary *dict = [self seguesUserInfoDictionary];
    return dict[segue.identifier];
}

@end

