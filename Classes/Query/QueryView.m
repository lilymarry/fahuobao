//
//  QueryView.m
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "QueryView.h"

@interface QueryView ()

@end

@implementation QueryView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        NSLog(@"????");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPushNotification:) name:@"pushNotification" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doLeft)];
    [self.view addGestureRecognizer:left];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
-(void)doLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --获取推送消息--
-(void)getPushNotification:(NSNotification *)notification
{
    NSLog(@"jpush：   %@",notification);
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
