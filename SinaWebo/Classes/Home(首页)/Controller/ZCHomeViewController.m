//
//  ZCHomeViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "ZCTextViewController.h"
#import "ZCDrawDownMenu.h"
#import "ZCHomeTitleButton.h"
@interface ZCHomeViewController ()<DrawDownMenuDelegate>
@property (nonatomic,weak)ZCHomeTitleButton *titleBtn;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}
#pragma mark 设置导航栏内容
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" HighLightenImage:@"navigationbar_friendsearch_highlighted" Action:@selector(friendSearch) Target:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" HighLightenImage:@"navigationbar_pop_highlighted" Action:@selector(pop) Target:self];
    // 设置tileView
    ZCHomeTitleButton *button = [ZCHomeTitleButton titleButton];
    self.navigationItem.titleView = button;
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    button.width = 100;
    button.height = 40;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    self.titleBtn = button;
}

#pragma mark 监听首页按钮点击
- (void)showMenu:(ZCHomeTitleButton *)btn
{
    // 显示menu
    ZCDrawDownMenu *menu = [ZCDrawDownMenu menu];
    menu.delegate = self;
    [menu showFromView:btn];
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, 200, 300);
    view.backgroundColor = [UIColor redColor];
    menu.contentView = view;
    // 更换btn状态
    [self drawDownMenuShow:menu];
}


#pragma mark DrawDownMenuDelegate

/**
    menu Dismiss
 */
- (void)drawDownMenuDismiss:(ZCDrawDownMenu *)menu
{
    self.titleBtn.selected = NO;
}

/**
 menu Show
 */
- (void)drawDownMenuShow:(ZCDrawDownMenu *)menu
{
    self.titleBtn.selected = YES;
}

- (void)friendSearch
{
    ZCTextViewController *text = [[ZCTextViewController alloc]init];
    [self.navigationController pushViewController:text animated:YES];
}

- (void)pop
{
 
}



@end
