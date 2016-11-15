//
//  ZCSearchBar.m
//  SinaWebo
//
//  Created by mac on 2016/11/15.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCSearchBar.h"

@implementation ZCSearchBar

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAttribute];
    }
    return self;
}
#pragma mark 设置属性
- (void)setAttribute
{
    self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.placeholder = @"请输入搜索条件";
    self.font = [UIFont systemFontOfSize:ZCSearchBarFont];

    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    leftView.size = CGSizeMake(ZCSearchBarHeight, ZCSearchBarHeight);
    leftView.contentMode = UIViewContentModeCenter;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
