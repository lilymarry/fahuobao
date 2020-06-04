//
//  CheckPrice.h
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitView.h"
@interface CheckPrice : UIViewController<UIWebViewDelegate>
{
    NSURLRequest *request;
    IBOutlet UIWebView *webView;
    WaitView *wait;
}
@end
