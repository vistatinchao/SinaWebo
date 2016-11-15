//
//  ZCDrawDownMenu.h
//  SinaWebo
//
//  Created by zouchao on 2016/11/15.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCDrawDownMenu : UIView

@property (nonatomic,weak)UIView *contentView;// 显示的内容
@property (nonatomic,strong)UIViewController *contentViewController;//显示内容的控制器
+(instancetype)menu; 

- (void)showFromView:(UIView *)fromView;

- (void)dismiss;

@end
