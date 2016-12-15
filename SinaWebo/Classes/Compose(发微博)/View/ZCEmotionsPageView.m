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
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    }
    return self;
}

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

- (void)clickDelBtn
{
    [ZCNotiCenter postNotificationName:ZCNotificationDidClickDeleteEmotionBtn object:nil userInfo:nil];
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    // 获取手势长按的坐标
    CGPoint pressPoint = [gesture locationInView:gesture.view];
    ZCEmotionButton *btn = [self emotionBtnWithLocation:pressPoint];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        case  UIGestureRecognizerStateChanged:{
            [self.popView showPopViewInBtn:btn];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case  UIGestureRecognizerStateEnded:{  // 发通知
            [self.popView removeFromSuperview];
            if (btn) {
                [self postTextViewDidSelectemotionBtn:btn];
            }
            break;
        }

        default:
            break;
    }
}

- (void)showPopView:(ZCEmotionButton *)btn
{
    [self.popView showPopViewInBtn:btn];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

    // 发通知textView显示表情
    [self postTextViewDidSelectemotionBtn:btn];
}

/**
 根据长按的坐标点找到对应的表情按钮
 */
- (ZCEmotionButton *)emotionBtnWithLocation:(CGPoint)point
{
     NSUInteger count = self.emotions.count;
    for (NSInteger i=0; i<count; i++) {
        ZCEmotionButton *btn = self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame, point)) {  // 手势长按的坐标在btn范围内
            [self.popView showPopViewInBtn:btn];
            return btn;
        }
    }
    return nil;
}
#pragma mark 选中的表情发通知给textview
- (void)postTextViewDidSelectemotionBtn:(ZCEmotionButton *)btn
{
    // 保存表情到最近表情
    [ZCUtility saveRecentEmotion:btn.emotion];
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
    self.deleteBtn.width = btnW+btnInset;
    self.deleteBtn.height = btnH+btnInset;
    self.deleteBtn.x = self.width-btnInset-self.deleteBtn.width;
    self.deleteBtn.y = self.height-btnH;
}

@end
