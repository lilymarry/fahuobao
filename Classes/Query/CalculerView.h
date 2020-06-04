//
//  CalculerView.h
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiFaApi.h"
#import "AlixLibService.h"

@interface CalculerView : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITextView *textView;
    
    UIView *mainview;
    
    IBOutlet UIButton *changButton;
    IBOutlet UITextField *wideText;
    IBOutlet UITextField *priceText;
    
    UILabel *cityLabel;
    IBOutlet UIButton *calcul1;
    IBOutlet UILabel *results1;
    
    IBOutlet UITextField *longText;
    IBOutlet UITextField *weightText;
    IBOutlet UITextField *heightText;
    
    IBOutlet UIButton *calcul2;
    IBOutlet UILabel *results2;
    
    
    IBOutlet UIView *dataview;
    IBOutlet UITableView *tableView1;
}
- (IBAction)doChang:(id)sender;
- (IBAction)doButton1:(UIButton *)sender;
- (IBAction)doButton2:(UIButton *)sender;
- (IBAction)jieSuan:(UIButton *)sender;

@property(nonatomic,strong)NSString *ordStr;
@property(assign,nonatomic)double result2;
@property(assign,nonatomic)double result1;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSArray* allCity;
@property(nonatomic,strong)NSArray *num;


@property (nonatomic,assign) SEL result;
-(void)paymentResult:(NSString *)result;




@property(strong,nonatomic)NSString *tradeNo;

//@property(strong,nonatomic)NSString *money;
@property(strong,nonatomic)NSString *userTel;
@property(strong ,nonatomic)NSString *ID;


@end
