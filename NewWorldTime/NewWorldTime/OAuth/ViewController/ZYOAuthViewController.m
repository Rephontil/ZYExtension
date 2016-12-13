//
//  ZYOAuthViewController.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/27.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//  OAuth的授权控制器

#import "ZYOAuthViewController.h"
#import "MBProgressHUD+ZY.h"
#import <AFNetworking.h>
#import "ZYAccount.h"
#import "ZYAccountTool.h"

#define BASEURL             @"https://api.weibo.com/oauth2/authorize"

#define Client_id           @"2389394849"

#define Redirect_uri        @"http://www.baidu.com"

#define AppSecret           @"03729d16a4cd277c7da26398f7a01282"



@interface ZYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation ZYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    授权登录的界面由网页来展现出来

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    webView.delegate = self;

    NSString *stringURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",BASEURL,Client_id,Redirect_uri];

    NSURL *url = [NSURL URLWithString:stringURL];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


#pragma mark  ---> UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    ZYLog(@"%@ %ld",request.URL.absoluteString,(long)navigationType);
    NSString *urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length) {
        NSString *codeString = [urlString substringFromIndex:range.length + range.location];
        ZYLog(@"%@",codeString);

        [self accessTokenWithCode:codeString];
        return NO;

    }

    return YES;

}


/**
 获取accessToken

 @param code accessToken
 */
- (void)accessTokenWithCode:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    paraDic[@"client_id"] = Client_id;
    paraDic[@"client_secret"] = AppSecret;
    paraDic[@"code"] = code;
    paraDic[@"grant_type"] = @"authorization_code";
    paraDic[@"redirect_uri"] = Redirect_uri;

    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:paraDic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        ZYLog(@"%@",responseObject);
//        获取accessToken成功后，要将获取到的数据存储起来,因为每次用户授权获取到accessToken都是一样的
//        字典转模型
        ZYAccount *account = [ZYAccount accountWithDic:responseObject];

//        保存模型对象,归档的模型需要遵循NSCoding协议
        [ZYAccountTool saveAccount:account];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZYLog(@"%@",error);

    }];

}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];

}


@end
