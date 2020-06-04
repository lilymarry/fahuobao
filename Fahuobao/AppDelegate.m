//
//  AppDelegate.m
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "MapViewController.h"
#import "PartnerConfig.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
@implementation AppDelegate
@synthesize wbtoken;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:kAppKey];
    [WXApi registerApp:kAppIDWX withDescription:@"发货宝"];
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    /*
       注册极光推送的通知
     */
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];//建立连接
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];//// 关闭连接
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];// // 注册成功
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];// // 登录成功
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];// // 收到消息(非APNS)
    
    // 必须调用的    // 注册APNS类型
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    // 初始化
    [APService setupWithOption:launchOptions];
    
    [APService setTags:nil alias:[APService registrionID] callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];

    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification!=nil)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotification" object:remoteNotification];
    }
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"MMC515xk6wgFr8OkAi0Y3f3t" generalDelegate:self];
    if (!ret)
    {
                NSLog(@"启动成功!");
    }
    
    return YES;

}
-(void)onGetNetworkState:(int)iError
{
    if (iError == 0)
    {
        NSLog(@"网络连接正常");
    }
    else
    {
        NSLog(@"网络错误:%d",iError);
    }
}
-(void)onGetPermissionState:(int)iError
{
    if (iError == 0)
    {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"授权失败:%d",iError);
    }
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error
{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
    NSLog(@"程序外通知！");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotification" object:userInfo];
}
//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
//    程序内通知！
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
    NSLog(@"程序内通知！");
    application.applicationIconBadgeNumber = 0;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNotification" object:userInfo];
}
#endif

#pragma mark -极光推送通知

- (void)networkDidSetup:(NSNotification *)notification
{
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification
{
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification
{
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification
{
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSLog(@"%@",[notification userInfo]);
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    //    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    //    NSLog(@"注册貌似");
}


//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"发货宝: %@",url);
    NSString *string = [NSString stringWithFormat:@"%@",url];
    if ([string hasPrefix:@"Fahuobao:"])
    {
        
        [self parse:url application:application];
    }
    if ([string hasPrefix:@"tencent1101517247:"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    if ([string hasPrefix:@"wx83424c6fad157a71:"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
	return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application
{
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
          //  NSLog(@"App");
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                
                //验证签名成功，交易结果无篡改
            
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"sccuess" object:[NSString stringWithFormat:@"%d", result.statusCode]];
                
            }
            
        }
        
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url
{
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"- (AlixPayResult *)resultFromURL:(NSURL *)url");
    
	return [[AlixPayResult alloc] initWithString:query];
    
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url
{
    NSLog(@"- (AlixPayResult *)handleOpenURL:(NSURL *)url");
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0)
    {
		result = [self resultFromURL:url];
	}
    
	return result;
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
//    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
//        NSString *title = @"发送结果";
//        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
        if (response.statusCode==0)
        {
            UIAlertView *temp = [[UIAlertView alloc]initWithTitle:@"发送结果" message:@"分享成功,是否上传结果？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [temp show];
        }
        else
        {
            UIAlertView *temp = [[UIAlertView alloc]initWithTitle:@"发送结果" message:@"分享失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [temp show];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"u    r    l : %@",url);
    NSString *string = [NSString stringWithFormat:@"%@",url];
    if ([string hasPrefix:@"wb1371936618:"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    if ([string hasPrefix:@"tencent1101517247:"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    if ([string hasPrefix:@"wx83424c6fad157a71:"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return  YES;
}
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode==0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享结果" message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享结果" message:@"分享失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
        
    }
}
@end
