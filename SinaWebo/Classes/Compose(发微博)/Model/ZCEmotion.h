//
//  ZCEmotion.h
//  SinaWebo
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic,copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic,copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic,copy) NSString *code;


@end
