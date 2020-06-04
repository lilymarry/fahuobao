//
//  CalculerView.m
//  Fahuobao
//
//  Created by 智发 on 14-8-8.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "CalculerView.h"
#import "PartnerConfig.h"

#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#define NUMBERS @"0123456789."
@interface CalculerView ()

@end

@implementation CalculerView
@synthesize ordStr,userTel;
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
    textView.text = @"说明:\n        1、快递首重标准均为1公斤，单件快件重量不超过50公斤。\n        2、泡货转换重量标准 = （长x宽x高）厘米/6000。\n        3、快递费计算公式：快递费=首重价+续重价x（总重-1）。\n        4、快件单变长不超过160厘米，两边之和不超过180厘米，三边之和不超过280厘米。";
    self.arr=[NSArray arrayWithObjects:@"海南",@"西藏",@"新疆",@"内蒙古" ,@"广西",@"福建",@"黑龙江",@"吉林",@"广东",@"四川",@"安徽",@"宁夏",@"青海",@"甘肃",@"云南",@"贵州",@"江西",@"湖南",@"山西",@"河北",@"辽宁",@"湖北",@"山东",@"重庆",@"天津",@"陕西",@"浙江",@"江苏",@"上海",@"北京",@"同城",@"河南",nil];
    
    
    
    NSArray *arr_10_3=[NSArray arrayWithObject:@"同城"];
    NSArray *arr_15_5=[NSArray arrayWithObjects: @"广东",@"四川",@"安徽",@"宁夏",@"青海",@"甘肃",@"云南",@"贵州",@"江西",@"湖南",@"山西",@"河北",@"辽宁",@"湖北",@"山东",@"重庆",@"天津",@"陕西",@"浙江",@"江苏",@"上海",@"北京",@"河南",nil];
    NSArray *arr_15_8=[NSArray arrayWithObjects: @"广西",@"福建",@"黑龙江",@"吉林",nil];
    NSArray *arr_20_15=[NSArray arrayWithObjects:@"海南",@"西藏",@"新疆",@"内蒙古",nil];
    
    _allCity =[NSArray arrayWithObjects:arr_10_3,arr_15_5,arr_15_8,arr_20_15 ,nil];
    // NSLog(@"all%@",_allCity);
    
    NSArray *num_10_3=[NSArray arrayWithObjects:@"10",@"3",nil];
    NSArray *num_15_5=[NSArray arrayWithObjects:@"15",@"5",nil];
    NSArray *num_15_8=[NSArray arrayWithObjects:@"15",@"8",nil];
    NSArray *num_20_15=[NSArray arrayWithObjects:@"20",@"15",nil];
    _num=[NSArray arrayWithObjects:num_10_3,num_15_5,num_15_8,num_20_15, nil];
    
    
    cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.text = @"同城";
    cityLabel.font= [UIFont systemFontOfSize:17.0f];
//    cityLabel.textColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.5 alpha:0.5];
    cityLabel.textColor = [UIColor blackColor];
    [changButton addSubview:cityLabel];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTap)];
//    [self.view addGestureRecognizer:tap];
    
//    results1.text=@"0.01";
     _result = @selector(paymentResult:);
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification1:) name:@"sccuess" object:nil];
  
}

-(void)getNotification1:(NSNotification *)notification
{
    NSString *str=[notification object];

    if ([str isEqualToString:@"9000"])
    {
        NSString *str = [[NSString alloc]initWithFormat:@"id=%@&tradeNo=%@&goodsName=%@&money=%@&userTel=%@",self.ordStr,self.tradeNo,@"快递费", results1.text ,self.userTel];//设置参数
        NSString *temp =[getZhiFaData getDataFromZhifuBao:str];
        [self returnResult:temp];
        
        
    }
}
//-(void)getNotification2:(NSNotification *)notification
//{
//    //    NSString *str=[notification object];
//    //    NSLog(@"getNotification2:%@",str);
//    
//    
//    NSLog(@"getNotification2:self.ordStr %@    self.userTel%@",self.ordStr ,self.userTel);
//    
//    NSString *str = [[NSString alloc]initWithFormat:@"id=%@&tradeNo=%@&goodsName=%@&money=%@&userTel=%@",self.ordStr,self.tradeNo,@"快递费", results1.text ,self.userTel];//设置参数
//    
//    NSString *temp =[getZhiFaData getDataFromZhifuBao:str];
//    [self returnResult:temp];
//    
//    
//}







