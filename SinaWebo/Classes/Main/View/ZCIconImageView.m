//
//  ZCIconImageView.m
//  SinaWebo
//
//  Created by mac on 2016/11/29.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCIconImageView.h"
#import "ZCUser.h"

@interface ZCIconImageView()
@property (nonatomic,weak)UIImageView *verifieView;  // 认证view
@end

@implementation ZCIconImageView

- (UIImageView *)verifieView
{
    if (!_verifieView) {
       UIImageView *verifieView = [[UIImageView alloc]init];
        [self addSubview:verifieView];
        _verifieView = verifieView;
    }
    return _verifieView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)setUser:(ZCUser *)user
{
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    switch (user.verified_type) {
        case ZCUserVerifiedPersonal:
            self.verifieView.hidden = NO;
            self.verifieView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case ZCUserVerifiedOrgMedia:
        case ZCUserVerifiedOrgEnterprice:
        case ZCUserVerifiedOrgWebsite:
            self.verifieView.hidden = NO;
            self.verifieView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case ZCUserVerifiedDaren:
            self.verifieView.hidden = NO;
            self.verifieView.image = [UIImage imageNamed:@"avatar_grassroot"];

        default:
            self.verifieView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews
{
    self.verifieView.size = self.verifieView.image.size;
    CGFloat scale = 0.6;
    self.verifieView.x = self.width-scale*self.verifieView.width;
    self.verifieView.y = self.height-scale*self.verifieView.height;
}

@end
