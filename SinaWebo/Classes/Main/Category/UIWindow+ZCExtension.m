//
//  UIWindow+ZCExtension.m
//  SinaWebo
//
//  Created by mac on 2016/11/18.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIWindow+ZCExtension.h"
#import "ZCTabBarViewController.h"
#import "ZCNewFeatureViewController.h"
@implementation UIWindow (ZCExtension)

- (void)chooseRootViewController
{
    NSString *readVersion = [ZCUtility readFileForKey:ZCCFBundleShortVersionStringKey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if ([readVersion isEqualToString:currentVersion]) {
        ZCTabBarViewController *tbc = [[ZCTabBarViewController alloc]init];
        self.rootViewController  = tbc;
    }else{
        self.rootViewController  = [[ZCNewFeatureViewController alloc]init];
        [ZCUtility writeToFile:currentVersion forKey:ZCCFBundleShortVersionStringKey];
    }
}

@end
