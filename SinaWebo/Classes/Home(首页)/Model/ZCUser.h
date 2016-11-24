//
//  ZCUser.h
//  SinaWebo
//
//  Created by mac on 2016/11/22.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUser : NSObject



/**
 string	字符串型的用户UID
 */
@property (nonatomic,copy) NSString *idstr;

/**
 string	友好显示名称
 */
@property (nonatomic,copy) NSString *name;


/**
 string	用户头像地址，50×50像素
 */
@property (nonatomic,copy) NSString *profile_image_url;
/** 会员类型 > 2代表是会员 */
@property (nonatomic,assign) int mbtype;
/** 会员等级 */
@property (nonatomic,assign) int mbrank;
@property (nonatomic,assign,getter=isVip)BOOL vip;

@end
