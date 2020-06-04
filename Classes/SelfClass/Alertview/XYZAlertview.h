//
//  XYZAlertview.h
//  xilaikd
//
//  Created by 智发 on 14-7-16.
//  Copyright (c) 2014年 zhifa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiFaApi.h"
@protocol okButtonDelegate <NSObject>
-(void)doButton:(id)sender;
@end

@interface XYZAlertview : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGRect alertViewRect;
    BOOL _leftLeave;
}
@property (nonatomic , assign)id okDelegate;
@property (nonatomic , strong)UITextField *phoneNumber;
@property (nonatomic , strong)UITextField *Address;
@property (nonatomic , strong)UIButton *okButton;
@property (nonatomic , strong)UIButton *cancelButton;
@property (nonatomic , strong)UIButton *button1;
@property (nonatomic , strong)UIButton *button2;
@property (nonatomic , strong)UIButton *button3;
@property (nonatomic , strong)UIButton *button4;
//@property (nonatomic , strong)NSString *dateString;
@property (nonatomic, strong) UIView *backImageView;

@property(nonatomic,strong)UIButton *companyBtn;

@property(nonatomic,strong)UILabel *companylabel;

@property(nonatomic ,strong)UITableView *companyTableView;
@property(nonatomic,strong)NSArray *companyArr;
-(void)Hidden;
-(void)show;
-(BOOL)validateMobile:(NSString* )mobileNumber;
@end
