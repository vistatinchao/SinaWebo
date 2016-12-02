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
#import "ZCStatusFrame.h"
#import "ZCStatusCell.h"
@interface ZCHomeViewController ()<DrawDownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)ZCHomeTitleButton *titleBtn;
@property (nonatomic,strong)NSMutableArray *statusesFrames;
@property (nonatomic,weak)UITableView *tableView;
@end
static NSString *const cellID = @"statusCell";
@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestUserData];
    [self setupNav];
    [self initTableView];
    [self showUnReadStatusCount];
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
    [tableView registerClass:[ZCStatusCell class] forCellReuseIdentifier:cellID];
    tableView.backgroundColor = ZCRGBColor(211, 211, 211);
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
#pragma mark status模型数组 转成 statusFrame模型数组
- (NSMutableArray *)statusTurnStatusFrame:(NSArray *)statuses
{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (ZCStatus *status in statuses) {
        ZCStatusFrame *frameModel = [[ZCStatusFrame alloc]init];
        frameModel.status = status;
        [statusFrames addObject: frameModel];
    }
    return statusFrames;
}

#pragma mark 下拉
- (void)loadNewStatusData
{
    ZCUserAccount *userAccount = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userAccount.access_token;
    ZCStatusFrame *statusFrame = self.statusesFrames.firstObject;
    if (statusFrame) {
        params[@"since_id"] = statusFrame.status.idstr;
    }
    [[ZCAFHttpsRequest share]GetRequestWithUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *newStatus = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusFrames = [self statusTurnStatusFrame:newStatus];
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newStatusFrames atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        // 刷新成功显示下拉数据
        [self shouNewStatusCount:newStatusFrames.count];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        ZCLog(@"%@",error);
    }];
}

- (void)shouNewStatusCount:(NSInteger)totalIndex
{
    // 清空未读
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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
    ZCUserAccount *userAccount = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userAccount.access_token;
    ZCStatusFrame *statusFrame = self.statusesFrames.lastObject;
    if (statusFrame) {
        long long maxId = statusFrame.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    [[ZCAFHttpsRequest share] GetRequestWithUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *newStatus = [ZCStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        if (!newStatus.count) {// 数据加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.statusesFrames addObjectsFromArray:[self statusTurnStatusFrame:newStatus]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZCLog(@"%@",error);
        [UIAlertView alertWithShowMessage:@"请求失败"];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];

}

#pragma mark showUnReadStatusCount

- (void)showUnReadStatusCount
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:65.0 target:self selector:@selector(showBadgeValue) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)showBadgeValue
{
    ZCUserAccount *userAccount = [ZCUtility readUserAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userAccount.access_token;
    params[@"uid"] = userAccount.uid;

    [[ZCAFHttpsRequest share] GetRequestWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![[responseObject[@"status"] description] isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = [responseObject[@"status"] description];
            [UIApplication sharedApplication].applicationIconBadgeNumber = self.tabBarItem.badgeValue.integerValue;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZCLog(@"%@",error);
        [UIAlertView alertWithShowMessage:@"请求失败"];
    }];
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
#pragma mark tableviewDetasource && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // ZCStatusCell *cell = [[ZCStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    ZCStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    ZCStatusFrame *statusFrames = self.statusesFrames[indexPath.row];

    cell.statusFrame = statusFrames;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ZCStatusFrame *statusFrames = self.statusesFrames[indexPath.row];

     return statusFrames.cellHeight;
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
-(NSMutableArray *)statusesFrames
{
    if (!_statusesFrames) {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

@end
