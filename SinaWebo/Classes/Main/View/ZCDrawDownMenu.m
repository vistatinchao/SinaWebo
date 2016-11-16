//
//  ZCDrawDownMenu.m
//  SinaWebo
//
//  Created by zouchao on 2016/11/15.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCDrawDownMenu.h"
@interface ZCDrawDownMenu()
@property (nonatomic,weak)UIImageView *popImageView;
@end
@implementation ZCDrawDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview];
    }
    return self;
}


- (void)addSubview
{
    // 1. 添加遮盖
    UIView *cover = [[UIView alloc]initWithFrame:ZCScreenF];
    [self addSubview:cover];
    cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    //2. 添加popimageView
    UIImageView *popImage = [[UIImageView alloc]init];
    [self addSubview:popImage];
    popImage.userInteractionEnabled = YES;
    popImage.image = [UIImage imageNamed:@"popover_background"];
    popImage.width = popImage.image.size.width;
    popImage.height = 300;
    self.popImageView = popImage;
}

+(instancetype)menu
{
    return [[self alloc]init];
}
/**
 *  显示
 */
- (void)showFromView:(UIView *)fromView
{
    [ZCLastWindow addSubview:self];
    self.frame = ZCScreenF;
    
    // 设置popimageView位置
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:nil];
    self.popImageView.centerX = CGRectGetMidX(newFrame);
    self.popImageView.y = CGRectGetMaxY(newFrame)+5;
}
- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    [self.popImageView addSubview:contentView];
    _contentView.x = 10;
    _contentView.y = 10;
    self.popImageView.height = contentView.height+20;
    self.popImageView.width = _contentView.width+20;
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    self.contentView = contentViewController.view;
}
/**
 *  销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(drawDownMenuDismiss:)]) {
        [self.delegate drawDownMenuDismiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
