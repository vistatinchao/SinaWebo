//
//  ZCStatus.m
//  SinaWebo
//
//  Created by mac on 2016/11/22.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatus.h"
#import "NSDate+ZCExtension.h"
@implementation ZCStatus

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":[ZCPhoto class]};
}
- (NSString *)created_at
{
   
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    // 真机上不转换是不会识别的  // zh_CN  en_US
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formater.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate= [formater dateFromString:_created_at];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [NSDate date];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *componetResult = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    
    if ([createDate isThisYear]) { // 今年
       
        if ([createDate isYesterday]) {// 是昨天
            formater.dateFormat = @"昨天 HH:mm";
        }
        else if ([createDate isThisToday]) { // 今天
            if(componetResult.hour>=1){//几小时前
                return [NSString stringWithFormat:@"%zd小时前",componetResult.hour];
            }else if (componetResult.minute>=1){// 多少分钟前
                return [NSString stringWithFormat:@"%zd分钟前",componetResult.minute];
            }else{
                return @"刚刚";
            }
        }else{
            formater.dateFormat = @"MM-dd HH:mm";
        }
        
    }else{ // 不是今年
        formater.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    
    return [formater stringFromDate:createDate];

}

- (void)setSource:(NSString *)source
{
    _source = source;
    if(!source.length) return;

    NSInteger location = [source rangeOfString:@">"].location+1;
    NSInteger length = [source rangeOfString:@"<" options:NSBackwardsSearch].location-location; // 反向遍历
    NSRange  range = NSMakeRange(location, length);
    if (range.length) {
        _source =[NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    }    
}

@end
