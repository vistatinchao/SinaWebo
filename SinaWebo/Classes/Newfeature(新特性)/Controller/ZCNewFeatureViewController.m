//
//  ZCNewFeatureViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/17.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCNewFeatureViewController.h"
#import "ZCTabBarViewController.h"
@interface ZCNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *page;
@end

@implementation ZCNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
    [self addSubView];
}

- (void)initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
}

- (void)addSubView
{
    NSArray *images = @[@"new_feature_1",@"new_feature_2",@"new_feature_3",@"new_feature_4"];
    self.scrollView.contentSize = CGSizeMake(images.count*self.scrollView.width, 0);
    CGFloat imageViewWidth = self.scrollView.width;
    CGFloat imageViewHeight = self.scrollView.height;
    for (NSInteger i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(i*imageViewWidth, 0, imageViewWidth, imageViewHeight);
        imageView.image = [UIImage imageNamed:images[i]];
        if (i==images.count-1) {
            //添加按钮
            [self imageAddBtn:imageView];
        }
    }

    UIPageControl *page = [[UIPageControl alloc]init];
    [self.view addSubview:page];
    page.centerX = imageViewWidth*0.5;
    page.centerY = imageViewHeight-50;
    page.numberOfPages = images.count;
    page.currentPageIndicatorTintColor = ZCRGBColor(253, 98, 42);
    page.pageIndicatorTintColor = ZCRGBColor(189, 189, 189);
    self.page = page;
}
- (void)imageAddBtn:(UIImageView *)imageView
{
    CGFloat imageViewWidth = self.scrollView.width;
    CGFloat imageViewHeight = self.scrollView.height;
    imageView.userInteractionEnabled = YES;
    // 分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:shareBtn];
    shareBtn.size = CGSizeMake(100, 50);
    shareBtn.centerX = imageViewWidth*0.5;
    shareBtn.centerY = imageViewHeight*0.7;
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    // 开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:startBtn];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.y = CGRectGetMaxY(shareBtn.frame);
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 按钮点击
- (void)share:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)start
{
    ZCLastWindow.rootViewController = [[ZCTabBarViewController alloc]init];
}

#pragma mark scrollviewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = (scrollView.contentOffset.x+0.5*scrollView.width)/scrollView.width;
}

@end
