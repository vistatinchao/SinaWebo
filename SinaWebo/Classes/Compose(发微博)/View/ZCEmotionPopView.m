//
//  ZCEmotionPopView.m
//  SinaWebo
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionPopView.h"
#import "ZCEmotionButton.h"
#import "ZCEmotion.h"
@interface ZCEmotionPopView()
@property (weak, nonatomic) IBOutlet ZCEmotionButton *emotionPopBtn;

@end
@implementation ZCEmotionPopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.emotionPopBtn.contentMode = UIViewContentModeCenter;
}

+ (instancetype)popView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)showPopViewInBtn:(ZCEmotionButton *)btn
{
    if (btn==nil) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject; //显示到最后一个window
    [window addSubview:self];
    self.emotionPopBtn.emotion = btn.emotion;

    // 相对应窗口的frame
    CGRect btnNewFrame = [btn convertRect:btn.bounds toView:nil];
    self.y = CGRectGetMidY(btnNewFrame) - self.height;
   //self.x = btnNewFrame.origin.x-ZCEmotionListViewInsetPadding;
    self.centerX = CGRectGetMidX(btn.frame);
}


@end
