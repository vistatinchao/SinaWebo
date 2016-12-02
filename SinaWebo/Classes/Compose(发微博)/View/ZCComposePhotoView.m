//
//  ZCComposePhotoView.m
//  SinaWebo
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
// 发微博相册

#import "ZCComposePhotoView.h"
@interface ZCComposePhotoView()
@property (nonatomic,strong)NSMutableArray *photoes; // 存放所有imageView
@end
@implementation ZCComposePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _photoArr = [NSArray array];
    }
    return self;
}

- (void)addImagePhoto:(UIImage *)photo
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    imageView.image = photo;
    [self.photoes addObject:photo];
    _photoArr = self.photoes;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    NSUInteger maxCow = ZCComposePhotoesMaxCow;
    CGFloat margin = ZCComposePhotoMargin;
    CGFloat imageViewWH = ZCComposePhotoImageWH;
    for (NSUInteger i=0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        NSUInteger cow = i%maxCow;
        NSUInteger row = i/maxCow;
        imageView.x = (imageViewWH+margin)*cow;
        imageView.y = (imageViewWH+margin)*row;
        imageView.width = imageView.height = imageViewWH;
    }
}


- (NSMutableArray *)photoes
{
    if (!_photoes) {
        _photoes = [NSMutableArray array];
    }
    return _photoes;
}



@end
