//
//  ZCEmotionKeyboard.m
//  SinaWebo
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionKeyboard.h"
#import "ZCEmotionToolbar.h"
#import "ZCEmotionListView.h"
#import "ZCEmotion.h"
@interface ZCEmotionKeyboard()<ZCEmotionToolbarDelegate>
/** tabbar */
@property (nonatomic,weak)ZCEmotionToolbar *toolbar;
/** 正在显示的表情listView */
@property (nonatomic,weak)ZCEmotionListView *showingListView;
/** 最近的表情listView */
@property (nonatomic,strong)ZCEmotionListView *recentListView;
/** 默认的表情listView */
@property (nonatomic,strong)ZCEmotionListView *defaultListView;
/** emoji的表情listView */
@property (nonatomic,strong)ZCEmotionListView *emojiListView;
/** 浪小花的表情listView */
@property (nonatomic,strong)ZCEmotionListView *lxhListView;
@end
@implementation ZCEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview];
    }
    return self;
}


- (ZCEmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[ZCEmotionListView alloc]init];
    }
    return _recentListView;
}

- (ZCEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[ZCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultListView.emotions = [ZCEmotion mj_objectArrayWithFile:path];
    }
    return _defaultListView;
}

- (ZCEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView = [[ZCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiListView.emotions = [ZCEmotion mj_objectArrayWithFile:path];
    }
    return _emojiListView;
}

- (ZCEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[ZCEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotions = [ZCEmotion mj_objectArrayWithFile:path];
    }
    return _lxhListView;
}

- (void)addSubview
{
    ZCEmotionToolbar *toolbar = [[ZCEmotionToolbar alloc]init];
    [self addSubview:toolbar];
    toolbar.delegate = self;
    self.toolbar = toolbar;

    ZCEmotionListView *showingListView = [[ZCEmotionListView alloc]init];
    [self addSubview: showingListView];
    self.showingListView = showingListView;
}

- (void)emotionToolbar:(ZCEmotionToolbar *)emotionToolbar didClickBtnType:(ZCEmotionToolbarButtonType)btnType
{

    [self.showingListView removeFromSuperview];
    switch (btnType) {
        case ZCEmotionToolbarButtonRecent:{
            [self addSubview:self.recentListView];
            self.showingListView = self.recentListView;
            break;
        }
        case ZCEmotionToolbarButtonDefault:{
            [self addSubview:self.defaultListView];
            self.showingListView = self.defaultListView;
            break;
        }
        case ZCEmotionToolbarButtonEmoji:{
            [self addSubview:self.emojiListView];
            self.showingListView = self.emojiListView;
            break;
        }
        case ZCEmotionToolbarButtonLxh:{
            [self addSubview:self.lxhListView];
            self.showingListView = self.lxhListView;
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toolbar.x = 0;
    self.toolbar.width = self.width;
    self.toolbar.height = ZCEmotionToolbarHeight;
    self.toolbar.y = self.height-self.toolbar.height;

    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.toolbar.y;
}

@end
