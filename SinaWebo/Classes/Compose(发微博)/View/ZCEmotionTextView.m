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
    }

}

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSAttributedString *text = [self.attributedText attributedSubstringFromRange:range];
        if (attrs[@"NSAttachment"]) { //是带有属性的字符串
            ZCEmotionAttachment *attach = attrs[@"NSAttachment"];
            [fullText appendString:attach.emotion.chs];
        }else{
            [fullText appendString:text.string];
        }
    }];
    return fullText;
}

@end
