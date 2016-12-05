//
//  ZCEmotionToolbar.h
//  SinaWebo
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZCEmotionToolbarButtonRecent,// 最近
    ZCEmotionToolbarButtonDefault,// 默认
    ZCEmotionToolbarButtonEmoji,// emoji
    ZCEmotionToolbarButtonLxh // 浪小花
} ZCEmotionToolbarButtonType;
@interface ZCEmotionToolbar : UIView

@end
