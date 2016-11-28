//
//  NSDate+ZCExtension.h
//  SinaWebo
//
//  Created by zouchao on 2016/11/26.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZCExtension)

/**
 是今年吗
*/
- (BOOL)isThisYear;

/**
 是今天吗
 */
- (BOOL)isThisToday;

/**
 是昨天吗
 */

- (BOOL)isYesterday;
@end
