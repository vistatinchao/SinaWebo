//
//  ZCAFHttpsRequest.h
//  SinaWebo
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUploadImageParam;
typedef void (^successBlock)(NSURLSessionDataTask *task,id responseObject);
typedef void (^fairureBlock)(NSURLSessionDataTask *task,NSError *error);
//typedef void (^constructBlock)(ZCUploadImageParam *formData);
@interface ZCAFHttpsRequest : NSObject

+ (instancetype)share;

- (void)GetRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure;

- (void)PostRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure;

- (void)PostRequestWithUrl:(NSString *)url parameters:(id)parameters constructingBody:(ZCUploadImageParam *)uploadImageParam success:(successBlock)success failure:(fairureBlock)failure;

//manger POST:<#(nonnull NSString *)#> parameters:<#(nullable id)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData>  _Nonnull formData)block#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>

@end
