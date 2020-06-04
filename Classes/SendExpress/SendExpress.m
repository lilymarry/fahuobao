//
//  SendExpress.m
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "SendExpress.h"
#import "PostGoodsListCell.h"
#import "PostGoodsList.h"
@interface SendExpress ()<UITableViewDataSource,UITableViewDelegate,ButtonClickDelegate,GestureDelegate,UIAlertViewDelegate>

@end

@implementation SendExpress
@synthesize userID,isPush;
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
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doLeft)];
    [left setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:left];
    
    [detaileView setBackgroundColor:[UIColor clearColor]];
    
    errorAler = [[XYZError alloc]init];
    errorAler.title = @"温馨提示!";
    
    isFinish = NO;
    wait = [[WaitView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
    wait.reloadLable.adjustsFontSizeToFitWidth = YES;
    isPush = NO;
    _id = [[NSString alloc]init];
    
//    NSString *s = [[NSString alloc]initWithFormat:@"tel=%@",userID  ];
//    jifen= [getZhiFaData getUserjife:s];
   
    
   //  [self doRefresh];
      userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTel"];
    
    jifen=@"";
}
-(void)reloadTableViewData
{
    self.view.userInteractionEnabled = YES;
    getData = nil;
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTel"];
    
    
    if (userID == nil) {
        return;
    }
   
    if (detaileView != nil) {
        [detaileView reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self doRefresh];
    self.view.userInteractionEnabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [getData cancel];
    [dataArray removeAllObjects];
}
#pragma mark --切换场景--
-(void)doRight
{
    self.isPush = YES;
   // [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doLeft
{
    self.isPush = YES;
    if (querView == nil)
    {
        querView = [[QueryView alloc]init];
    }
    [self performSegueWithIdentifier:@"pushQview" sender:nil];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        headView.backgroundColor = [UIColor whiteColor];
    @autoreleasepool
    {

                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(7, 0, 120, 42)];
                UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(160, 0, 120, 42)];
                if (userID!=nil)
                {
                    label.text = [NSString stringWithFormat:@"用户ID: %@",userID];
                    
                 }
                else
                {
                     label.text = @"用户ID:";
                   
                }
                  if (jifen)
                  {
                      
                   label1.text=[NSString stringWithFormat:@"积分: %@",jifen];
                   }
                  else
                  {
                     label1.text=@"积分：";
        
                   }
                  label.font =[UIFont systemFontOfSize:12.0f];
                 [label sizeToFit];
                 [headView addSubview:label];
        
                 label1.font =[UIFont systemFontOfSize:12.0f];
                 [label1 sizeToFit];
                 [headView addSubview:label1];
        
           }

    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 158.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //配置每一个cell的详细数据
//    static BOOL isOk = NO;
//    if (!isOk) {
//        
//        UINib *nib=[UINib nibWithNibName:@"PostgoodsListCell" bundle:nil];
//        [tableView registerNib:nib forCellReuseIdentifier:@"postgoodscell"];
//        isOk = YES;
//    }
    PostGoodsListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"postgoodscell"];
    if (cell == nil)
    {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PostgoodsListCell" owner:self options:nil] lastObject];
    }
    cell.buttonDelegate = self;
    cell.gestureDelegate = self;
//    PostGoodsList *goods = [dataArray objectAtIndex:dataArray.count-indexPath.row-1];
    PostGoodsList *goods = [dataArray objectAtIndex:(dataArray.count-1-indexPath.row)];
    cell.tag = dataArray.count-indexPath.row-1;
    cell.gettimeLabel.text = goods.time;
    cell.empnameLabel.text = goods.empName;
    cell.empComLabel.text = goods.empCom;
    cell.telLabel.text = goods.empTel;
    cell.timeLabel.text = goods.gettime;
    cell.idLabel.text = [NSString stringWithFormat:@"%@",goods._id];
    NSMutableString *stringTEmp = [[NSMutableString alloc]initWithString:@"本单为"];
    
    if (goods.payway.length!=0)
    {
        [stringTEmp appendString:goods.payway];
    }
    
    [stringTEmp appendString:@"价"];
    
    if (goods.pricesyso.length!=0)
    {
        [stringTEmp appendString:goods.pricesyso];
    }
    [stringTEmp appendString:@"支付"];
    cell.paypric.text = stringTEmp;
    cell.ordString = [NSString stringWithFormat:@"%@",goods._id];
    cell.stateString = [NSString stringWithFormat:@"%@",goods.state];
    cell.cusString = [NSString stringWithFormat:@"%@",goods.cusUpload];
    cell.paystate = goods.paystate;
    cell.CourierNumber.text = goods.cusExpnum;
    cell.payway = goods.payway;
    
    cell.pijiaState=goods.jifenStaste;
    
    NSString *payWay = [NSString stringWithString:cell.payway];
    NSString *StateString = [NSString stringWithFormat:@"%@",goods.state];
    [cell.ActionButton setUserInteractionEnabled:YES];
    
    if ([StateString isEqualToString:@"2"])
    {
        cell.tishiLable.hidden=YES;
        if ([cell.cusString intValue] == 1)
        {
            [cell.ActionButton setTitle:@"支付" forState:UIControlStateNormal];
            if ([payWay isEqualToString:@"现金"])
            {
                [cell.ActionButton setTitle:@"单号已扫描" forState:UIControlStateNormal];
                [cell.ActionButton setUserInteractionEnabled:NO];
            }
            else
            {
                [cell.ActionButton setUserInteractionEnabled:YES];
            }
            if ([cell.paystate intValue] == 1)//付款完成状态
            {
               if ([cell.pijiaState intValue]==1)
                {
                    [cell.ActionButton setTitle:@"订单已完成" forState:UIControlStateNormal];
                    [cell.ActionButton setUserInteractionEnabled:NO];
                 
                }
                else
                {
                    
                    [cell.ActionButton setTitle:@"请您评价" forState:UIControlStateNormal];
                }
                
            //    [cell.ActionButton setTitle:@"请您评价" forState:UIControlStateNormal];
                
            }
            else
            {
                [cell.ActionButton setTitle:@"请您支付" forState:UIControlStateNormal];
                if ([payWay isEqualToString:@"现金"])
                {
                    [cell.ActionButton setTitle:@"单号已纪录" forState:UIControlStateNormal];
                    [cell.ActionButton setUserInteractionEnabled:NO];
                }
                else
                {
                    [cell.ActionButton setUserInteractionEnabled:YES];
                }
                
            }
        }
        else
        {
            [cell.ActionButton setUserInteractionEnabled:YES];
            [cell.ActionButton setTitle:@"请您扫描单号" forState:UIControlStateNormal];
        }
    }
    if (![StateString isEqualToString:@"2"])
    {
        [cell.ActionButton setUserInteractionEnabled:YES];
        [cell.ActionButton setTitle:@"是否撤单" forState:UIControlStateNormal];
        cell.tishiLable.hidden=NO;
    }


    return cell;
}
#pragma mark--cell事件
-(void)uploadListClick:(id)object
{
    @autoreleasepool {
        PostGoodsListCell *cell = (PostGoodsListCell *)object;
        _id = cell.ordString;
        _index = cell.tag;
        if ([cell.ActionButton.titleLabel.text isEqualToString:@"是否撤单"])
        {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否撤销订单！" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"重新发送" ,@"撤销订单",nil];
            alertView.tag = 103;
            [alertView show];
        }
        if ([cell.ActionButton.titleLabel.text isEqualToString:@"请您扫描单号"])
        {
            isPush = YES;
            if (orderID == nil)
            {
                orderID = [NSString stringWithFormat:@"%@",cell.ordString];
            }
            orderID = cell.ordString;
            [self performSegueWithIdentifier:@"pushZBar" sender:nil];
            
        }
        if ([[cell.ActionButton currentTitle] isEqualToString:@"请您支付"])
        {
            [self jieSuan:cell.ordString];
        }
        //评价
        if ([[cell.ActionButton currentTitle] isEqualToString:@"请您评价"])
        {
            [self evaluataServe:cell.ordString];
        }

    
        
    }
}


