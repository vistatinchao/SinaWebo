//
//  ZCTabBar.m
//  SinaWebo
//
//  Created by mac on 2016/11/16.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTabBar.h"
@interface ZCTabBar()
@property (nonatomic,weak)UIButton *addBtn;
@end
@implementation ZCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addCenterBtn];
    }
    return self;
}

- (void)addCenterBtn
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:addBtn];
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(postMessage) forControlEvents:UIControlEventTouchUpInside];
    addBtn.size = addBtn.currentBackgroundImage.size;
    self.addBtn = addBtn;
}

- (void)postMessage
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [ZCLastWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setAddBtnFrame];
    [self setCustomTabBarButtonFrame];
}

- (void)setAddBtnFrame
{
    self.addBtn.center = CGPointMake(self.width*0.5, self.height*0.5);
}
- (void)setCustomTabBarButtonFrame
{
    CGFloat width = self.width/5;
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index==2) {
                index++;
            }
            subView.width = width;
            subView.x = width*index;
             index++;
        }
    }
}
@end
