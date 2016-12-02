//
//  ZCAFHttpsRequest.m
//  SinaWebo
//
//  Created by mac on 2016/11/21.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCAFHttpsRequest.h"
#import "ZCUploadImageParam.h"
@interface ZCAFHttpsRequest()<NSCopying>
@end
@implementation ZCAFHttpsRequest
static ZCAFHttpsRequest *_requestManger;
+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _requestManger = [[self alloc]init];
    });
    return _requestManger;
}

- (void)GetRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(task,dic);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}

- (void)PostRequestWithUrl:(NSString *)url parameters:(id)parameters success:(successBlock)success failure:(fairureBlock)failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(task,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}

- (void)PostRequestWithUrl:(NSString *)url parameters:(id)parameters constructingBody:(ZCUploadImageParam *)uploadImageParam success:(successBlock)success failure:(fairureBlock)failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadImageParam.data name:uploadImageParam.name fileName:uploadImageParam.filename mimeType:uploadImageParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(task,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}


- (id)copyWithZone:(NSZone *)zone
{
    return _requestManger;
}

@end
