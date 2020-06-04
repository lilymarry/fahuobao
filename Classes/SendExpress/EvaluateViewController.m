//
//  EvaluateViewController.m
//  Fahuobao
//
//  Created by 智发 on 14-8-20.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()

@end

@implementation EvaluateViewController

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
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
    
    
    
    self.buView1=[[EvaluateButtonVIew alloc]init];
    self.buView1.frame=CGRectMake(78, 140, 165, 51);
    self.buView1.delegate=self;
    self.buView1.tag=1000;
    
    [self.view addSubview: self.buView1];
    
    self.buView2=[[EvaluateButtonVIew alloc]init];
    self.buView2.frame=CGRectMake(78, 199, 165, 51);
     self.buView2.delegate=self;
     self.buView2.tag=1001;
    [self.view addSubview: self.buView2];
    
    
    self.buView3=[[EvaluateButtonVIew alloc]init];
    self.buView3.frame=CGRectMake(78, 258, 165, 51);
    self.buView3.delegate=self;
     self.buView3.tag=1002;
    [self.view addSubview: self.buView3];
    
    
   
    [self.view addSubview:self.PeopleAddviceTextView];

    
    self.PeopleAddviceTextView.delegate=self;
    
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    //设置style
    [topView setBarStyle:UIBarStyleBlack];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    
    [self.PeopleAddviceTextView setInputAccessoryView:topView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   // NSLog(@")))))%@",self.ordStr);
    nunStar=0.5;
    
     grate=10;
    str=[[NSString alloc]init];
    
    jifenA=-10;
    jifenB=-10;
    jifenC=-10;
  
    
  
}
- (BOOL)textView:(UITextView *)atextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([[self.PeopleAddviceTextView text] length]>70)
    {
        return NO;
    }
    
    //判断是否为删除字符，如果为删除则让执行
    
    char c=[text UTF8String][0];
    if (c=='\000')
    {
      
        return YES;
    }
    
    if([[self.PeopleAddviceTextView text] length]==70)
    {
        if(![text isEqualToString:@"\b"]) return NO;
    }
    

    return YES;
}
-(void)resignKeyboard
{
    [self.PeopleAddviceTextView resignFirstResponder];
    
    
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    

    
    NSDictionary *info = [notification userInfo];
    //键盘大小
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //时间间隔
    NSTimeInterval animationDuration = 0.5f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //屏幕大小
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.PeopleAddviceTextView.frame = CGRectMake(7,rect.size.height-kbSize.height-self.PeopleAddviceTextView.bounds.size.height-10,self.PeopleAddviceTextView.bounds.size.width,self.PeopleAddviceTextView.bounds.size.height);
    [UIView commitAnimations];
    
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    

    NSTimeInterval animationDuration = 0.0f;

    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.PeopleAddviceTextView.frame=CGRectMake(7, 330, 301, 59);
    [UIView commitAnimations];

    

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)buttonGrade:(float)grade viewTag:(int)tag andBtnJifen:(int)jiFen;
{
    if (tag == 1000)
    {
        firstValue = grade;
        jifenA=jiFen;
    }
    if (tag == 1001)
    {
        secondValue = grade;
        jifenB =jiFen;
    }
    if (tag == 1002)
    {
        thirdValue = grade;
        jifenC=jiFen;
    }
   
    if (firstValue==0.0&&secondValue==0.0&&thirdValue==0.0)
    {
        str =@"0.5";
        grate=-20;
        [self setStarViewWithTotalPointsLabel:str];
        
    }
    else
    {
        str = [NSString stringWithFormat:@"%.1f",firstValue + secondValue + thirdValue+0.5];
       [self setStarViewWithTotalPointsLabel:str];
    }
}

-(void)setStarViewWithTotalPointsLabel:(NSString *)st
{
    
    
    if ([st isEqualToString:@"0.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"24"];
        self.starView2.image=[UIImage imageNamed:@"20"];
        self.starView3.image=[UIImage imageNamed:@"20"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
        nunStar=0.5;
    
        
    }
    if ([st isEqualToString:@"0.5"])
    {
        self.starView1.image=[UIImage imageNamed:@"24"];
        self.starView2.image=[UIImage imageNamed:@"20"];
        self.starView3.image=[UIImage imageNamed:@"20"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
        nunStar=0.5;
    
        
    }
    if ([st isEqualToString:@"1.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"20"];
        self.starView3.image=[UIImage imageNamed:@"20"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
        nunStar=1.0;
    
    }
    if ([st isEqualToString:@"1.5"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"24"];
        self.starView3.image=[UIImage imageNamed:@"20"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
        nunStar=1.5;
       
    }
    if ([st isEqualToString:@"2.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"20"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
        nunStar=2.0;
        
    }


    if ([st isEqualToString:@"2.5"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"24"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
          nunStar=2.5;
      
        
    }
    if ([st isEqualToString:@"3.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"22"];
        self.starView4.image=[UIImage imageNamed:@"20"];
        self.starView5.image=[UIImage imageNamed:@"20"];
          nunStar=3.0;
        
    }
    if ([st isEqualToString:@"3.5"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"22"];
        self.starView4.image=[UIImage imageNamed:@"24"];
        self.starView5.image=[UIImage imageNamed:@"20"];
          nunStar=3.5;
        
        
    }
    if ([st isEqualToString:@"4.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"22"];
        self.starView4.image=[UIImage imageNamed:@"22"];
        self.starView5.image=[UIImage imageNamed:@"20"];
          nunStar=4.0;
        
        
    }
    if ([st isEqualToString:@"4.5"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"22"];
        self.starView4.image=[UIImage imageNamed:@"22"];
        self.starView5.image=[UIImage imageNamed:@"24"];
         nunStar=4.5;
      
        
    }
    if ([st isEqualToString:@"5.0"])
    {
        self.starView1.image=[UIImage imageNamed:@"22"];
        self.starView2.image=[UIImage imageNamed:@"22"];
        self.starView3.image=[UIImage imageNamed:@"22"];
        self.starView4.image=[UIImage imageNamed:@"22"];
        self.starView5.image=[UIImage imageNamed:@"22"];
        nunStar=5.0;
        
        
    }
  

}


-(void)doRight
{
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

- (IBAction)SubmitEvaluatePress:(id)sender
{
    if (self.PeopleAddviceTextView.text.length==0)
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"还没有评价！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
    
    }
  
        
    else
    {
   
        
        NSString *s = [[NSString alloc]initWithFormat:@"id=%@&rating=%f&content=%@&jinfen=%d",self.ordStr,  nunStar ,self.PeopleAddviceTextView.text,grate  ];//设置参数
       NSString *temp =[getZhiFaData getDataFromEvalute:s];
     [self returnResult:temp];
    }
}
-(void)returnResult:(NSString  *)temp
{
    
    
    
    if ([temp isEqualToString:@"ok"])
    {
              UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"提交成功！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
               [alertview show];
     
        
        
    }
    
    else
    {
               UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"error！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertview show];
  
        
        
    }
    
    
}
@end
