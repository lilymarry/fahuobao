//
//  SendExpress.h
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryView.h"
#import "ZhiFaApi.h"
#import "WaitView.h"
#import "QueryView.h"
#import "XYZError.h"
#import "ZBarViewController.h"
@interface SendExpress : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    QueryView *querView;
    NSMutableArray *dataArray;
    NSString *_id;//存放所要删除用户的id
    NSString *telString;
    int   _index;
    UIImagePickerController *picker;
    NSThread *getData;
    WaitView *wait;
    BOOL isFinish;
    QueryView *query1;
    XYZError *errorAler;
    IBOutlet UITableView *detaileView;
    NSString *orderID;
    NSString *jifen;
    
}
@property (nonatomic , strong) NSString *userID;
@property BOOL isPush;
@end
