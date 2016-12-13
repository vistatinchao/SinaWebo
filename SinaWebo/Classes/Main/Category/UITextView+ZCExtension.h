//
//  UITextView+ZCExtension.h
//  SinaWebo
//
//  Created by mac on 2016/12/13.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZCExtension)
- (void)insertAttributeText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
