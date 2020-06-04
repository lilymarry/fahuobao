//
//  FirstView.m
//  Tets
//
//  Created by 智发 on 14-8-11.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "FirstView.h"

@interface FirstView ()
{
    IBOutlet UIImageView *imageView1;
    IBOutlet UIPageControl *pageCon;
}

@end

@implementation FirstView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    scrollView1.contentSize = CGSizeMake(960, self.view.frame.size.height-20);
    scrollView1.pagingEnabled = YES;
    scrollView1.scrollsToTop = NO;
    scrollView1.directionalLockEnabled = YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    imageView1.frame = CGRectMake(0, 0, 320, imageView1.frame.size.height);
}
-(void)pageControlAction
{
    NSInteger index=pageCon.currentPage;
    CGSize size=scrollView1.frame.size;
    CGPoint point=scrollView1.frame.origin;
    CGRect rect=CGRectMake(size.width*index,point.y, size.width, size.height);
    [scrollView1 scrollRectToVisible:rect animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point=scrollView.contentOffset;
    NSInteger indexPath=(NSInteger)point.x/320;
    [pageCon setCurrentPage:indexPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doPush:(UIButton *)sender
{
//    NSLog(@"dodododo");
    [self.navigationController popViewControllerAnimated:YES];
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
