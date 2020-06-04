//
//  XYZAlertview.m
//  xilaikd
//
//  Created by 智发 on 14-7-16.
//  Copyright (c) 2014年 zhifa. All rights reserved.
//

#import "XYZAlertview.h"
#define NUMBERS @"0123456789"
#define kAlertWidth 245.0f
#define kAlertHeight 160.0f

@implementation XYZAlertview
@synthesize okDelegate;
@synthesize phoneNumber,Address;
@synthesize okButton,cancelButton;
@synthesize button1,button2,button3,button4;
@synthesize companyTableView,companyBtn,companylabel,companyArr;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        alertViewRect = frame;
        UIImageView *imagebg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imagebg.image = [UIImage imageNamed:@"alertView3"];
        [self addSubview:imagebg];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardwillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 44.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"请输入你的联系方式！";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18.0];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(2.0f, 72.0f, 145.0f, 32.0f)];
        phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        [phoneNumber setBackgroundColor:[UIColor redColor]];
        
        phoneNumber.tag = 10010;
        phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        phoneNumber.placeholder = @"电话号码";
        phoneNumber.adjustsFontSizeToFitWidth = YES;
        phoneNumber.delegate = self;
        phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:phoneNumber];
        
        
        Address = [[UITextField alloc]initWithFrame:CGRectMake(2.0f, 115.0f, 300.0f, 32.0f)];
        Address.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        Address.keyboardType = UIKeyboardTypeNamePhonePad;
        Address.placeholder = @"地址";
        Address.delegate = self;
        Address.adjustsFontSizeToFitWidth = YES;
        Address.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [Address setBackgroundColor:[UIColor grayColor]];
        [Address setEnabled:NO];
        [self addSubview:Address];
        
        
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(5, 158, 140, 39);
        [button1 setTitle:@"现金支付" forState:UIControlStateNormal];
