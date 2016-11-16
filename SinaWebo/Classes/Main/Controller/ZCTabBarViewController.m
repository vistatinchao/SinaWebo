//
//  ZCTabBarViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTabBarViewController.h"
#import "ZCHomeViewController.h"
#import "ZCMessageViewController.h"
#import "ZCDiscoverViewController.h"
#import "ZCProfileViewController.h"
#import "ZCNavigationController.h"
#import "ZCTabBar.h"
@interface ZCTabBarViewController ()

@end

@implementation ZCTabBarViewController


+ (void)initialize
{
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    attributeDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [[UITabBarItem appearance] setTitleTextAttributes:attributeDict forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController];
    [self setTabBar];
}

- (void)addChildViewController
{
    ZCHomeViewController *home = [[ZCHomeViewController alloc]init];
    ZCMessageViewController *message = [[ZCMessageViewController alloc]init];
    ZCDiscoverViewController *discover = [[ZCDiscoverViewController alloc]init];
    ZCProfileViewController *profile = [[ZCProfileViewController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addChildViewController:message title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self addChildViewController:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self addChildViewController:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];

}

- (void)setTabBar
{
    [self setValue:[[ZCTabBar alloc]init] forKey:@"tabBar"];
}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childController.navigationItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.title = title;
    ZCNavigationController *nvc  = [[ZCNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nvc];
}



@end
