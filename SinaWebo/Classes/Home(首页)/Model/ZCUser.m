//
//  ZCUser.m
//  SinaWebo
//
//  Created by mac on 2016/11/22.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCUser.h"

@implementation ZCUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype>2;
}

@end
