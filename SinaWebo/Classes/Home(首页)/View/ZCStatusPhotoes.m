//
//  ZCStatusPhotoes.m
//  SinaWebo
//
//  Created by mac on 2016/11/28.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCStatusPhotoes.h"
#import "ZCPhotoImageView.h"
@implementation ZCStatusPhotoes

+(instancetype)photoes
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =ZCRGBColor(247, 247, 247);
    }
    return self;
}

- (void)setPhotoes:(NSArray *)photoes
{
    _photoes = photoes;
    // 调用频繁 添加子控件
    // 先移除子控件 这种方法影响性能 操作太频繁
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count =MIN(ZCStatusPhotoesMaxCount,photoes.count);
    for (NSInteger i=0; i<count; i++) {
        ZCPhotoImageView *photoImageView = [[ZCPhotoImageView alloc]init];
        [self addSubview:photoImageView];
        photoImageView.photo = photoes[i];
    }

/*  奔溃
    NSUInteger photosCount = photoes.count;
    while (self.subviews.count<photosCount) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
    }

    // 遍历所有的图片控件，设置图片
    for (NSInteger i=0; i<self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        ZCPhoto *photo = photoes[i];
        if (i<photosCount) {
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
            imageView.hidden = YES; // 防止循环复用
        }
    }
 */
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewWH = ZCStatusPhotoImageWH;
    NSInteger count = self.photoes.count;
    NSInteger maxCow = (count==4?2:(count>=ZCStatusPhotoesMaxCow)?ZCStatusPhotoesMaxCow:count);
    for (NSInteger i=0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        NSInteger cow = i%maxCow;
        NSInteger row = i/maxCow;
        imageViewX = cow*(imageViewWH+ZCStatusCellMargin);
        imageViewY = row*(imageViewWH+ZCStatusCellMargin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
    }
}

+ (CGSize)photoesWithPhotoesCount:(NSInteger)count
{
    count = MIN(count, ZCStatusPhotoesMaxCount); // 最多9张
    NSInteger maxCow = 0;
    if (count==4) {
        maxCow = 2;
    }else{
        maxCow = count>=ZCStatusPhotoesMaxCow?ZCStatusPhotoesMaxCow:count;
    }
    NSInteger row = (count+maxCow-1)/maxCow;
    NSInteger photoesViewWidth = maxCow*ZCStatusPhotoImageWH+(maxCow-1)*ZCStatusCellMargin;
    NSInteger photoesViewHeight = row*ZCStatusPhotoImageWH+(row-1)*ZCStatusCellMargin;
    return CGSizeMake(photoesViewWidth, photoesViewHeight);
}


@end
