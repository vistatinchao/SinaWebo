//
//  ZCEmotionTextView.h
//  SinaWebo
//
//  Created by mac on 2016/12/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCTextView.h"
@class ZCEmotion;
@interface ZCEmotionTextView : ZCTextView

- (void)insertEmotion:(ZCEmotion *)emotion;

/**
 把图片转化为字符串
 */
- (NSString *)fullText;

@end
