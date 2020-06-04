//
//  ExpressView.h
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiFaApi.h"
#import "WaitView.h"
@interface ExpressView : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITextField *numCardTextFeild;
    IBOutlet UIButton *changButton;
    
    IBOutlet UITextView *textView;
    UILabel *kuaidiLabel;
    
    
    IBOutlet UIButton *searchBar;
    
    
    IBOutlet UIView *cityView;
    
    IBOutlet UITableView *tableView1;
    
    NSMutableData *tempData;
    NSMutableString *resultString;
    NSMutableDictionary *tempDict ;
    
    NSMutableDictionary *tDict ;
    NSMutableString *tempStr;
    NSDictionary *data1;
    NSDictionary *dic;
    
    WaitView *wait;
}
- (IBAction)doback:(id)sender;
- (IBAction)doSearch:(id)sender;
- (IBAction)changStyle:(id)sender;

@end
