//
//  ZCPhotoImageView.m
//  SinaWebo
//
//  Created by mac on 2016/11/28.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCPhotoImageView.h"
#import "ZCPhoto.h"
@interface ZCPhotoImageView()
@property (nonatomic,weak)UIImageView *gifImageView;
@end
@implementation ZCPhotoImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill; // 填充
        self.clipsToBounds = YES; //裁剪
    }
    return self;
}

- (UIImageView *)gifImageView
{
    if (!_gifImageView) {
        UIImageView *gif = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gif];
        self.gifImageView = gif;
    }
    return _gifImageView;
}

- (void)setPhoto:(ZCPhoto *)photo
{
    NSString *thumbnail_pic = photo.thumbnail_pic;
    [self sd_setImageWithURL:[NSURL URLWithString:thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.gifImageView.hidden = ![thumbnail_pic.lowercaseString hasSuffix:@"gif"]; // 防止是大写
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifImageView.x = self.width-self.gifImageView.width;
    self.gifImageView.y = self.height-self.gifImageView.height;
}
@end
