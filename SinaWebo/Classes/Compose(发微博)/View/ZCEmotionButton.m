//
//  ZCEmotionButton.m
//  SinaWebo
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionButton.h"
#import "ZCEmotion.h"
@implementation ZCEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAttribute];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setAttribute];
}

- (void)setAttribute
{
     [self.titleLabel setFont:[UIFont systemFontOfSize:32]];
    self.adjustsImageWhenHighlighted = NO;
}


- (void)setEmotion:(ZCEmotion *)emotion
{
    _emotion = emotion;
     NSString *image = nil;
    if (emotion.code) { //emoji 字符
        image = emotion.code.emoji;
        [self setTitle:image forState:UIControlStateNormal];

    }else{
        image = emotion.png;
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
}

@end
