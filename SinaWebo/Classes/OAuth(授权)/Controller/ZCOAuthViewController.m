//
//  ZCOAuthViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/18.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCOAuthViewController.h"
@interface ZCOAuthViewController ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *webView;
@end

@implementation ZCOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWebView];
}

- (void)initWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1988294129&redirect_uri=http://www.baidu.com"]]];
    webView.delegate = self;
    self.webView = webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange codeRange = [url rangeOfString:@"code="];
    if (codeRange.length) {
        NSString *code = [url substringFromIndex:codeRange.length+codeRange.location];
        [self accessTokenWithCode:code];
        return NO;
    }

    return YES;
}


/**
 "access_token" = "2.00fm6CsCJIgYKC9af6fa4c98KA1ZCD";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
  uid = 2630763581;

 */
- (void)accessTokenWithCode:(NSString *)code
{
    ZCUserAccount *user = [ZCUtility readUserAccount];
    if (user) {
        [ZCLastWindow chooseRootViewController];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1988294129";
    params[@"client_secret"] = @"263a43f9b7511a222bfbfdfd2bdfdc82";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    [AFHTTPResponseSerializer serializer];
    [[AFHTTPSessionManager manager]POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZCLog(@"%@",responseObject);
        [MBProgressHUD hideHUDForView:ZCLastWindow];
        ZCUserAccount *user = [ZCUserAccount userAccountWithDictionary:responseObject];
        // 存储user
        [ZCUtility saveUserAccount:user];
        // 切换窗口的根控制器
        [ZCLastWindow chooseRootViewController];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      //  [MBProgressHUD hideHUDForView:ZCLastWindow];
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",error);
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    ZCLogFunc;
    [MBProgressHUD showMessage:@"正在加载"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    ZCLogFunc;
   // [MBProgressHUD hideHUDForView:ZCLastWindow];
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    ZCLogFunc;
   // [MBProgressHUD hideHUDForView:ZCLastWindow];
    [MBProgressHUD hideHUD];
}

- (void)dealloc
{
    ZCLogFunc;
}
@end
