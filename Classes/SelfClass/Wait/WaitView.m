//
//  WaitView.m
//  WyattAnimation
//
//  Created by mac on 14-4-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "WaitView.h"

@implementation WaitView
@synthesize activityView,reloadLable;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((frame.size.width-30)/2, 10, 30, 30)];
        self.activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        self.layer.cornerRadius=6;
        self.layer.masksToBounds=YES;
        self.reloadLable=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height-50, frame.size.width,30)];
        self.reloadLable.text=@"努力加载中···";
        self.reloadLable.textColor = [UIColor whiteColor];
        self.reloadLable.textAlignment=NSTextAlignmentCenter;
        self.reloadLable.backgroundColor=[UIColor clearColor];
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Wait"]];
        [self addSubview:self.activityView];
        [self addSubview:self.reloadLable];
    }
    return self;
}
@end
