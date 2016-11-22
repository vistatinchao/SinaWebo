//
//  ZCStatus.h
//  SinaWebo
//
//  Created by mac on 2016/11/22.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUser;

@interface ZCStatus : NSObject
/**	string	字符串型的微博ID*/
@property (nonatomic,copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic,copy) NSString *text;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic,strong)ZCUser *user;

@end
