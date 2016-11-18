//
//  ZCUtility.h
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUserAccount;
@interface ZCUtility : NSObject

+ (void)writeToFile:(id)object forKey:(NSString *)key;

+ (id)readFileForKey:(NSString *)key;

+ (void)saveUserAccount:(ZCUserAccount *)user;
+ (ZCUserAccount *)readUserAccount;
@end
