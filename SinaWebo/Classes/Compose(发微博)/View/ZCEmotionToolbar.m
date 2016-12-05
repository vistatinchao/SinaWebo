//
//  ZCEmotionToolbar.m
//  SinaWebo
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionToolbar.h"
@interface ZCEmotionToolbar()
@property (nonatomic,weak)UIButton *lastBtn;
@end
@implementation ZCEmotionToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addBtn];
    }
    return self;
}


- (void)addBtn
{
    [self addBtnWithTitle:@"最近" btnType:ZCEmotionToolbarButtonRecent];
    [self addBtnWithTitle:@"默认" btnType:ZCEmotionToolbarButtonDefault];
    [self addBtnWithTitle:@"Emoji" btnType:ZCEmotionToolbarButtonEmoji];
    [self addBtnWithTitle:@"浪小花" btnType:ZCEmotionToolbarButtonLxh];
}

- (void)addBtnWithTitle:(NSString *)title btnType:(ZCEmotionToolbarButtonType)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *disableImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count==1) {
        image = @"compose_emotion_table_left_normal";
        disableImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count==4){
        image = @"compose_emotion_table_right_normal";
        disableImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    if (btn.tag==ZCEmotionToolbarButtonDefault) {
        [self btnClick:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    self.lastBtn.enabled = YES;
    btn.enabled = NO;
    self.lastBtn = btn;
}

- (void)layoutSubviews
{
    CGFloat count = self.subviews.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
