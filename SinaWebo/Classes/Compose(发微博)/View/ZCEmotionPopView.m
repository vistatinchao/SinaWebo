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
}

+ (instancetype)popView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)setEmotion:(ZCEmotion *)emotion
{
    _emotion = emotion;
    self.emotionPopBtn.emotion = emotion;
}


@end
