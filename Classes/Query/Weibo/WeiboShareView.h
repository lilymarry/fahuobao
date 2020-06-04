//
//  WeiboShareView.h
//  Fahuobao
//
//  Created by 智发 on 14-8-27.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface WeiboShareView : UIViewController<WBHttpRequestDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *LongIn;
@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)doLongIn:(UIBarButtonItem *)sender;
- (IBAction)doShare:(UIButton *)sender;
- (IBAction)LogOut:(UIButton *)sender;

@end
