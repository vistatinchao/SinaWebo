//
//  UIAlertView+ZCExtension.m
//  SinaWebo
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UIAlertView+ZCExtension.h"

@implementation UIAlertView (ZCExtension)
+ (void)alertWithShowMessage:(NSString *)message
{
    UIAlertView *alert = [[self alloc]initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
