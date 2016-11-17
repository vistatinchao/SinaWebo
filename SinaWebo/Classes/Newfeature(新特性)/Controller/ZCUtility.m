//
//  ZCUtility.m
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCUtility.h"

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


@end
