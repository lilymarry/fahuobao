//
//  BinDingAlipayID.m
//  Fahuobao
//
//  Created by 智发 on 14-8-13.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "BinDingAlipayID.h"
#import "ZhiFaApi.h"
@interface BinDingAlipayID ()

@end

@implementation BinDingAlipayID

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)getUserID
{
//    [[NSUserDefaults standardUserDefaults] setValue:@"15991991802" forKey:@"userTel"];
    useID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userTel"];
//    NSLog(@"%@",useID);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUserID];
    UISwipeGestureRecognizer *rigth = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [rigth setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rigth];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap)];
    [self.view addGestureRecognizer:tap];
}
-(void)doTap
{
    [AliPayIDText resignFirstResponder];
}
-(void)doRight
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)doOk:(UIButton *)sender
{
    [AliPayIDText resignFirstResponder];
    if (AliPayIDText.text.length==0)
    {
        UIAlertView *temp = [[UIAlertView alloc]initWithTitle:@"温馨提示!" message:@"请输入账号！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [temp show];
    }
    else
    {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示!" message:@"您确定要将该账号设置为活动返利账号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
//        用户确定绑定账号
        [self.view addSubview:wait];
        [wait.activityView startAnimating];
        [NSThread detachNewThreadSelector:@selector(startBinding) toTarget:self withObject:nil];
    }
}
-(void)startBinding
{
    NSString *param = [NSString stringWithFormat:@"zhanghao=%@&phone=%@",AliPayIDText.text,useID];
    NSString *str = [getZhiFaData BinDingAliPayID:param];
    [self performSelectorOnMainThread:@selector(returnBinDing:) withObject:str waitUntilDone:YES];
}
-(void)returnBinDing:(NSString *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    if ([temp isEqualToString:@"ok"])
    {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"绑定成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
    }
    else
    {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"绑定失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
