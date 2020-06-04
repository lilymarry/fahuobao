//
//  ExpressView.m
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "ExpressView.h"

@interface ExpressView ()
{
    BOOL flag;
}
@end

#define URLAPI @"http://www.aikuaidi.cn/rest/?key=8baccd673dac46c2a513c98d59aaa366&order=%@&id=%@&ord=asc&show=xml"
@implementation ExpressView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)getData
{ /*
    data1=[NSDictionary dictionaryWithObjectsAndKeys:
           @"aae",@"AAE",
           @"axd",@"安信达/华企快运",
           
           @"aj",@"安捷",
           @"aramex",@"Aramex",
           @"bfdf",@"百福东方",
           @"bfdf",@"EES",
           @"bgpyghx",@"邮政",
           @"bgpyghx",@"华诚物流",
           @"cxwl",@"传喜物流",
           @"chengguang",@"程光",
           @"coe",@"COE",
           @"coe",@"东方",
           @"ctwl",@"长通物流",
           @"cszx",@"城市之星物流",
           @"cs",@"城市100",
           @"chuanzhi",@"传志",
           @"debang",@"德邦物流",
           @"dhl",@"DHL",
           @"dpex",@"DPEX",
           @"dsf",@"递四方速递",
           @"dtwl",@"大田物流",
           @"dywl",@"大洋物流",
           @"ds",@"D速",
           @"ems",@"EMS",
           @"ems",@"E邮宝",
           @"fedex",@"FEDEX国际快递",
           @"fedexcn",@"FEDEX国内快递",
           @"fedexcn",@"联邦快递",
           @"fkd",@"飞康达快递",
           @"fbwl",@"飞邦物流",
           @"feibao",@"飞豹快递",
           @"feihu",@"飞狐快递",
           @"gsdwl",@"共速达物流",
           @"guotong",@"国通快递",
           @"gznd",@"港中能达|能达快递",
           @"henglu",@"恒路物流",
           @"huiqiang",@"汇强快递",
           @"hxlwl",@"华夏龙物流",
           @"hswl",@"昊盛物流",
           @"huitong",@"汇通快递",
           @"jingdong",@"京东快递",
           @"jldt",@"嘉里大通物流",
           @"jywl",@"佳怡物流",
           @"jiaji",@"佳吉快运",
           @"jiayunmei",@"加运美快递",
           @"jingguang",@"京广快递",
           @"jinyue",@"晋越快递",
           @"kuaijie",@"快捷快递",
           @"klwl",@"康力物流",
           @"longbang",@"龙邦快递",
           @"lianhaotong",@"联昊通快递",
           @"lejiedi",@"乐捷递快递",
           @"lijisong",@"立即送",
           @"minbang",@"民邦快递",
           
           @"minhang",@"民航快递",
           @"meiguo",@"美国快递",
           @"ocs",@"OCS快递",
           @"pinganda",@"平安达快递",
           @"quanfeng",@"全峰",
           @"quanyi",@"全一快递",
           @"quanchen",@"全晨快递",
           @"quanritong",@"全日通快递",
           @"rufengda",@"如风达快递",
           @"shentong",@"申通快递|申通E物流",
           @"shunfeng",@"顺丰",
           @"suer",@"山东海红快递",
           @"santai",@"三态速递",
           @"shenghui",@"盛辉物流",
           @"shengfeng",@"盛丰物流",
           
           @"shengan",@"圣安物流",
           @"saiaodi",@"赛澳递",
           @"tnt",@"TNT快递",
           @"thtx",@"通和天下物流",
           @"tcwl",@"通成物流",
           @"tdhy",@"天地华宇|华宇物流",
           @"tiantian",@"天天",
           @"ups",@"UPS国际快递",
           @"weibang",@"伟邦快递",
           
           @"weitepai",@"微特派快递",
           @"wxwl",@"万象物流",
           @"xfwl",@"信丰物流",
           @"xinbang",@"新邦物流",
           @"xindan",@"新蛋物流|奥硕物流",
           @"yuantong",@"圆通",
           @"yunda",@"韵达",
           @"yibang",@"一邦快递",
           @"yuntong",@"运通快递",
           @"yzjc",@"元智捷诚快递",
           @"yuanfeihang",@"原飞航快递",
           @"yafeng",@"亚风快递",
           @"ycwl",@"远成物流",
           @"yuefeng",@"越丰快递",
           @"yousu",@"优速快递|UC优速快递",
           @"zhongtong",@"中通",
           @"zjs",@"宅急送",
           @"zhongtie",@"中铁快运",
           @"zhongyou",@"中邮物流",
           @"zmkm",@"芝麻开门",
           @"zzjh",@"郑州建华快递",
           @"ztwy",@"中天万运快递",
           
           nil];
    */
    dic=[NSDictionary dictionaryWithObjectsAndKeys:
        @"zhongtong",@"喜来快递",
        @"huitong",@"汇通快递",
        @"shentong",@"申通快递",
        @"yuantong",@"圆通快递",
        @"zhongtong",@"中通快递",
        @"shunfeng",@"顺丰快递",
        @"yunda",@"韵达快递",nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    kuaidiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 304, 40)];
    kuaidiLabel.backgroundColor = [UIColor clearColor];
    kuaidiLabel.text = @"喜来快递";

    [changButton addSubview:kuaidiLabel];
    [self getData];
    tempData=[[NSMutableData alloc]initWithCapacity:20];
    resultString=[[NSMutableString alloc]initWithCapacity:20];
    tempDict=[[NSMutableDictionary alloc]initWithCapacity:20];
    tempStr=[[NSMutableString alloc]initWithCapacity:10];
    tDict=[[NSMutableDictionary alloc]initWithCapacity:20];
    cityView.hidden=YES;
    
    wait = [[WaitView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
    wait.reloadLable.adjustsFontSizeToFitWidth = YES;
    
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doRight)];
    [right setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:right];
}
-(void)doRight
{
    [numCardTextFeild resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)doback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doSearch:(id)sender
{
    textView.text=@"";
    // self.tempDict=nil;
    //self.tDict=nil;
    [numCardTextFeild resignFirstResponder];
    
    
    if (numCardTextFeild.text.length==0||kuaidiLabel.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"输入信息不完整" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if(![kuaidiLabel.text isEqualToString:@"请选择快递类型："])
    {
        NSString *str= kuaidiLabel.text;
        NSString *stemp=[[NSString alloc]init];
        for (NSString *s in  [dic allKeys])
        {
            if ([str isEqualToString:s])
            {
                stemp= [dic objectForKey:str];
            }
            
        }
        //        [actIndicator startAnimating];
        [self.view addSubview:wait];
        [wait.activityView startAnimating];
        [self.view setUserInteractionEnabled:NO];
        NSString *urlStr = [NSString stringWithFormat:URLAPI,[numCardTextFeild.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],stemp ];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0f];
        
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请选择快递类型！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

}

- (IBAction)changStyle:(id)sender
{
    [numCardTextFeild resignFirstResponder];
    if (cityView.hidden==YES)
    {
        cityView.hidden = NO;
    }
    else
    {
        cityView.hidden = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    textView.text=nil;
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *fla=@"flag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fla];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:fla] ;
    }
    
    //获取选中行的值
    int selectedRow = (int)[indexPath row];
    //设置cell的文本
    cell.textLabel.text = [[dic allKeys]
                           objectAtIndex:selectedRow];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [numCardTextFeild resignFirstResponder];
    
    kuaidiLabel.text=[[dic allKeys] objectAtIndex:indexPath.row] ;
    kuaidiLabel.textColor = [UIColor blackColor];
    
    cityView.hidden=YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [[dic allKeys] count];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)background:(id)sender
{
    [numCardTextFeild resignFirstResponder];
    if (cityView.hidden==YES)
    {
        cityView.hidden=NO;
        
    }
    else
    {
        cityView.hidden=YES;
    }
}

- (void)lastPress:(id)sender
{
    [numCardTextFeild resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self doTap];
}
-(void)doTap
{
    [numCardTextFeild resignFirstResponder];
    cityView.hidden = YES;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response success");
}
//接收数据时使用
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接受数据");
    [tempData appendData:data];
//    NSLog(@"ppp%@",tempData);
    
}
//结束请求时
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"请求结束");
    
    //创建一个解析器
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:tempData];
    //设置代理
    xmlParser.delegate = self;
    //开始进行解析
    BOOL fla = [xmlParser parse];
    if (fla)
    {
        NSLog(@"解析成功");
    }
    else
    {
        NSLog(@"解析失败");
        textView.text=@"数据异常 请稍后再试!";
        //        NSLog(@"temp%@",tempData);
    }
    
    //    [actIndicator stopAnimating];
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    [self.view setAlpha:1.0f];
    [tempData setData:nil];
    
    
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
    
    //    [actIndicator stopAnimating];
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    [self.view setUserInteractionEnabled:YES];
    [self.view setAlpha:1.0f];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误提示" message:@"请检查输入是否正确或网络是否连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    // [alert release];
}
#pragma ---NSXMLParser协议
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"parser did start");
    
}

