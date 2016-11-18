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
    return [NSKeyedUnarchiver unarchiveObjectWithFile:Path];
}
@end
