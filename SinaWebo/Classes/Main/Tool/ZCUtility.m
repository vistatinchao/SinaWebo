//
//  ZCUtility.m
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCUtility.h"
#define Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
@implementation ZCUtility

+ (void)writeToFile:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)readFileForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+(void)saveUserAccount:(ZCUserAccount *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:Path];
}

+(ZCUserAccount *)readUserAccount
{
    ZCUserAccount *user = [NSKeyedUnarchiver unarchiveObjectWithFile:Path];
    
    long long expired_time = user.expires_in.longLongValue;
    NSDate *date = [user.create_time dateByAddingTimeInterval:expired_time];
    NSDate *now = [NSDate date];
    NSComparisonResult result = [date compare:now];
    if (result!=NSOrderedDescending) {  //过期
        return nil;
    }
    return user;
}
@end
