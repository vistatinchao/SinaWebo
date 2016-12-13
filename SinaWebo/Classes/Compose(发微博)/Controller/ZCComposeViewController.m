//
//  ZCComposeViewController.m
//  SinaWebo
//
//  Created by mac on 2016/11/30.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCComposeViewController.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "ZCEmotionTextView.h"
#import "ZCComposeToolbar.h"
#import "ZCComposePhotoView.h"
#import "ZCUploadImageParam.h"
#import "ZCEmotionKeyboard.h"
#import "ZCEmotion.h"

@interface ZCComposeViewController ()<UITextViewDelegate,ZCComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak)ZCEmotionTextView *textView;
@property (nonatomic,weak)ZCComposeToolbar *toolbar;
@property (nonatomic,weak)ZCComposePhotoView *photoView;
@property (nonatomic,strong)ZCEmotionKeyboard *emotionKeyboardView;

@end

@implementation ZCComposeViewController

#pragma mark 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setTextView];
    [self setComposeToolbar];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [ZCNotiCenter removeObserver:self];
}
#pragma mark 初始化子控件
#pragma mark ZCTextView
- (void)setTextView
{
    ZCEmotionTextView *textView = [[ZCEmotionTextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:20];
    textView.placeholder = @"分享些新鲜事吧...";
    textView.placeholderColor = [UIColor redColor];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    self.textView = textView;
}
#pragma mark ZCComposeToolbar
- (void)setComposeToolbar
{
    ZCComposeToolbar *toolbar = [ZCComposeToolbar toolbar];
    [self.view addSubview:toolbar];
    toolbar.height = 44;
    toolbar.frame = CGRectMake(0, ZCScreenH, ZCScreenW, toolbar.height);
    toolbar.delegate = self;
    self.toolbar = toolbar;
    // 监听键盘
    [ZCNotiCenter addObserver:self selector:@selector(changeToolbarFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
     // textView显示表情
    [ZCNotiCenter addObserver:self selector:@selector(showEmotion:) name:ZCNotificationDidShowEmotion object:nil];
}
#pragma mark 懒加载view
- (ZCComposePhotoView *)photoView
{
    if (!_photoView) {
        ZCComposePhotoView *photoView = [[ZCComposePhotoView alloc]init];
        [self.textView addSubview:photoView];
        CGFloat photoViewY = 150;
        CGFloat photoViewW = self.textView.width;
        CGFloat photoViewH = self.view.height;
        photoView.frame = CGRectMake(0, photoViewY, photoViewW, photoViewH);
        _photoView = photoView;
    }
    return _photoView;
}

- (ZCEmotionKeyboard *)emotionKeyboardView
{
    if (!_emotionKeyboardView) {
        _emotionKeyboardView = [[ZCEmotionKeyboard alloc]init];
        _emotionKeyboardView.size = CGSizeMake(ZCScreenW, ZCKeyboardHeight);
    }
    return _emotionKeyboardView;
}

#pragma mark 导航栏
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
#pragma mark 发微博

- (void)post
{
    if (self.photoView.photoArr.count) {  // 有图片
        [self sendWithImage];
    }else{ //没有图片
        [self sendWithoutImage];
    }

    [self cancel];
}

/**
 发送没有图片
 */
- (void)sendWithoutImage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZCUtility readUserAccount].access_token;
    params[@"status"] = self.textView.text;
    [[ZCAFHttpsRequest share]PostRequestWithUrl:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 发送有图片
 */
- (void)sendWithImage
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZCUtility readUserAccount].access_token;
    params[@"status"] = self.textView.text;
    UIImage *image = self.photoView.photoArr.lastObject;
    ZCUploadImageParam *imageParam = [[ZCUploadImageParam alloc]init];
    imageParam.data = UIImageJPEGRepresentation(image, 1.0);
    imageParam.name = @"pic";
    imageParam.filename = @"text.jpg";
    imageParam.mimeType = @"image/jpeg";
    [[ZCAFHttpsRequest share] PostRequestWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBody:imageParam success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showSuccess:@"发送失败"];
    }];

   
}

#pragma mark 监听键盘
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)changeToolbarFrame:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardRect = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度

        if (keyboardRect.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardRect.origin.y - self.toolbar.height;
        }
    }];

}

/**
 * 显示表情
 */

- (void)showEmotion:(NSNotification *)noti
{
    ZCEmotion *emotion = noti.userInfo[ZCKeyNotificationDidShowEmotion];
    [self.textView insertEmotion:emotion];
}
#pragma mark toolbar delegate
- (void)composeToolbar:(ZCComposeToolbar *)toolbar didClickBtnType:(ZCComposeToolbarBtnType)btnType
{
    switch (btnType) {
        case ZCComposeToolbarBtnCamera:
            [self openCamera];
            break;
        case ZCComposeToolbarBtnPicture:
            [self openPicture];
            break;
        case ZCComposeToolbarBtnMention:

            break;
        case ZCComposeToolbarBtnTrend:

            break;
        case ZCComposeToolbarBtnEmotion:
            [self switchKeyboard:toolbar];
            break;

        default:
            break;
    }
}

- (void)switchKeyboard:(ZCComposeToolbar *)toolbar
{
    toolbar.showEmotionKeyboard = !toolbar.showEmotionKeyboard;
    [self.textView resignFirstResponder];
    if (toolbar.showEmotionKeyboard) {// 切换表情键盘
        self.textView.inputView = self.emotionKeyboardView;
    }else{
        self.textView.inputView = nil;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });

    // self.textView.inputView == nil : 使用的是系统自带的键盘
//    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
//        self.textView.inputView = self.emotionKeyboardView;
//
//        // 显示键盘按钮
//        self.toolbar.showEmotionKeyboard = YES;
//    } else { // 切换为系统自带的键盘
//        self.textView.inputView = nil;
//
//        // 显示表情按钮
//        self.toolbar.showEmotionKeyboard = NO;
//    }
//
//    // 开始切换键盘
//    self.showEmotionKeyboard = YES;
//
//    // 退出键盘
//    [self.textView endEditing:YES];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 弹出键盘
//        [self.textView becomeFirstResponder];
//
//        // 结束切换键盘
//        self.showEmotionKeyboard = NO;
//    });

}

- (void)openCamera
{
    [self presentCameraOrPicture:UIImagePickerControllerSourceTypeCamera];
}

- (void)openPicture
{
    [self presentCameraOrPicture:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)presentCameraOrPicture:(UIImagePickerControllerSourceType)sourceType
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限 做一个友好的提示
        [UIAlertView alertWithShowMessage:@"请您设置允许APP访问您的相机\n设置>隐私>相机"];
        return ;
    } else {
        //调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickVC = [[UIImagePickerController alloc]init];
            imagePickVC.delegate = self;
            imagePickVC.allowsEditing = YES;
            imagePickVC.sourceType = sourceType;
            [self presentViewController:imagePickVC animated:YES completion:nil];
        }
    }

}

#pragma mark textView delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    [self.photoView addImagePhoto:image];
}

#pragma mark textView delegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

@end
