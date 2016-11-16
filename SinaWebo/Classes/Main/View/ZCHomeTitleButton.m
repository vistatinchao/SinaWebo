//
//  ZCHomeTitleButton.m
//  SinaWebo
//
//  Created by zouchao on 2016/11/15.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCHomeTitleButton.h"

@implementation ZCHomeTitleButton

+ (instancetype)titleButton
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAttribute];
    }
    return self;
}

- (void)setAttribute
{
    [self setTitle:@"首页" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
}

@end