-(void)longPressGestureAction:(id)object
{
    //    NSLog(@"chang an");
    //长按删除
    @autoreleasepool {
        PostGoodsListCell *cell = (PostGoodsListCell *)object;
        _id = cell.ordString;
        _index = cell.tag;
        if ([cell.stateString isEqualToString:@"2"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = 101;//表示是长按事件引起
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"是否货已发" delegate:self cancelButtonTitle:@"未发" otherButtonTitles:@"已发", nil];
            alertView.tag = 104;
            [alertView show];
        }
    }
}

-(void)tapGestureAction:(id)object
{
    NSLog(@"duan an");
    //短按打电话
    @autoreleasepool {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 102;//表示是长按事件引起
        [alertView show];
        PostGoodsListCell *cell = (PostGoodsListCell *)object;
        telString = cell.telLabel.text;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101)
    {
        if (buttonIndex == 1)
        {
            [self.view addSubview:wait];
            [wait.activityView startAnimating];
            [NSThread detachNewThreadSelector:@selector(deleteAndOrd:) toTarget:self withObject:_id];
        }
    }
    if (alertView.tag == 102)
    {
        if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telString]]];
        }
    }
    if (alertView.tag == 103)
    {
        //         NSString *param = [NSString stringWithFormat:@"id=%@",_id];
        NSURL *temp;
        
        if (buttonIndex==0)
        {
            
        }
        else if(buttonIndex == 1)
        {//重新发送
            temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/againsend.do?",mainUrl]];
            [NSThread detachNewThreadSelector:@selector(getAgainOr:) toTarget:self withObject:temp];
        }
        else
        {//撤单
            temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/cancelOrder.do?",mainUrl]];
            [NSThread detachNewThreadSelector:@selector(getAgainOr:) toTarget:self withObject:temp];
        }
    }
    if (alertView.tag == 104)
    {
        if (buttonIndex == 0)
        {
            ;
        }
        else
        {
            NSString *temp = [NSString stringWithFormat:@"id=%@",_id];
            [NSThread detachNewThreadSelector:@selector(getSendGoodsFinish:) toTarget:self withObject:temp];
        }
    }
}
#pragma mark 删除发货单
-(void)deleteAndOrd:(NSString *)ordId
{
    NSString *temp = [getZhiFaData deleteUserSingle:ordId];
    [self performSelectorOnMainThread:@selector(returnDele:) withObject:temp waitUntilDone:YES];
}
-(void)returnDele:(NSString *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    if ([temp isEqualToString:@"ok"])
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"删除成功！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
        [dataArray removeObjectAtIndex:_index];
        [detaileView reloadData];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"删除失败！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
        
    }
    
}
#pragma mark 重发或撤销
-(void)getAgainOr:(id)temp
{
    wait.reloadLable.text = @"正在执行操作";
    [self.view addSubview:wait];
    [wait.activityView startAnimating];
    NSURL *url = temp;
    NSString * isSuccess = [getZhiFaData aginSend:url andParam:[NSString stringWithFormat:@"id=%@",_id]];
    [self performSelectorOnMainThread:@selector(sucess:) withObject:isSuccess waitUntilDone:NO];
}
#pragma mark 返回
-(void)sucess:(NSString *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    if ([temp isEqualToString:@"ok"])
    {
        errorAler.message = @"操作成功";
        [dataArray removeObjectAtIndex:_index];
        [detaileView reloadData];
    }
    else
    {
        errorAler.message = @"操作失败";
    }
    [errorAler erroShow];
}
#pragma mark 发货确认
-(void)getSendGoodsFinish:(NSString *)temp
{
    wait.reloadLable.text = @"正在确认中";
    [self.view addSubview:wait];
    [wait.activityView startAnimating];
    //    NSLog(@"%@",temp);
    NSString *string = [getZhiFaData tradFinish:temp];
    [self performSelectorOnMainThread:@selector(returnSendFinish:) withObject:string waitUntilDone:YES];
}
#pragma mark 收货返回值
-(void)returnSendFinish:(NSString *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    if ([temp isEqualToString:@"ok"])
    {
        errorAler.message = @"操作成功";
        isFinish = YES;
        [self doRefresh];
    }
    else
    {
        errorAler.message = @"操作失败";
    }
    [errorAler erroShow];
}
- (IBAction)buttonAc:(id)sender
{
    [self doRefresh];
}
-(void)doRefresh
{
    if (getData==nil)
    {
        getData = [[NSThread alloc]initWithTarget:self selector:@selector(getTableData) object:nil];
    }
    [getData start];
    [dataArray removeAllObjects];
    wait.reloadLable.text = @"努力加载中";
    [self.view addSubview:wait];
    [wait.activityView startAnimating];
}
-(void)getTableData
{
    
    dataArray = [getZhiFaData getUsersInvoice:userID];
    NSString *s = [[NSString alloc]initWithFormat:@"tel=%@",userID  ];
    
    jifen= [getZhiFaData getUserjife:s];

    [self performSelectorOnMainThread:@selector(reloadTableViewData) withObject:nil waitUntilDone:YES];
   
   
}


//评价页面
-(void)evaluataServe:(NSString *)idStr
{
    if (orderID == nil)
    {
        orderID = [NSString stringWithString:idStr];
    }
    orderID = idStr;
    
    [self performSegueWithIdentifier:@"evaluateVC" sender:nil];
    
}
-(void)jieSuan:(NSString *)idStr
{
    if (orderID == nil)
    {
        orderID = [NSString stringWithString:idStr];
    }
    orderID = idStr;
    [self performSegueWithIdentifier:@"pushCalculer" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"pushCalculer"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:userID forKey:@"userTel"];
        [theSegue setValue:orderID forKey:@"ordStr"];
    }
    if ([segue.identifier isEqualToString:@"pushZBar"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:orderID forKey:@"ordID"];
    }
    if ([segue.identifier isEqualToString:@"evaluateVC"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:orderID forKey:@"ordStr"];
   
    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
