//
//  ZCComposePhotoView.h
//  SinaWebo
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCComposePhotoView : UIView
@property (nonatomic,strong,readonly)NSArray *photoArr;

- (void)addImagePhoto:(UIImage *)photo;

@end
