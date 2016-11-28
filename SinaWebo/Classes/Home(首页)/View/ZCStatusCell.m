//
//  ZCStatusCell.m
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatusCell.h"
#import "ZCStatusFrame.h"
#import "ZCUser.h"
#import "ZCStatusCellToobar.h"
#import "ZCStatusPhotoes.h"
@interface ZCStatusCell()
/** 原创微博整体 */
@property (nonatomic,weak)UIView *originalView;
/** 头像 */
@property (nonatomic,weak)UIImageView *iconImageView;
/** 会员图标 */
@property (nonatomic,weak)UIImageView *vipImageView;
/** 昵称 */
@property (nonatomic,weak)UILabel *nameLabel;
/** 时间 */
@property (nonatomic,weak)UILabel *timeLabel;
/** 来源 */
@property (nonatomic,weak)UILabel *sourceLabel;
/** 正文 */
@property (nonatomic,weak)UILabel *contentLabel;
/** 配图 */
@property (nonatomic,weak)ZCStatusPhotoes *photoesView;

/** 转发微博整体 */
@property (nonatomic,weak)UIView *retweetView;
/** 转发微博内容 */
@property (nonatomic,weak)UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic,weak)ZCStatusPhotoes *retweetPhotoesView;

/** 工具条 */
@property (nonatomic,weak)ZCStatusCellToobar *toolbarView;
@end

@implementation ZCStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         [self setupCell];
         [self addOriginalView];
         [self addRetreetView];
         [self addToolbarView];
    }
    return self;
}
- (void)setupCell
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark 原创微博
- (void)addOriginalView
{
    //原创微博整体 originalView
    UIView *originalView = [[UIView alloc]init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    self.originalView = originalView;

    // 头像
    UIImageView *iconImageView = [[UIImageView alloc]init];
    [originalView addSubview:iconImageView];
    self.iconImageView = iconImageView;

    //昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    [originalView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:ZCStatusCellNameFont];
    self.nameLabel = nameLabel;

    /** 会员图标 */
    UIImageView *vipImageView = [[UIImageView alloc]init];
    [originalView addSubview:vipImageView];
    vipImageView.contentMode = UIViewContentModeCenter;
    self.vipImageView = vipImageView;

    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc]init];
    [originalView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = [UIFont systemFontOfSize:ZCStatusCellTimeFont];
    self.timeLabel = timeLabel;

    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc]init];
    [originalView addSubview:sourceLabel];
    sourceLabel.font = [UIFont systemFontOfSize:ZCStatusCellSourceFont];
    self.sourceLabel = sourceLabel;

    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc]init];
    [originalView addSubview:contentLabel];
    contentLabel.font = [UIFont systemFontOfSize:ZCStatusCellContentFont];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    
    /** 配图 */
    ZCStatusPhotoes *photoesView = [ZCStatusPhotoes photoes];
    [originalView addSubview:photoesView];
    self.photoesView = photoesView;
}
#pragma mark 转发微博
- (void)addRetreetView
{
    //微博整体 retweetView
    UIView *retweetView = [[UIView alloc]init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = ZCRGBColor(247, 247, 247);
    self.retweetView = retweetView;

    //昵称
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.font = [UIFont systemFontOfSize:ZCStatusRetweetContentFont];
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;

    /** 配图 */
    ZCStatusPhotoes *photoesView = [ZCStatusPhotoes photoes];
    [retweetView addSubview:photoesView];
    self.retweetPhotoesView = photoesView;


}
#pragma mark 工具条
- (void)addToolbarView
{
    ZCStatusCellToobar *toolbar = [ZCStatusCellToobar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbarView = toolbar;
}
#pragma mark 设置子控件数据和frame
- (void)setStatusFrame:(ZCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    // 设置原创微博的数据
    [self setOriginalViewFrameAndContent:statusFrame];
    // 设置转发微博的数据
    [self setRetweetViewFrameAndContent:statusFrame];
    // 设置toolbar的数据
    [self setToolbarViewFrameAndContent:statusFrame];

}

- (void)setOriginalViewFrameAndContent:(ZCStatusFrame *)statusFrame
{
     ZCUser *user = statusFrame.status.user;
    //原创微博整体 originalView
    self.originalView.frame = statusFrame.originalViewFrame;

    // 头像
    self.iconImageView.frame = statusFrame.iconViewFrame;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];

    /** 会员图标 */
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipImageView.frame = statusFrame.vipImageViewFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipName];
    }else{
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    //昵称
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;

    /** 时间 */
    
    NSString *created_at  = statusFrame.status.created_at; // 必须重新计算frame ,否则会导致时间的字体还是以前的，会显示不全
    CGSize timeSize = [created_at stringWithFont:[UIFont systemFontOfSize:ZCStatusCellTimeFont]];
    self.timeLabel.size = timeSize;
    self.timeLabel.x = self.nameLabel.x;
    self.timeLabel.y = CGRectGetMaxY(self.nameLabel.frame)+ZCStatusCellMargin;
    self.timeLabel.text = created_at;

    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    self.sourceLabel.text = statusFrame.status.source;
    self.sourceLabel.x = CGRectGetMaxX(self.timeLabel.frame)+ZCStatusCellMargin; // 更新来源的尺寸
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = statusFrame.status.text;
    /** 配图 */
    if (statusFrame.status.pic_urls.count) { // 有配图
        self.photoesView.hidden = NO;
        self.photoesView.photoes = statusFrame.status.pic_urls;
        self.photoesView.frame = statusFrame.photoesViewFrame;

    }else{
        self.photoesView.hidden = YES;
    }

}

- (void)setRetweetViewFrameAndContent:(ZCStatusFrame *)statusFrame
{
    ZCStatus *status = statusFrame.status;
    if (status.retweeted_status) { // 有转发微博
        self.retweetView.hidden = NO;
        ZCUser *user = status.user;
        /**转发微博整体 retweetView */
        self.retweetView.frame = statusFrame.retweetViewFrame;
        /** 正文 */
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
        NSString *content = [NSString stringWithFormat:@"@%@:%@",user.name,status.text];
        self.retweetContentLabel.text = content;
        /** 配图 */
        if (status.retweeted_status.pic_urls.count) { //有配图
            self.retweetPhotoesView.hidden = NO;
            self.retweetPhotoesView.frame = statusFrame.retweetPhotoesViewFrame;
            self.retweetPhotoesView.photoes = status.retweeted_status.pic_urls;

        }else{// 没有配图
            self.retweetPhotoesView.hidden = YES;
        }
    }else{  //没有转发微博
        self.retweetView.hidden = YES;
    }
}
- (void)setToolbarViewFrameAndContent:(ZCStatusFrame *)statusFrame
{
    self.toolbarView.status = statusFrame.status;
    self.toolbarView.frame = statusFrame.toolbarFrame;
}
@end








