//
//  AppDelegate.h
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOpenSDK.h>
#import "BMapKit.h"
#import "WeiboSDK.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,WeiboSDKDelegate,WXApiDelegate>
{
    BMKMapManager * _mapManager;
    NSString* wbtoken;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;

@end
