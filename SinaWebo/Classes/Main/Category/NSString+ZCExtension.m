//
//  NSString+ZCExtension.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "NSString+ZCExtension.h"

@implementation NSString (ZCExtension)

- (CGSize)stringWithFont:(UIFont *)font
{
    return [self stringWithFont:font maxSize:CGSizeZero];
}


- (CGSize)stringWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
}
@end
