//
//  NSDate+ZCExtension.m
//  SinaWebo
//
//  Created by zouchao on 2016/11/26.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "NSDate+ZCExtension.h"

@implementation NSDate (ZCExtension)


- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *componentFrom = [calendar components:unit fromDate:self];
    NSDateComponents *componentNow = [calendar components:unit fromDate:[NSDate date]];
    return componentFrom.year==componentNow.year;
}

- (BOOL)isThisToday
{
    // 先去掉hh mm ss 才能准确比较日期
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSString *newDate = [formater stringFromDate:self];
    NSString *now = [formater stringFromDate:[NSDate date]];
    NSDate *fromDate = [formater dateFromString:newDate];
    NSDate *nowDate = [formater dateFromString:now];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *componentFrom = [calendar components:unit fromDate:fromDate toDate:nowDate options:0];
    return componentFrom.year==0 && componentFrom.month==0 && componentFrom.date==0;
    
}

- (BOOL)isYesterday
{
    // 先去掉hh mm ss 才能准确比较日期
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSString *newDate = [formater stringFromDate:self];
    NSString *now = [formater stringFromDate:[NSDate date]];
    NSDate *fromDate = [formater dateFromString:newDate];
    NSDate *nowDate = [formater dateFromString:now];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *componentFrom = [calendar components:unit fromDate:fromDate toDate:nowDate options:0];
    return componentFrom.year==0 && componentFrom.month==0 &&componentFrom.day==1 ;
}


@end
