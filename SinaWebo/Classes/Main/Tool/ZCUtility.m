//
//  ZCUtility.m
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCUtility.h"
#import "ZCEmotion.h"
#define Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#define RecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotion.archive"]
static NSMutableArray *_emotions;
@implementation ZCUtility

+ (void)initialize
{
    _emotions = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionPath];
    if (_emotions==nil) {
        _emotions = [NSMutableArray array];
    }
}

+ (void)writeToFile:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)readFileForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
#pragma mark 读取用户信息
+(void)saveUserAccount:(ZCUserAccount *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:Path];
}

#pragma mark 保存用户信息
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
#pragma mark 保存最近表情数组
+(void)saveRecentEmotion:(ZCEmotion *)emotion
{

    // shanchuchongfu
    for (ZCEmotion *emotionModel in _emotions) {
        if ([emotionModel.png isEqualToString:emotion.png]||[emotionModel.code isEqualToString:emotion.code]) {
            [_emotions removeObject:emotionModel];
            break;
        }
    }
    [_emotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_emotions toFile:RecentEmotionPath];
}

#pragma mark 读取最近表情数组
+ (NSArray *)readRecentEmotion
{
    return _emotions;
}

@end
