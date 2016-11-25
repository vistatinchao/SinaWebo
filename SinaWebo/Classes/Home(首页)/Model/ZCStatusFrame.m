//
//  ZCStatusFrame.m
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatusFrame.h"
#import "ZCUser.h"
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
    CGSize nameSize = [self sizeWithString:user.name font:[UIFont systemFontOfSize:ZCStatusCellNameFont]];
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
    CGSize timeSize = [self sizeWithString:status.created_at font:[UIFont systemFontOfSize:ZCStatusCellTimeFont]];
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);

    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame)+ZCStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithString:status.source font:[UIFont systemFontOfSize:ZCStatusCellSourceFont]];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);

    // 正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame))+ZCStatusCellMargin;
    CGSize contentSize = [self sizeWithString:status.text maxSize:CGSizeMake(ZCScreenW-2*ZCStatusCellMargin, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ZCStatusCellContentFont]];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    // 配图
    CGFloat originalViewH = 0;
    if (status.pic_urls.count) {// 有配图
        CGFloat photoImageViewX = iconX;
        CGFloat photoImageViewY = CGRectGetMaxY(self.contentLabelFrame)+ZCStatusCellMargin;
        CGFloat photoImageWH = 100;
        self.photoImageViewFrame = CGRectMake(photoImageViewX, photoImageViewY, photoImageWH, photoImageWH);
        originalViewH = CGRectGetMaxY(self.photoImageViewFrame)+ZCStatusCellMargin;
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
        CGSize retweetConentSize = [self sizeWithString:content maxSize:CGSizeMake(ZCScreenW-2*ZCStatusCellMargin, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ZCStatusRetweetContentFont]];
        self.retweetContentLabelFrame = CGRectMake(retweetContentX, retweetContentY, retweetConentSize.width, retweetConentSize.height);
        CGFloat retweetViewH = 0;
        if (status.retweeted_status.pic_urls.count) { // 有转发配图
            CGFloat retweetPhotoImageX = retweetContentX;
            CGFloat retweetPhotoImageY = CGRectGetMaxY(self.retweetContentLabelFrame)+ZCStatusCellMargin;
            CGFloat retweetPhotoImageWH = 100;
            self.retweetPhotoImageViewFrame = CGRectMake(retweetPhotoImageX, retweetPhotoImageY, retweetPhotoImageWH, retweetPhotoImageWH);
            retweetViewH = CGRectGetMaxY(self.retweetPhotoImageViewFrame)+ZCStatusCellMargin;
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

#pragma mark 根据文字自适应尺寸
- (CGSize)sizeWithString:(NSString *)string maxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    return [self sizeWithString:string maxSize:CGSizeZero font:font];
}
@end
