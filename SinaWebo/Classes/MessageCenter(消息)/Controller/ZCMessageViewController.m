//
//  ZCMessageViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCMessageViewController.h"

@interface ZCMessageViewController ()

@end

@implementation ZCMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    ZCLogFunc;
}
- (void)setupNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)composeMsg
{
    ZCLogFunc;
}



@end
