//
//  EvaluateViewController.h
//  Fahuobao
//
//  Created by 智发 on 14-8-20.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluateButtonVIew.h"
#import "ZhiFaApi.h"
@interface EvaluateViewController : UIViewController<butDelegate,UITextViewDelegate>
{
    float firstValue;
    float secondValue;
    float thirdValue;
    float nunStar;
    int grate;
    NSString *str;
    
    int jifenA;
    int jifenB;
    int jifenC;
    
    
}
- (IBAction)SubmitEvaluatePress:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *starView1;
@property (strong, nonatomic) IBOutlet UIImageView *starView2;
@property (strong, nonatomic) IBOutlet UIImageView *starView3;
@property (strong, nonatomic) IBOutlet UIImageView *starView4;
@property (strong, nonatomic) IBOutlet UIImageView *starView5;

@property (strong, nonatomic) IBOutlet UITextView *PeopleAddviceTextView;
@property(strong,nonatomic)  EvaluateButtonVIew *buView1;
@property(strong,nonatomic)  EvaluateButtonVIew *buView2;
@property(strong,nonatomic)  EvaluateButtonVIew *buView3;
@property(nonatomic,strong)NSString *ordStr;


@end