-(void)doRight
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)hiddenTap
{
    [wideText resignFirstResponder];
    [priceText resignFirstResponder];
    dataview.hidden = YES;
    [longText resignFirstResponder];
    [weightText resignFirstResponder];
    [heightText resignFirstResponder];

}
-(void)doTapGest
{
    [self hiddenTap];
    if (dataview.hidden==YES)
    {
        dataview.hidden = NO;
    }
    else
    {
        dataview.hidden = YES;
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest)
    {
        return NO;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(int)searchCity1:(NSString *)str
{
    for (int i=0; i<[_allCity count]; i++)
        
    {
        for (int j=0; j<[[_allCity objectAtIndex:i] count]; j++)
        {
            if ([str isEqualToString:[[_allCity objectAtIndex:i] objectAtIndex:j ]])
            {
                return i;
            }
        }
    }
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *flagg=@"flag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flagg];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:flagg] ;
    }
    
  
   
    //设置cell的文本
    cell.textLabel.text = [self.arr
                           objectAtIndex:[indexPath row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cityLabel.text=[self.arr objectAtIndex:indexPath.row];
    cityLabel.textColor = [UIColor blackColor];
    dataview.hidden=YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.arr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

- (IBAction)doChang:(id)sender
{
    [self hiddenTap];
    if (dataview.hidden==YES)
    {
        dataview.hidden = NO;
    }
    else
    {
        dataview.hidden = YES;
    }
}

- (IBAction)doButton1:(UIButton *)sender
{
    [self hiddenTap];
    results1.text=nil;
    double bagFrize=0;
    bagFrize=[priceText.text doubleValue];
    double weih=0;
    weih=[wideText.text doubleValue];
   // NSLog(@"weigh%f",weih);
    
    int i=[self searchCity1:cityLabel.text];
    if (priceText.text.length==0||wideText.text.length==0||cityLabel.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"输入信息不完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if(![cityLabel.text isEqualToString:@"请选择城市"])
    {
        if (weih>50)
            
        {
            
            results1.text=@"你输入的物品大于50kg!";
        }
        else
        {
            
            if (i==8)
            {
                results1.text=@"结果不存在";
                
            }
            else if(i!=8)
            {
                double fist=[[[_num objectAtIndex:i]objectAtIndex:0]doubleValue] ;
                double second=[[[_num objectAtIndex:i]objectAtIndex:1]doubleValue];
               // NSLog(@"num首重= %f",fist);
               // NSLog(@"num续重= %f",second);
                
                if (weih<1||weih==1)
                {
                    results1.text=[NSString stringWithFormat:@"%0.2f",fist+bagFrize];
                }
                
                else
                {
                    
                    results1.text=[NSString stringWithFormat:@"%0.2f", fist+ (weih-1)*second+bagFrize];
                    
                    
                }
                
                
            }
            
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请选择目标城市！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (IBAction)doButton2:(UIButton *)sender
{
   
    [self hiddenTap];
    if (longText.text.length==0||weightText.text.length==0||heightText.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"输入信息不完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else
    {
        double longdu=0;
        
        longdu=[longText.text doubleValue];
        
        double widedu=0;
        
        widedu=[weightText.text doubleValue];
        
        double hieghtdu=0;
        
        hieghtdu=[heightText.text doubleValue];
        if (longdu>160||widedu>160||hieghtdu>160)
        {
            results2.text=@"单边长度大于160厘米";
        }
        else if (longdu+widedu>180||widedu+hieghtdu>180||hieghtdu+longdu>180)
        {
            results2.text=@"两边之和长度大于180厘米";
        }
        else if (longdu+widedu+hieghtdu>280)
        {
            
            results2.text=@"三边之和长度大于280厘米";
        }
        else
        {
            
            _result2=(longdu*widedu*hieghtdu)/6000;
            
            results2.text=[NSString stringWithFormat:@"%f",_result2];
            
        }
    }
}

- (IBAction)jieSuan:(UIButton *)sender
{
    if ([results1.text isEqualToString:@"0.00元"] || results1.text.length==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"请确认计算结果是否存在" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        NSString *appScheme = @"Fahuobao";
        //1.订单信息
        NSString* orderInfo = [self getOrderInfo];
        //2.交换证书
        NSString* signedStr = [self doRsa:orderInfo];
        
        
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        
        //调用支付接口
        [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
    }
}
-(NSString*)getOrderInfo
{
    
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    //合作者ID
    order.partner = PartnerID;
    //收款人账号
    order.seller = SellerID;
    
    self.tradeNo=[self generateTradeNO];
    //交易流水号
    order.tradeNO = self.tradeNo;
    
	//商品标题
    order.productName = @"快递费" ;
    //商品描述
	order.productDescription = @"快递返现活动！";
    //商品价格
    //self.money=results1.text;
   // results1.text=@"0.01";
    
	order.amount =results1.text;
    //回调URL
	order.notifyURL =  @"http%3A%2F%2Fwwww.xxx.com";
    
	return [order description];
}
//随机生成订单ID
- (NSString *)generateTradeNO
{
    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddHHmmss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];
    //NSLog(@"PPP-%@",loctime);
    
    
    int a;
    NSMutableString *str=[[ NSMutableString alloc]initWithCapacity:10];
    for (int i=0; i<5; i++)
    {
        a = arc4random() % 5+ 1;
        [str appendString:  [NSString stringWithFormat:@"%d",a ]];
        
    }
    
    return [ NSString stringWithFormat:@"%@%@",loctime, str];
    
}

//交换密钥
-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    // NSLog(@"%@",result);
}


//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
    
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
   // NSLog(@"pan1111     result%d",result.statusCode);
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                
                
                //参数：id------订单id    tradeNo---------交易流水号（ 月日时分秒+5位随机数）  goodsName-------商品名称  money-----金额    userTel----用户电话
                
//                
//                NSString *str = [[NSString alloc]initWithFormat:@"id=%@&tradeNo=%@&goodsName=%@&money=%@&userTel=%@",self.ordStr,self.tradeNo,@"快递费", results1.text ,self.userTel];//设置参数
//                NSString *temp =[getZhiFaData getDataFromZhifuBao:str];
//                [self performSelectorOnMainThread:@selector(returnResult:) withObject:temp waitUntilDone:YES];
//                
			}
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}
-(void)returnResult:(NSString  *)temp
{
    
    
    
    if ([temp isEqualToString:@"ok"])
    {
//        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"成功！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertview show];
        NSLog(@"上传ok");
        
        
    }
    
    else
    {
//        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"error！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertview show];
        NSLog(@"上传err");
        
        
    }
    
    
}










@end
