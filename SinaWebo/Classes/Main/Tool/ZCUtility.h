//
//  ZCUtility.h
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUserAccount,ZCEmotion;
@interface ZCUtility : NSObject

+ (void)writeToFile:(id)object forKey:(NSString *)key;

+ (id)readFileForKey:(NSString *)key;

/**
 保存用户信息
 */
+ (void)saveUserAccount:(ZCUserAccount *)user;
/**
 读取用户信息
 */
+ (ZCUserAccount *)readUserAccount;
/**
 保存表情到最近
 */
+(void)saveRecentEmotion:(ZCEmotion *)emotion;
/**
 读取最近表情
 */
+(NSArray *)readRecentEmotion;
@end
