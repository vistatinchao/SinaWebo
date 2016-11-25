//
//  ZCStatusFrame.h
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCStatus.h"
@interface ZCStatusFrame : NSObject

@property (nonatomic,strong)ZCStatus *status;
/** 原创微博整体Frame */
@property (nonatomic,assign)CGRect originalViewFrame;
/** 头像Frame */
@property (nonatomic,assign)CGRect iconViewFrame;
/** 会员图标Frame */
@property (nonatomic,assign)CGRect vipImageViewFrame;
/** 昵称Frame */
@property (nonatomic,assign)CGRect nameLabelFrame;
/** 时间Frame*/
@property (nonatomic,assign)CGRect timeLabelFrame;
/** 来源Frame */
@property (nonatomic,assign)CGRect sourceLabelFrame;
/** 正文Frame*/
@property (nonatomic,assign)CGRect contentLabelFrame;
/** 配图Frame*/
@property (nonatomic,assign)CGRect photoImageViewFrame;

/** 转发微博整体Frame */
@property (nonatomic,assign)CGRect retweetViewFrame;
/** 转发微博整体内容 */
@property (nonatomic,assign)CGRect retweetContentLabelFrame;
/** 转发微博配图Frame */
@property (nonatomic,assign)CGRect retweetPhotoImageViewFrame;

/** toolbarFrame */
@property (nonatomic,assign)CGRect toolbarFrame;
/** cell高度*/
@property (nonatomic,assign)CGFloat cellHeight;
@end
