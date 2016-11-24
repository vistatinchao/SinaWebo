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

/**	string	微博创建时间*/
@property (nonatomic,copy) NSString *created_at;

/**	string	微博信息来源*/
@property (nonatomic,copy) NSString *source;

/**	微博配图地址。多图时返回多图链接。无配图返回“[]”*/
@property (nonatomic,strong) NSArray *pic_urls;\

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;
@end
