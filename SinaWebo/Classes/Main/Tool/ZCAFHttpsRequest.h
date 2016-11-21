//
//  ZCAFHttpsRequest.h
//  SinaWebo
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successBlock)(NSURLSessionDataTask *task,id responseObject);
typedef void (^fairureBlock)(NSURLSessionDataTask *task,NSError *error);
@interface ZCAFHttpsRequest : NSObject

+ (instancetype)share;

- (void)GetRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure;

- (void)PostRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure;

@property (nonatomic,copy) successBlock success;
@property (nonatomic,copy) fairureBlock failure;

@end
