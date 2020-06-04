//
//  QQShareView.h
//  Fahuobao
//
//  Created by 智发 on 14-8-28.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOpenSDK.h>
@interface QQShareView : UIViewController<TencentSessionDelegate>
{
    TencentOAuth *tencentOAuth;
    NSArray *permissions;
}
- (IBAction)doShare:(UIButton *)sender;
- (IBAction)doQzone:(id)sender;
@end
