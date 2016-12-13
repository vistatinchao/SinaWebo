//
//  ZCEmotionAttachment.m
//  SinaWebo
//
//  Created by mac on 2016/12/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionAttachment.h"
#import "ZCEmotion.h"
@implementation ZCEmotionAttachment

- (void)setEmotion:(ZCEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}

@end
