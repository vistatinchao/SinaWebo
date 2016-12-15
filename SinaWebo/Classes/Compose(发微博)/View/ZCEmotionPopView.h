//
//  ZCEmotionPopView.h
//  SinaWebo
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCEmotion,ZCEmotionButton;
@interface ZCEmotionPopView : UIView

@property (nonatomic,strong)ZCEmotion *emotion;

+(instancetype)popView;

- (void)showPopViewInBtn:(ZCEmotionButton *)btn;

@end
