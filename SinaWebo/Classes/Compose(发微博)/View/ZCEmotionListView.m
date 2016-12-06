//
//  ZCEmotionListView.m
//  SinaWebo
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionListView.h"

@implementation ZCEmotionListView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZCRandomColor;
    }
    return self;
}
#warning todo
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
