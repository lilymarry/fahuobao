//
//  JiFenGuizViewController.m
//  Fahuobao
//
//  Created by 智发 on 14-8-27.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "JiFenGuizViewController.h"

@interface JiFenGuizViewController ()

@end

@implementation JiFenGuizViewController

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
    UISwipeGestureRecognizer *rigth = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [rigth setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rigth];
}

-(void)doRight
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
