//
//  ScanCourierViewController.m
//  Fahuobao
//
//  Created by 智发 on 14-8-23.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "ScanCourierViewController.h"
#import "ZhiFaApi.h"
#import "ScanCourieTableViewCell.h"
@interface ScanCourierViewController ()

@end

@implementation ScanCourierViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
    [self.view addSubview: self.jieguLable];
    [self.view addSubview:self.EtableView];

    

}
-(void)viewWillAppear:(BOOL)animated
{


    self.nameLabel.text=self.courName;
  
    self.companyLable.text=self.courCompany;

    NSString *s = [[NSString alloc]initWithFormat:@"phone=%@",self.courierTel  ];//设置参数
    self.dic=[getZhiFaData getDataFromjife:s];


    NSInteger  point = [[self.dic objectForKey:@"point"] integerValue];

    self.jifenLabel.text=[NSString stringWithFormat:@"%d",point];
  
    self.contentArr=[[NSMutableArray alloc]initWithCapacity:10];

    self.ratingArr=[[NSMutableArray alloc]initWithCapacity:10];
    
  
    NSMutableArray *  arr=[NSMutableArray arrayWithArray:[self.dic objectForKey:@"apps"]];


    for (int i=0;i<arr.count;i++)
    {
        if ([[[arr objectAtIndex:i] objectForKey:@"rating"]doubleValue] ==0)
        {
        
               [arr removeObjectAtIndex:i];
        }
        
    }
        for(int i=0; i<[arr count]; i++)
       {
          NSDictionary * dict = [arr objectAtIndex:i];
          NSString * content = [dict objectForKey:@"content"];
          [self.contentArr addObject:content];
          NSString * rating = [ NSString stringWithFormat: @"%0.1f", [[dict objectForKey:@"rating"] doubleValue]];
          [self.ratingArr addObject:rating];
       }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 

    return [ self.ratingArr count];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *flag=@"inder";
   
    ScanCourieTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
  

    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ScanCourieTableViewCell" owner:self options:nil] lastObject];
        
        
    }
 
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"0.5"])
        {
            cell.s1.image=[UIImage imageNamed:@"24"];
            cell.s2.image=[UIImage imageNamed:@"20"];
            cell.s3.image=[UIImage imageNamed:@"20"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
            
        }
        
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"1.0"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"20"];
            cell.s3.image=[UIImage imageNamed:@"20"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"1.5"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"24"];
            cell.s3.image=[UIImage imageNamed:@"20"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
            
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"2.0"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"20"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
            
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"2.5"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"24"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"3.0"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"22"];
            cell.s4.image=[UIImage imageNamed:@"20"];
            cell.s5.image=[UIImage imageNamed:@"20"];
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"3.5"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"22"];
            cell.s4.image=[UIImage imageNamed:@"24"];
            cell.s5.image=[UIImage imageNamed:@"20"];
            
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"4.0"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"22"];
            cell.s4.image=[UIImage imageNamed:@"22"];
            cell.s5.image=[UIImage imageNamed:@"20"];
            
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"4.5"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"22"];
            cell.s4.image=[UIImage imageNamed:@"22"];
            cell.s5.image=[UIImage imageNamed:@"24"];
        }
        if ([[self.ratingArr objectAtIndex:indexPath.row]isEqualToString:@"5.0"])
        {
            cell.s1.image=[UIImage imageNamed:@"22"];
            cell.s2.image=[UIImage imageNamed:@"22"];
            cell.s3.image=[UIImage imageNamed:@"22"];
            cell.s4.image=[UIImage imageNamed:@"22"];
            cell.s5.image=[UIImage imageNamed:@"22"];
            
        }
    
        cell.pijiaLable.text=[self.contentArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 108;
    
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

- (IBAction)chatPerss:(id)sender
{
    
}
@end
