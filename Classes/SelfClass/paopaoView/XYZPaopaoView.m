//
//  XYZPaopaoView.m
//  xilaikd
//
//  Created by 智发 on 14-7-17.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "XYZPaopaoView.h"

@implementation XYZPaopaoView
@synthesize paopaoImage,empName,empTel,company;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor redColor];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:self.frame];
        image.image = [UIImage imageNamed:@"paopao"];
        [self addSubview:image];
        
//        UIImageView *empImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 50)];
//        empImageView.image = [UIImage imageNamed:@"CouPic1"];
//        [self addSubview:empImageView];
        
        empName = [[UILabel alloc]initWithFrame:CGRectMake(50, 10,90,20)];
        empName.font = [UIFont systemFontOfSize:20.0f];
        
        [self addSubview:empName];
        
        empTel = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 90, 20)];
        empTel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:empTel];
        
        company = [[UILabel alloc]initWithFrame:CGRectMake(50, 40, 90, 20)];
        company.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:company];
        
         paopaoImage=[UIButton buttonWithType:UIButtonTypeCustom];
        paopaoImage.frame=CGRectMake(5, 5, 40, 50);
        [paopaoImage setBackgroundImage:[UIImage imageNamed:@"CouPic1"] forState:UIControlStateNormal];
       [paopaoImage addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:paopaoImage];
        
    }
    return self;
}
-(void)buPress:(id)sender
{

    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(btnWithCourieTel:CourieName:andCourieCompay:)])
    {
        [self.delegate btnWithCourieTel:empTel.text CourieName:empName.text andCourieCompay:company.text];
    }


}
@end