//        [button1 setBackgroundColor:[UIColor grayColor]];
        [button1 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        button1.selected = YES;
        [button1 addTarget:self action:@selector(cheakButton1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(152, 158, 140, 39);
        [button2 setTitle:@"网上支付" forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [button2 setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(cheakButton2:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(5, 205, 140, 39);
        [button3 setTitle:@"平台价格" forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [button3 setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        button3.selected = YES;
        [button3 addTarget:self action:@selector(cheakButton3:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        
        button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        button4.frame = CGRectMake(152, 205, 140, 39);
        [button4 setTitle:@"协商价格" forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [button4 setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(cheakButton4:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button4];
        
        
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0.0f, 258.0f, 140.0f, 34.0f);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        okButton.frame = CGRectMake(156.0f, 258.0f, 140.0f, 34.0f);
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [okButton setBackgroundColor:[UIColor clearColor]];
        [okButton addTarget:self action:@selector(OkButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:okButton];
        
        
        
      
        
        companylabel =[[UILabel alloc]initWithFrame:CGRectMake(2.0f, 0.0f, 128.0f, 41.0f)];
        companylabel.text=@"全部快递";
        [companylabel setBackgroundColor:[UIColor clearColor]];
       
        
        
        companyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        companyBtn.frame = CGRectMake(143.0f, 62.0f, 157.0f, 46.0f);
      //  [companyBtn setBackgroundImage:[UIImage imageNamed:@"Company"]  forState:UIControlStateNormal];
    
        [companyBtn setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:1.0 alpha:1] forState:UIControlStateNormal];
        [companyBtn setBackgroundColor:[UIColor clearColor]];
        [companyBtn addTarget:self action:@selector(setlectCompanyBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [companyBtn addSubview:companylabel];
        [self addSubview:companyBtn];
        
        companyTableView=[[UITableView alloc]initWithFrame:CGRectMake(147, 103, 150, 186)];
        companyTableView.delegate=self;
        companyTableView.dataSource=self;
        [self addSubview:companyTableView];
        
        companyTableView.hidden=YES;
        companyArr=[NSArray arrayWithObjects:@"所有快递",@"喜来快递",@"汇通快递",@"申通快递",@"圆通快递",@"中通快递",@"顺丰快递",@"韵达快递", nil];
        
    
        
        
        
    }
    return self;
}
-(void)setlectCompanyBtnPress:(id)sender
{
    [phoneNumber resignFirstResponder];
    [Address resignFirstResponder ];
    if (companyTableView.hidden)
    {
         companyTableView.hidden=NO;
    }
    else
        
    {
    
       companyTableView.hidden=YES;
    }
  
   
    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *flag=@"fl";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:flag] ;
        }
    
        //获取选中行的值
        int selectedRow = (int)[indexPath row];
        //设置cell的文本
        cell.textLabel.text = [companyArr
                               objectAtIndex:selectedRow];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
        return cell;


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [companyArr count];


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     companylabel.text=[companyArr  objectAtIndex:indexPath.row];
      companylabel.textColor=[UIColor blackColor];
    companyTableView.hidden=YES;
}

-(void)cheakButton1:(UIButton *)sender
{
    if (sender.selected==NO)
    {
        sender.selected = YES;
        button2.selected = NO;
    }
    else
    {
        if (button2.selected!=NO)
        {
            sender.selected = NO;
        }
    }
}
-(void)cheakButton2:(UIButton *)sender
{
    if (sender.selected==NO)
    {
        sender.selected = YES;
        button1.selected = NO;
    }
    else
    {
        if (button1.selected!=NO)
        {
             sender.selected = NO;
        }
    }
}
-(void)cheakButton3:(UIButton *)sender
{
    if (sender.selected==NO)
    {
        sender.selected = YES;
        button4.selected = NO;
    }
    else
    {
        if(button4.selected!=NO)
        {
            sender.selected = NO;
        }
    }
}
-(void)cheakButton4:(UIButton *)sender
{
    if (sender.selected==NO)
    {
        sender.selected = YES;
        button3.selected = NO;
    }
    else
    {
        if (button3.selected!=NO)
        {
            sender.selected = NO;
        }
    }
}
#pragma mark 取消按钮
-(void)cancelButton:(id)sender
{
    [phoneNumber resignFirstResponder];
    [Address resignFirstResponder];
    [self Hidden];
    //    send.userInteractionEnabled = YES;
}
#pragma mark 确定按钮
-(void)OkButton:(id)sender
{
    if (self.okDelegate !=nil && [self.okDelegate respondsToSelector:@selector(doButton:)])
    {
        [self.okDelegate doButton:sender];
    }
}
#pragma mark 验证电话号码
-(BOOL)validateMobile:(NSString* )mobileNumber
{
    NSString *mobileStr = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
    NSPredicate *cateMobileStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileStr];
    
    if ([cateMobileStr evaluateWithObject:mobileNumber]==YES)
    {
        return YES;
    }
    return NO;
}
#pragma mark --获取根视图--
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
#pragma mark 弹出框Show
-(void)show
{
//    [temp addSubview:self];
    UIViewController *RootVC = [self appRootViewController];
    
    [RootVC.view addSubview:self];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}
#pragma mark 弹出框Hidden
-(void)Hidden
{
    [self removeFromSuperview1];
//    [self.backImageView removeFromSuperview];
//    self.backImageView = nil;
//    [super removeFromSuperview];
//    UIViewController *topVC = [self appRootViewController];
//    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
//    
//    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.frame = afterFrame;
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        }else {
//            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
//    } completion:^(BOOL finished) {
//        [super removeFromSuperview];
//    }];
}
- (void)removeFromSuperview1
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        if (_leftLeave) {
            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        }else {
            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        }
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - alertViewRect.size.width) * 0.5, (CGRectGetHeight(topVC.view.bounds) - alertViewRect.size.height) * 0.5, alertViewRect.size.width, alertViewRect.size.height);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}
#pragma mark 移除弹出框
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self removeFromSuperview];
    self.hidden = NO;
}
#pragma mark --键盘将要出现--
-(void)KeyBoardwillShowNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval animationDuration = 0.5f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.frame = CGRectMake(alertViewRect.origin.x,rect.size.height-kbSize.height-alertViewRect.size.height-10,alertViewRect.size.width,alertViewRect.size.height);
    [UIView commitAnimations];
}
#pragma mark 键盘事件
-(void)KeyBoardWillHidden:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.0f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame=alertViewRect;
    [UIView commitAnimations];
}
//-------------华丽丽的分离线-------------
#pragma mark 输入时调用
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 10010)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest)
        {
            return NO;
        }
        return YES;
    }
    return YES;
}
#pragma mark --开始编辑--
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    companyTableView.hidden=YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    NSLog(@"DidBegin");
}
#pragma mark --编辑结束--
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"DidEnd");
}
#pragma mark --点击返回--
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
