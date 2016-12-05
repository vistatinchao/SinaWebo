//
//  ZCEmotionKeyboard.m
//  SinaWebo
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionKeyboard.h"
#import "ZCEmotionToolbar.h"
@interface ZCEmotionKeyboard()
@property (nonatomic,weak)ZCEmotionToolbar *toolbar;
@end
@implementation ZCEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview];
    }
    return self;
}

- (void)addSubview
{
    ZCEmotionToolbar *toolbar = [[ZCEmotionToolbar alloc]init];
    [self addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toolbar.x = 0;
    self.toolbar.width = self.width;
    self.toolbar.height = ZCEmotionToolbarHeight;
    self.toolbar.y = self.height-self.toolbar.height;
}

@end