//每行开始标志时调用
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    NSLog(@"111111");
    if ([elementName isEqualToString:@"Data"])
    {
        flag = YES;
    }
    
    
}

//每行遇到数据时就调用，包括空格和回车
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //    NSLog(@"222222");
    if (flag)
    {
        [resultString appendString:string];
    }
    
    [tempStr setString:@""];
    [tempStr appendString:string];
    
}
//每行遇到结束标志时，调用
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    //    NSLog(@"33333");
    NSString *holdStr = [NSString stringWithFormat:@"%@",resultString];
    NSString *hold=[NSString stringWithFormat:@"%@",tempStr];
    
    if ([elementName isEqualToString:@"ID"])
    {
        [tDict setObject:hold forKey:@"ID" ];
    }
    if ([elementName isEqualToString:@"Name"])
    {
        [tDict setObject:hold forKey:@"Name"];
    }
    if ([elementName isEqualToString:@"Order"])
    {
        [tDict setObject:hold forKey:@"Order"];
        
    }
    if ([elementName isEqualToString:@"Num"])
    {
        [tDict setObject:hold forKey:@"Num"];
        
    }
    if ([elementName isEqualToString:@"UpdateTime"])
    {
        [tDict setObject:hold forKey:@"UpdateTime"];
        
    }
    if ([elementName isEqualToString:@"Message"])
    {
        [tDict setObject:hold forKey:@"Message"];
    }
    if ([elementName isEqualToString:@"ErrCode"])
    {
        [tDict setObject:hold forKey:@"ErrCode"];
        
    }
    if ([elementName isEqualToString:@"Status"])
    {
        [tDict setObject:hold forKey:@"Status"];
    }
    if ([elementName isEqualToString:@"Data"])
    {
        [tempDict setObject:holdStr forKey:@"Data"];
        flag = NO;
        
    }
    if ([[tDict objectForKey:@"Status"]isEqualToString:@"1"])
    {
        textView.text=@"暂无记录!";
    }
    else
    {
        textView.text=[tempDict objectForKey:@"Data"];
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
