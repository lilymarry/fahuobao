//
//  ZBarViewController.h
//  Fahuobao
//
//  Created by 智发 on 14-8-11.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ZhiFaApi.h"
#import "WaitView.h"
@interface ZBarViewController : UIViewController<ZBarReaderViewDelegate,UIAlertViewDelegate>
{
    WaitView *wait;
    ZBarReaderView *zBarView;
    IBOutlet UILabel *result;
    IBOutlet UIView *backZBarView;
}
@property (nonatomic , strong) NSString *ordID;
- (IBAction)doUpLoad:(UIButton *)sender;
@end
