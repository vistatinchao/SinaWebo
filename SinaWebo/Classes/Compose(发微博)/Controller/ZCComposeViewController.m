//
//  ZCComposeViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCComposeViewController.h"
#import "ZCTextView.h"
@interface ZCComposeViewController ()<UITextViewDelegate>
@property (nonatomic,weak)ZCTextView *textView;
@end

@implementation ZCComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setTextView];
}

- (void)setTextView
{
    ZCTextView *textView = [[ZCTextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    [textView becomeFirstResponder];
    textView.font = [UIFont systemFontOfSize:20];
    textView.placeholder = @"分享些新鲜事吧...";
    textView.placeholderColor = [UIColor redColor];
    textView.delegate = self;
    self.textView = textView;
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    ZCUserAccount *user = [ZCUtility readUserAccount];
    NSString *subTitle = @"发微博";
    NSString *name = user.name;
    if (name.length) {
        UILabel *label = [[UILabel alloc]init];
        label.size = CGSizeMake(150, 44);
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%@\n%@",subTitle,name];

        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:label.text];
        NSRange subRange = [label.text rangeOfString:subTitle];
        NSMutableDictionary *subTitleDict = [NSMutableDictionary dictionary];
        subTitleDict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
        [attrString addAttributes:subTitleDict range:subRange];

        NSRange nameRange = [label.text rangeOfString:name];
        NSMutableDictionary *nameTitleDict = [NSMutableDictionary dictionary];
        nameTitleDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        [attrString addAttributes:nameTitleDict range:nameRange];
        label.attributedText = attrString;
        self.navigationItem.titleView = label;
    }else{
        self.navigationItem.title = subTitle;
    }
}

- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZCUtility readUserAccount].access_token;
    params[@"status"] = self.textView.text;
    [[ZCAFHttpsRequest share] PostRequestWithUrl:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [MBProgressHUD showSuccess:@"发送失败"];
    }];
    [self cancel];
}
#pragma mark textView delegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.textView resignFirstResponder];
//}

@end
