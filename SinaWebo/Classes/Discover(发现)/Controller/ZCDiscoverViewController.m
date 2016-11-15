//
//  ZCDiscoverViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCDiscoverViewController.h"
#import "ZCSearchBar.h"
@interface ZCDiscoverViewController ()
@property (nonatomic,weak)ZCSearchBar *searchBar;
@end

@implementation ZCDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}

- (void)setupNav
{
    ZCSearchBar *searchBar = [[ZCSearchBar alloc]init];
    searchBar.width = ZCScreenW-20;
    searchBar.height = ZCSearchBarHeight;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}



@end
