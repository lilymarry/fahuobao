//
//  QQShareView.m
//  Fahuobao
//
//  Created by 智发 on 14-8-28.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "QQShareView.h"

@interface QQShareView ()

@end

@implementation QQShareView

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
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:kAppIDQQ andDelegate:self];
    tencentOAuth.redirectURI = @"www.fahuob.com";
    permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doShare:(UIButton *)sender
{
    [tencentOAuth authorize:permissions];    
}

- (IBAction)doQzone:(id)sender
{
    
    
//    新闻分享:
    //分享跳转URL
    NSString *url = @"http://www.fahuob.com";
    //分享图预览图URL地址
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ico" ofType:@"png"]];
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:@"分享软件" description:@"这是一款很不错的软件哦！" previewImageData:imageData];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    NSLog(@"%d",code);
}
#pragma mark 登录完成
- (void)tencentDidLogin
{
    NSLog(@"登录完成");
    
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
//        _labelAccessToken.text = tencentOAuth.accessToken;
        NSLog(@"tencentOAuth.accessToken = :%@",tencentOAuth.accessToken);
    }
    else
    {
//        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}
#pragma mark
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        NSLog(@"用户取消登录");
	}
	else
    {
        NSLog(@"登录失败");
	}
} 
#pragma mark网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
	NSLog(@"无网络连接，请设置网络");
}

@end
