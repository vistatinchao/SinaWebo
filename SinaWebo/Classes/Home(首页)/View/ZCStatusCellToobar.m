//
//  ZCStatusCellToobar.m
//  SinaWebo
//
//  Created by mac on 2016/11/24.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatusCellToobar.h"
#import "ZCStatus.h"
@interface ZCStatusCellToobar()
@property (nonatomic,weak)UIButton *commentBtn;
@property (nonatomic,weak)UIButton *attitudeBtn;
@property (nonatomic,weak)UIButton *reweetBtn;

/**
 存放所有的按钮
 */
@property (nonatomic,strong)NSMutableArray *btns;

/**
 存放所有的分割线
 */
@property (nonatomic,strong)NSMutableArray *dividers;
@end

@implementation ZCStatusCellToobar

+ (instancetype)toolbar
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        // 设置子控件
        UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addBtn:commentBtn image:@"timeline_icon_comment" title:@"评论"];
        self.commentBtn = commentBtn;

        UIButton *reweetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addBtn:reweetBtn image:@"timeline_icon_retweet" title:@"转发"];
        self.reweetBtn = reweetBtn;

        UIButton *attitudeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addBtn:attitudeBtn image:@"timeline_icon_unlike" title:@"赞"];
        self.attitudeBtn = attitudeBtn;

        [self addDivider];
        [self addDivider];
    }
    return self;
}
#pragma mark 添加按钮
- (void)addBtn:(UIButton *)btn image:(NSString *)image title:(NSString *)title
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:btn];
    [self.btns addObject:btn];
}
#pragma mark 添加分割线
- (void)addDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (void)setStatus:(ZCStatus *)status
{
    _status = status;
    [self setupBtnTitle:self.commentBtn withCount:status.comments_count title:@"评论"];
    [self setupBtnTitle:self.reweetBtn withCount:status.reposts_count title:@"转发"];
    [self setupBtnTitle:self.attitudeBtn withCount:status.attitudes_count title:@"赞"];
}
#pragma mark 更新按钮文字
- (void)setupBtnTitle:(UIButton *)btn withCount:(NSInteger)count title:(NSString *)title
{
    if (count>0) {
        if (count>=10000) {
            double wan = count/10000;
            title = [NSString stringWithFormat:@"%.lf万+",wan];
        }else{
            title = [NSString stringWithFormat:@"%zd",count];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 按钮frame
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.width/self.btns.count;
    CGFloat btnH = self.height;
    for (NSInteger i=0; i<self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    // 分割线frame
    CGFloat dividerX = 0;
    CGFloat dividerY = 0;
    CGFloat dividerW = 1;
    CGFloat dividerH = self.height;
    for (NSInteger i=0; i<self.dividers.count; i++) {
        UIImageView *diveder = self.dividers[i];
        dividerX = (i+1)*btnW;
        diveder.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

@end
