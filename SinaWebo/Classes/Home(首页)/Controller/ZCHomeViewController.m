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
#import "ZCUser.h"
#import "ZCStatus.h"
@interface ZCHomeViewController ()<DrawDownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)ZCHomeTitleButton *titleBtn;
@property (nonatomic,strong)NSMutableArray *statuses;
@property (nonatomic,weak)UITableView *tableView;
@end
static NSString *const cellID = @"statusCell";
@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestUserData];
    [self setupNav];
    [self initTableView];
}

#pragma mark 加载tableview
- (void)initTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    // 设置tableview基本属性
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(ZCNavBarHeight, 0, ZCTabBarHeight, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    tableView.rowHeight = 100;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // 集成上下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatusData)];
    tableView.mj_header = header;
    [tableView.mj_header beginRefreshing];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatusData)];
    tableView.mj_footer = footer;

    self.tableView = tableView;

}
#pragma mark 请求用户数据
- (void)requestUserData
{
    ZCUserAccount *userAccount = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userAccount.access_token;
    params[@"uid"] = userAccount.uid;
    [[ZCAFHttpsRequest share] GetRequestWithUrl:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        ZCUser *users = [ZCUser mj_objectWithKeyValues:responseObject];
        userAccount.name = users.name;
        // 更新沙盒
        [ZCUtility saveUserAccount:userAccount];
        // 设置tileView标题
        [self.titleBtn setTitle:users.name forState:UIControlStateNormal];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZCLog(@"%@",error);
    }];
}
#pragma mark 下拉
- (void)loadNewStatusData
{
    ZCUserAccount *userAccount = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userAccount.access_token;
    ZCStatus *status = self.statuses.firstObject;
    if (status) {
        params[@"since_id"] = status.idstr;
    }
    [[ZCAFHttpsRequest share]GetRequestWithUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *newStatus = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatus atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        // 刷新成功显示下拉数据
        [self shouNewStatusCount:newStatus.count];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        ZCLog(@"%@",error);
    }];
}

- (void)shouNewStatusCount:(NSInteger)totalIndex
{
    UILabel *label = [[UILabel alloc]init];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = self.view.width;
    label.height = 35;
    label.text = totalIndex?[NSString stringWithFormat:@"共有%zd条新的数据",totalIndex]:@"没有更多数据，请稍后再试";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    // 动画显示
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, ZCNavBarHeight);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark 上拉
- (void)loadMoreStatusData
{

}

#pragma mark 设置导航栏内容
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" HighLightenImage:@"navigationbar_friendsearch_highlighted" Action:@selector(friendSearch) Target:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" HighLightenImage:@"navigationbar_pop_highlighted" Action:@selector(pop) Target:self];

    self.navigationItem.titleView = self.titleBtn;
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
#pragma mark tableviewDetasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];

    ZCStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    return cell;
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
#pragma mark 懒加载
- (ZCHomeTitleButton *)titleBtn
{
    if (!_titleBtn) {
        ZCHomeTitleButton *titleBtn = [[ZCHomeTitleButton alloc]init];
        _titleBtn = titleBtn;
        [_titleBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}
-(NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

@end
