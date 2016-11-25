//
//  ZCStatusCellToobar.h
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCStatus;
@interface ZCStatusCellToobar : UIView
@property (nonatomic,strong)ZCStatus *status;
+(instancetype)toolbar;

@end
