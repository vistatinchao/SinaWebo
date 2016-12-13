//
//  ZCEmotionTextView.m
//  SinaWebo
//
//  Created by mac on 2016/12/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionTextView.h"
#import "ZCEmotion.h"
#import "ZCEmotionAttachment.h"
@implementation ZCEmotionTextView

- (void)insertEmotion:(ZCEmotion *)emotion
{
    if (emotion.code) { //emoji 字符
        [self insertText:emotion.code.emoji];
    }else{ // 表情图片
        // 加载图片
        ZCEmotionAttachment *attch = [[ZCEmotionAttachment alloc] init];
        attch.emotion = emotion;
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);

        // 根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];

        // 插入属性文字到光标位置
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];

//        // 设置字体
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
//        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    }

}

@end
