//
//  ZCHomeViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/14.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "ZCTextViewController.h"
@interface ZCHomeViewController ()

@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" HighLightenImage:@"navigationbar_friendsearch_highlighted" Action:@selector(friendSearch) Target:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" HighLightenImage:@"navigationbar_pop_highlighted" Action:@selector(pop) Target:self];
}

- (void)friendSearch
{

}

- (void)pop
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[ZCTextViewController new] animated:YES];
}

@end
