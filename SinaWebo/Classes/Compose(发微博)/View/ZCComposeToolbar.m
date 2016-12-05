//
//  ZCComposeToolbar.m
//  SinaWebo
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCComposeToolbar.h"
@interface ZCComposeToolbar()
@property (nonatomic,strong)UIButton *emotionBtn;
@end
@implementation ZCComposeToolbar

+ (instancetype)toolbar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addBtn];
    }
    return self;
}

- (void)addBtn
{
    [self addBtnWithimage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:ZCComposeToolbarBtnCamera];
    [self addBtnWithimage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:ZCComposeToolbarBtnPicture];
    [self addBtnWithimage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:ZCComposeToolbarBtnMention];
    [self addBtnWithimage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:ZCComposeToolbarBtnTrend];
  self.emotionBtn = [self addBtnWithimage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:ZCComposeToolbarBtnEmotion];
}

- (UIButton *)addBtnWithimage:(NSString *)image highImage:(NSString *)highImage type:(NSUInteger)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)clickBtn:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickBtnType:)]) {
        [self.delegate composeToolbar:self didClickBtnType:btn.tag];
    }
}

- (void)setShowEmotionKeyboard:(BOOL)showEmotionKeyboard
{
    _showEmotionKeyboard = showEmotionKeyboard;
    NSString *normalImage = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if (showEmotionKeyboard) {
        normalImage = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionBtn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
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
