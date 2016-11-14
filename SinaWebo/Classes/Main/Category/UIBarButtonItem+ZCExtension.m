//
//  UIBarButtonItem+ZCExtension.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIBarButtonItem+ZCExtension.h"

@implementation UIBarButtonItem (ZCExtension)
+(instancetype)barButtonItemWithImage:(NSString *)image HighLightenImage:(NSString *)highLightImage Action:(SEL)action Target:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    UIBarButtonItem *barButtonitem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonitem;
}
@end
