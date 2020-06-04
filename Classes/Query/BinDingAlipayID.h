//
//  BinDingAlipayID.h
//  Fahuobao
//
//  Created by 智发 on 14-8-13.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitView.h"
@interface BinDingAlipayID : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *AliPayIDText;
    NSString *useID;
    WaitView *wait;
}
- (IBAction)doOk:(UIButton *)sender;
@end
