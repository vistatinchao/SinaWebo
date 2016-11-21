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
@property (nonatomic,strong)ZCHomeTitleButton *titleBtn;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setupNav];
}

- (void)requestData
{
    ZCUserAccount *user = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = user.access_token;
    params[@"uid"] = user.uid;
    [[ZCAFHttpsRequest share] GetRequestWithUrl:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        ZCLog(@"%@",responseObject);
        user.name = responseObject[@"name"];
        // 更新沙盒
        [ZCUtility saveUserAccount:user];
        // 设置tileView
        self.navigationItem.titleView = self.titleBtn;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZCLog(@"%@",error);
    }];
}





#pragma mark 设置导航栏内容
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" HighLightenImage:@"navigationbar_friendsearch_highlighted" Action:@selector(friendSearch) Target:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" HighLightenImage:@"navigationbar_pop_highlighted" Action:@selector(pop) Target:self];


}

- (ZCHomeTitleButton *)titleBtn
{
    if (!_titleBtn) {
        ZCHomeTitleButton *titleBtn = [[ZCHomeTitleButton alloc]init];
        _titleBtn = titleBtn;
        [_titleBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
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
