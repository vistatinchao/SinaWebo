//
//  ZCEmotionsPageView.m
//  SinaWebo
//
//  Created by mac on 2016/12/8.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//  每一页的表情view

#import "ZCEmotionsPageView.h"
#import "ZCEmotion.h"
#import "ZCEmotionButton.h"
#import "ZCEmotionPopView.h"

@interface ZCEmotionsPageView()
@property (nonatomic,strong)ZCEmotionPopView *popView;
@property (nonatomic,weak)UIButton *deleteBtn;
@end
@implementation ZCEmotionsPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addDeleteBtn];
    }
    return self;
}
#warning todo  还有默认图片进来不出来 以及启动页面问题
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (NSInteger i=0; i<count; i++) {
        ZCEmotionButton *btn = [ZCEmotionButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        ZCEmotion *emotion = emotions[i];
        btn.emotion = emotion;
        [btn addTarget:self action:@selector(showPopView:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addDeleteBtn
{
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:delBtn];
    [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [delBtn addTarget:self action:@selector(clickDelBtn) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = delBtn;
}
#warning  todo
- (void)clickDelBtn
{
    ZCLogFunc;
}

- (void)showPopView:(ZCEmotionButton *)btn
{
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject; //显示到最后一个window
    [window addSubview:self.popView];
    self.popView.emotion = btn.emotion;

    // 相对应窗口的frame
    CGRect btnNewFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnNewFrame) - self.popView.height;
    self.popView.x = btnNewFrame.origin.x-ZCEmotionListViewInsetPadding;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

    // 发通知textView显示表情
    NSDictionary *emotionDict = [NSDictionary dictionaryWithObject:btn.emotion forKey:ZCKeyNotificationDidShowEmotion];
    [ZCNotiCenter postNotificationName:ZCNotificationDidShowEmotion object:nil userInfo:emotionDict];
}

- (ZCEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [ZCEmotionPopView popView];
    }
    return _popView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
     NSUInteger count = self.emotions.count;
    CGFloat btnInset = ZCEmotionListViewInsetPadding;
    NSUInteger maxCow = ZCEmotionListViewPageCow;
    NSUInteger maxRow = ZCEmotionListViewPageRow;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = (self.width-2*btnInset)/maxCow;
    CGFloat btnH = (self.height-btnInset)/maxRow;
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn = self.subviews[i+1];
        CGFloat row = i/maxCow;
        CGFloat cow = i%maxCow;
        btnX = btnInset+cow*btnW;
        btnY = btnInset+row*btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }

    // 设置deleteBtnframe
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width-btnInset-btnW;
    self.deleteBtn.y = self.height-btnH;
}

@end
