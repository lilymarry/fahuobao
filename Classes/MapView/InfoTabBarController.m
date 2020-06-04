//
//  InfoTabBarController.m
//  Fahuobao
//
//  Created by 智发 on 14-9-17.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "InfoTabBarController.h"
//#import "SendExpress"
@interface InfoTabBarController ()

@end

@implementation InfoTabBarController

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
    NSLog(@"123  %@",self.userID);
    
    
    NSLog(@"qq  %@", self.viewControllers);
 
    for (int i=0; i<[self.viewControllers count]; i++)
    {
       self.selectedViewController=[self.viewControllers objectAtIndex:i];
    }

    
    NSLog(@" select %@",self.selectedViewController);
    
    if ([self.selectedViewController isEqual:@"SendExpress"])
    {
        NSLog(@"1222");
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
