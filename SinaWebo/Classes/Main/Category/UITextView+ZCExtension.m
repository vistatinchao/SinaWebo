//
//  UITextView+ZCExtension.m
//  SinaWebo
//
//  Created by mac on 2016/12/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "UITextView+ZCExtension.h"

@implementation UITextView (ZCExtension)
- (void)insertAttributeText:(NSAttributedString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];

    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];

    self.attributedText = attributedText;

    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];

    // 拼接其他文字
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];

    // 调用外面传进来的代码
    if (settingBlock) {
        settingBlock(attributedText);
    }

    self.attributedText = attributedText;

    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
