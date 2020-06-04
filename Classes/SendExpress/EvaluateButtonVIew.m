//
//  EvaluateButtonVIew.m
//  Fahuobao
//
//  Created by 智发 on 14-8-20.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "EvaluateButtonVIew.h"

@implementation EvaluateButtonVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
     }
    return self;
}
-(id)init
{
    self = [super init];
    if (self)
    {
   
        but1=[UIButton buttonWithType:UIButtonTypeCustom];
          but1.frame=CGRectMake(7, 0, 100, 22);
        but1.selected=YES;
        [but1 setTitle:@"不满意" forState:UIControlStateNormal];
        [but1 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [but1 setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
        [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        but1.tag=10;
        [but1 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but1];
        
        
        
   
        
        but2=[UIButton buttonWithType:UIButtonTypeCustom];
         but2.frame=CGRectMake(93, 0, 100, 22);
        [but2 setTitle:@"一般" forState:UIControlStateNormal];
        [but2 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [but2 setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
         [but2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but2.tag=11;
        [but2 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but2];
        
     
        
        but3=[UIButton buttonWithType:UIButtonTypeCustom];
          but3.frame=CGRectMake(0, 29, 100, 22);
        [but3 setTitle:@"满意" forState:UIControlStateNormal];
        [but3 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [but3 setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
        [but3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but3.tag=12;
        [but3 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but3];
        
       
        
        
        but4=[UIButton buttonWithType:UIButtonTypeCustom];
         but4.frame=CGRectMake(110, 29, 100, 22);
        [but4 setTitle:@"非常满意" forState:UIControlStateNormal];
        [but4 setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [but4 setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateSelected];
         [but4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but4.tag=13;
   
        [but4 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but4];

    
    
    }
    return self;
}
-(void)buPress:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    if (button.selected==YES)
    {
        return;
    }
    else
    {
        for (int i = 10; i<=13; i++)
        {
            UIButton * button1 = (UIButton *)[self viewWithTag:i];
            button1.selected = NO;
        }
            button.selected = YES;
    }
     [self aViewGrade:self buttonTag:sender];
}

-(void)aViewGrade:(UIView*)view buttonTag:(UIButton*)btn
{
    float grade = 0;
    switch (btn.tag) {
        case 10:
            grade = 0.0;
            jifen= -10;
            break;
        case 11:
            grade = 0.5;
            jifen=10;
            break;
        case 12:
            grade = 1.0;
            jifen=20;
            break;
        case 13:
            grade = 1.5;
            jifen=30;
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(buttonGrade:viewTag:andBtnJifen:)])
    {
        [self.delegate buttonGrade:grade viewTag:view.tag andBtnJifen:jifen];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
