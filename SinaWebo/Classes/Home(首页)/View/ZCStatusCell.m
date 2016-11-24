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
}
#pragma mark 转发微博
- (void)addRetreetView
{

}
#pragma mark 工具条
- (void)addToolbarView
{

}
#pragma mark 设置子控件数据和frame
- (void)setStatusFrame:(ZCStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
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
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    self.timeLabel.text = statusFrame.status.created_at;

    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    self.sourceLabel.text = statusFrame.status.source;

    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    self.contentLabel.text = statusFrame.status.text;
}

@end
