//
//  CheckPrice.m
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "CheckPrice.h"

@interface CheckPrice ()

@end

@implementation CheckPrice

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://115.28.78.87:8080/kdb_server/price.html"]];
    wait = [[WaitView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
    wait.reloadLable.adjustsFontSizeToFitWidth = YES;
    wait.reloadLable.text = @"正在加载。。。";
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
}
-(void)doRight
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.view addSubview:wait];
    [wait.activityView startAnimating];
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"完成");
    self.navigationController.navigationBarHidden = NO;
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    NSLog(@"失败");
    self.navigationController.navigationBarHidden = NO;
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:[error localizedDescription] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
