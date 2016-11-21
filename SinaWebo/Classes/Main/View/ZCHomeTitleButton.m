//
//  ZCHomeTitleButton.m
//  SinaWebo
//
//  Created by zouchao on 2016/11/15.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCHomeTitleButton.h"

@implementation ZCHomeTitleButton



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAttribute];

    }
    return self;
}

- (void)setAttribute
{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ZCUserAccount *user = [ZCUtility readUserAccount];
    NSString *title = user.name?user.name:@"首页";
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

}

- (void)setFrame:(CGRect)frame
{
    frame.size.width += 5;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可

    // 1.计算titleLabel的frame
    self.titleLabel.x = 5;

    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];

    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];

    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

@end
