//
//  ZBarViewController.m
//  Fahuobao
//
//  Created by 智发 on 14-8-11.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "ZBarViewController.h"

@interface ZBarViewController ()

@end

@implementation ZBarViewController
@synthesize ordID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doPush)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
    wait = [[WaitView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
    wait.reloadLable.adjustsFontSizeToFitWidth = YES;
    wait.reloadLable.text = @"正在上传。。。";
    zBarView = [[ZBarReaderView alloc]init];
    zBarView.frame = CGRectMake(0, 0, backZBarView.frame.size.width,backZBarView.frame.size.height);
    zBarView.readerDelegate = self;
    //关闭闪光灯
    zBarView.torchMode = 0;
    //扫描区域
//    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(zBarView.frame) - 126, 200, 200);
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = zBarView;
    }
    //扫描区域计算
//    zBarView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:zBarView.bounds];
    [backZBarView addSubview:zBarView];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [zBarView start];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [zBarView stop];
}
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *sym in symbols)
    {
        
        if ([sym.data hasPrefix:@"http"])
        {
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"请扫描条形码！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }
        else
        {
            [zBarView stop];
            result.text = sym.data;
        }
        break;
    }
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
- (IBAction)doUpLoad:(UIButton *)sender
{
    if ([result.text hasPrefix:@"http"])
    {
        ;
    }
    else
    {
        [self.view addSubview:wait];
        [wait.activityView startAnimating];
        [NSThread detachNewThreadSelector:@selector(upData) toTarget:self withObject:nil];
    }
}
-(void)upData
{
    NSString *param = [NSString stringWithFormat:@"CouNum=%@&id=%@",result.text,ordID];
    NSString *resStr = [getZhiFaData DoUpLoadCourierNumber:param];
    [self performSelectorOnMainThread:@selector(returnString:) withObject:resStr waitUntilDone:YES];
}
-(void)returnString:(NSString *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    if ([temp isEqualToString:@"ok"])
    {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"上传成功!是否返回？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aler.tag = 101;
        [aler show];
    }
    else
    {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"上传失败!是否重新扫描？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        aler.tag = 102;
        [aler show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            ;
        }
        else if (buttonIndex==1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag == 102)
    {
        if (buttonIndex==0)
        {
            ;
        }
        else if (buttonIndex==1)
        {
            [zBarView start];
        }
    }
}
-(void)doPush
{
    [self.navigationController popViewControllerAnimated:YES];
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
