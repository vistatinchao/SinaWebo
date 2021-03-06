//
//  ZCStatusFrame.m
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatusFrame.h"
#import "ZCUser.h"
#import "ZCStatusPhotoes.h"
@implementation ZCStatusFrame


#pragma mark 传递数据设置cellframe
-(void)setStatus:(ZCStatus *)status
{
    _status = status;
    [self setFrame:status];
}

- (void)setFrame:(ZCStatus *)status
{
    ZCUser *user = status.user;
    // 头像
    CGFloat iconWH = 35;
    CGFloat iconX = ZCStatusCellMargin;
    CGFloat iconY = ZCStatusCellMargin;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);

    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame)+ZCStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name stringWithFont:[UIFont systemFontOfSize:ZCStatusCellNameFont]];
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);

    // vip
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame)+ZCStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 20;
        self.vipImageViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }

    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame)+ZCStatusCellMargin;
    NSString *created_at = status.created_at;
    CGSize timeSize = [created_at stringWithFont:[UIFont systemFontOfSize:ZCStatusCellTimeFont]];
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);

    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+ZCStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source stringWithFont:[UIFont systemFontOfSize:ZCStatusCellSourceFont]];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);

    // 正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame))+ZCStatusCellMargin;
    CGSize contentSize = [status.text stringWithFont:[UIFont systemFontOfSize:ZCStatusCellContentFont] maxSize:CGSizeMake(ZCScreenW-2*ZCStatusCellMargin, CGFLOAT_MAX)];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    // 配图
    CGFloat originalViewH = 0;
    NSInteger count =status.pic_urls.count;
    if (count) {// 有配图
        CGFloat photoesViewX = iconX;
        CGFloat photoesViewY = CGRectGetMaxY(self.contentLabelFrame)+ZCStatusCellMargin;
        CGSize  photoesViewSize = [ZCStatusPhotoes photoesWithPhotoesCount:count];
        self.photoesViewFrame = CGRectMake(photoesViewX, photoesViewY, photoesViewSize.width, photoesViewSize.height);
        originalViewH = CGRectGetMaxY(self.photoesViewFrame)+ZCStatusCellMargin;
    }else{// 没有配图
        originalViewH = CGRectGetMaxY(self.contentLabelFrame)+ZCStatusCellMargin;
    }
    // originaView
    self.originalViewFrame = CGRectMake(0, ZCStatusCellMargin, ZCScreenW, originalViewH);

    //转发微博
    if (status.retweeted_status) { // 有转发微博
        CGFloat retweetContentX = ZCStatusCellMargin;
        CGFloat retweetContentY = ZCStatusCellMargin;
        NSString *content = [NSString stringWithFormat:@"@%@:%@",user.name,status.text];
        CGSize retweetConentSize = [content stringWithFont:[UIFont systemFontOfSize:ZCStatusRetweetContentFont] maxSize:CGSizeMake(ZCScreenW-2*ZCStatusCellMargin, CGFLOAT_MAX)];
        self.retweetContentLabelFrame = CGRectMake(retweetContentX, retweetContentY, retweetConentSize.width, retweetConentSize.height);
        CGFloat retweetViewH = 0;
        NSInteger count = status.retweeted_status.pic_urls.count;
        if (count) { // 有转发配图
            CGFloat retweetPhotoesViewX = retweetContentX;
            CGFloat retweetPhotoesViewY = CGRectGetMaxY(self.retweetContentLabelFrame)+ZCStatusCellMargin;
            CGSize retweetPhotoesViewSize = [ZCStatusPhotoes photoesWithPhotoesCount:count];
            self.retweetPhotoesViewFrame = CGRectMake(retweetPhotoesViewX, retweetPhotoesViewY, retweetPhotoesViewSize.width, retweetPhotoesViewSize.height);
            retweetViewH = CGRectGetMaxY(self.retweetPhotoesViewFrame)+ZCStatusCellMargin;
        }else{// 没有转发配图
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelFrame)+ZCStatusCellMargin;
        }
        // 转发微博整体 retweetViewFrame
        self.retweetViewFrame = CGRectMake(0, CGRectGetMaxY(self.originalViewFrame), ZCScreenW, retweetViewH);
        // toolbarFrame
        self.toolbarFrame = CGRectMake(0, CGRectGetMaxY(self.retweetViewFrame), ZCScreenW, 35);

    }else{
        // toolbarFrame
        self.toolbarFrame = CGRectMake(0, CGRectGetMaxY(self.originalViewFrame), ZCScreenW, 35);
    }
    // cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);

}




@end
