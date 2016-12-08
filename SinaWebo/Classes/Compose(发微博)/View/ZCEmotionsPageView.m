//
//  ZCEmotionsPageView.m
//  SinaWebo
//
//  Created by mac on 2016/12/8.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//  每一页的表情view

#import "ZCEmotionsPageView.h"
#import "ZCEmotion.h"
@implementation ZCEmotionsPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}
#warning todo 浪小花图片 还有默认图片进来不出来 以及启动页面问题
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    NSString *image = nil;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        ZCEmotion *emotion = emotions[i];
        image = emotion.png;
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     NSUInteger count = self.subviews.count;
    CGFloat btnInset = 10;
    NSUInteger maxCow = 7;
    NSUInteger maxRow = 3;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = (self.width-2*btnInset)/maxCow;
    CGFloat btnH = (self.height-btnInset)/maxRow;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat row = i/maxCow;
        CGFloat cow = i%maxCow;
        btnX = btnInset+cow*btnW;
        btnY = btnInset+row*btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

@end
