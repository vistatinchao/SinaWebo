//
//  ZCEmotionListView.m
//  SinaWebo
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCEmotionListView.h"
#import "ZCEmotionsPageView.h"
@interface ZCEmotionListView()<UIScrollViewDelegate>
@property (nonatomic,weak)UIScrollView *scrollview;
@property (nonatomic,weak)UIPageControl *pageController;
@end
@implementation ZCEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    // add scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollview = scrollView;

    // add pagecontroller
    UIPageControl *page = [[UIPageControl alloc]init];
    [self addSubview:page];
    page.userInteractionEnabled = NO;
    [page setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
    [page setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"]forKeyPath:@"currentPageImage"];
    self.pageController = page;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger pageMaxCount = ZCEmotionListViewPageMaxCount;// 每一页的最大个数
    NSUInteger pages = (emotions.count+pageMaxCount-1)/pageMaxCount;// 有多少页
    for (NSInteger i=0;i<pages ; i++) {
        ZCEmotionsPageView *pageView = [[ZCEmotionsPageView alloc]init];
        [self.scrollview addSubview:pageView];
        NSUInteger location = i*pageMaxCount;
        NSUInteger length = pageMaxCount;
        NSUInteger leaveLength = emotions.count-location;
        if (leaveLength<length) {
            length = leaveLength;
        }
        NSRange range = NSMakeRange(location, length);
        NSArray *pageEmotions = [emotions subarrayWithRange:range];
        pageView.emotions = pageEmotions;
    }
    self.pageController.numberOfPages = pages;
    [self setNeedsLayout];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x/self.width;
    self.pageController.currentPage = (int)(offset+0.5);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pageController.x = 0;
    self.pageController.width = self.width;
    self.pageController.height = 35;
    self.pageController.y = self.height-self.pageController.height;

    self.scrollview.x = self.scrollview.y = 0;
    self.scrollview.width = self.width;
    self.scrollview.height = self.pageController.y;

    NSUInteger count = self.scrollview.subviews.count;
    for (NSInteger i=0; i<count; i++) {
        ZCEmotionsPageView *pageView = self.scrollview.subviews[i];
        pageView.x = self.scrollview.width*i;
        pageView.y = 0;
        pageView.width = self.scrollview.width;
        pageView.height = self.scrollview.height;
    }
    self.scrollview.contentSize = CGSizeMake(count*ZCScreenW, 0);

}
@end
