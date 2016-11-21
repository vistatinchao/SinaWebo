//
//  ZCUserAccount.h
//  SinaWebo
//
//  Created by mac on 2016/11/18.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUserAccount : NSObject <NSCoding>

@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *expires_in;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,strong) NSDate *create_time;
@property (nonatomic,copy) NSString *name;
+(instancetype)userAccountWithDictionary:(NSDictionary *)userDict;

@end
