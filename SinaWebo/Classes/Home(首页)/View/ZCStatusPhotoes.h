//
//  ZCStatusPhotoes.h
//  SinaWebo
//
//  Created by mac on 2016/11/28.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCStatusPhotoes : UIView
+(instancetype)photoes;
@property (nonatomic,strong)NSArray *photoes;

/**
 根据数组长度返回尺寸

 @param count 数组长度
 @return size
 */
+ (CGSize)photoesWithPhotoesCount:(NSInteger)count;
@end
