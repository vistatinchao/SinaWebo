//
//  UIBarButtonItem+ZCExtension.h
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZCExtension)
+(instancetype)barButtonItemWithImage:(NSString *)image HighLightenImage:(NSString *)highLightImage Action:(SEL)action Target:(id)target;
@end
