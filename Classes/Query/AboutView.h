//
//  AboutView.h
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOpenSDK.h>
#import "WXApi.h"
@interface AboutView : UIViewController<UIActionSheetDelegate,WXApiDelegate>
{
    IBOutlet UILabel *bundleID;
    UIActionSheet *sheet;
    TencentOAuth *tencentOAuth;
    NSArray *permissions;
    SendMessageToWXReq* WXReq;
}
- (IBAction)doShare:(UIButton *)sender;

- (IBAction)callTel:(UIButton *)sender;
- (IBAction)openUrl:(UIButton *)sender;
@end
