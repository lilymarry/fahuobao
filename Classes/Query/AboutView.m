//
//  AboutView.m
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "AboutView.h"

@interface AboutView ()

@end

@implementation AboutView

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
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [appInfo objectForKey:@"CFBundleVersion"];
    NSLog(@"%@",app_build);
    bundleID.text = [NSString stringWithFormat:@"当前版本:%@",app_build];
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
    sheet = [[UIActionSheet alloc]initWithTitle:@"分享此软件" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"新浪微博" otherButtonTitles:@"QQ空间",@"QQ好友",@"微信朋友圈",@"微信好友", nil];
    [sheet setActionSheetStyle:UIActionSheetStyleDefault];
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:kAppIDQQ andDelegate:nil];
    tencentOAuth.redirectURI = @"www.fahuob.com";
    permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    WXReq = [[SendMessageToWXReq alloc] init];
}
-(void)doRight
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doEmail:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",sender.currentTitle]]];
}
- (IBAction)doShare:(UIButton *)sender
{
    [sheet showInView:self.view];
}
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"分享该软件(发货宝)亲们！么哒哒！很不错的软件哦！:http://wap.eoemarket.com/apps/show/id/349099";
    
    return message;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%d",buttonIndex);
    if (buttonIndex==0)
    {
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        request.userInfo = @{@"ShareMessageFrom": @"WeiboShareView"};
        
        [WeiboSDK sendRequest:request];
//        [self performSegueWithIdentifier:@"pushWeibo" sender:nil];
    }
    if (buttonIndex==1)
    {
        //    新闻分享:
        //分享跳转URL
        NSString *url = @"http://wap.eoemarket.com/apps/show/id/349099";
        //分享图预览图URL地址
        NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ico" ofType:@"png"]];
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:@"分享软件" description:@"这是一款很不错的软件哦！" previewImageData:imageData];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req];
        NSLog(@"%d",code);
//        [self performSegueWithIdentifier:@"pushQQ" sender:nil];
    }
    if (buttonIndex==2)
    {
//        [self performSegueWithIdentifier:@"pushQQ" sender:nil];
        QQApiTextObject *txtObj = [QQApiTextObject objectWithText:@"分享该软件:http://wap.eoemarket.com/apps/show/id/349099"];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
        QQApiSendResultCode code = [QQApiInterface sendReq:req];
        NSLog(@"%d",code);
    }
    if (buttonIndex==3)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"分享软件（发货宝）亲们！么哒哒！很不错的软件哦！";
        [message setThumbImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ico" ofType:@"png"]]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://wap.eoemarket.com/apps/show/id/349099";
        
        message.mediaObject = ext;
        WXReq.message = message;
        WXReq.bText = NO;
        WXReq.scene = WXSceneTimeline;
        [WXApi sendReq:WXReq];
    }
    if (buttonIndex==4)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"分享软件（发货宝）";
        message.description = @"亲们！么哒哒！很不错的软件哦！";
        [message setThumbImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ico" ofType:@"png"]]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://wap.eoemarket.com/apps/show/id/349099";
        
        message.mediaObject = ext;
    
        WXReq.message = message;
        WXReq.bText = NO;
        WXReq.scene = WXSceneSession;
        [WXApi sendReq:WXReq];
    }
}
- (IBAction)callTel:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",sender.currentTitle]]];
}

- (IBAction)openUrl:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",sender.currentTitle]]];
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


@end
