//
//  ZCNavigationController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCNavigationController.h"

@interface ZCNavigationController ()

@end

@implementation ZCNavigationController

+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];

    NSMutableDictionary *textAttrDisable = [NSMutableDictionary dictionary];
    textAttrDisable[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    textAttrDisable[NSForegroundColorAttributeName] = [ZCRGBColor(153, 153, 153) colorWithAlphaComponent:0.7];
    [item setTitleTextAttributes:textAttrDisable forState:UIControlStateDisabled];


}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {

        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" HighLightenImage:@"navigationbar_back_highlighted" Action:@selector(back) Target:self];

        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" HighLightenImage:@"navigationbar_more_highlighted" Action:@selector(backRootViewCongroller) Target:self];
        viewController.hidesBottomBarWhenPushed = YES;

    }

     [super pushViewController:viewController animated:animated];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)backRootViewCongroller
{
    [self popToRootViewControllerAnimated:YES];
}

@end
