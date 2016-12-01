//
//  ZCComposeToolbar.h
//  SinaWebo
//
//  Created by mac on 2016/12/1.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCComposeToolbar;
typedef enum : NSUInteger {
    ZCComposeToolbarBtnCamera, // 相机
    ZCComposeToolbarBtnPicture,// 图片
    ZCComposeToolbarBtnMention,// @
    ZCComposeToolbarBtnTrend,//#
    ZCComposeToolbarBtnEmotion// 表情
} ZCComposeToolbarBtnType;

@protocol ZCComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(ZCComposeToolbar *)toolbar didClickBtnType:(ZCComposeToolbarBtnType)btnType;

@end


@interface ZCComposeToolbar : UIView
@property (nonatomic,weak)id<ZCComposeToolbarDelegate>delegate;
+ (instancetype)toolbar;

@end
