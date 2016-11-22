//
//  AppDelegate.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCOAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWindow];
    return YES;
}

- (void)initWindow
{
    self.window = [[UIWindow alloc]initWithFrame:ZCScreenF];
    self.window.backgroundColor = [UIColor whiteColor];
    // 判断用户是否授权
    ZCUserAccount *user = [ZCUtility readUserAccount];
    if (user) { // 授权过
        [self.window chooseRootViewController];
    }else{
        self.window.rootViewController = [[ZCOAuthViewController alloc]init];
    }
    [self.window makeKeyAndVisible];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];

    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];

}


@end
