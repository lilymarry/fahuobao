//
//  MapViewController.m
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "MapViewController.h"
#import "FirstView.h"
#import "ScanCourierViewController.h"
//#import "InfoViewController.h"
@interface MapViewController ()
{
    
}
@end

@implementation MapViewController
@synthesize mutableArray=_mutableArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
       
    }
    return self;
}
#pragma mark 设置弹出框样式
-(void)creatAlertView
{
    SelfAlertView = [[XYZAlertview alloc]initWithFrame:CGRectMake(20.0f, ([[UIScreen mainScreen] bounds].size.height-300)/2, 300.0f, 300)];
//    alertViewRect = SelfAlertView.frame;
    SelfAlertView.tag = 10010;
    SelfAlertView.okDelegate = self;
}
#pragma mark 获取usertel
-(void)getUserTel
{
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userTel"]);
    
   userTel = [[NSUserDefaults standardUserDefaults] objectForKey:@"userTel"];
 //    userTel = @"15399414368";
    if (self.mutableArray==nil)
    {
        self.mutableArray = [[NSMutableArray alloc]init];
    }
    self.mutableArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"DateString"];
}
#pragma mark 视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, mapDiCeng.frame.size.width, mapDiCeng.frame.size.height)];
    _mapView.mapType = BMKMapTypeStandard;
    [mapDiCeng addSubview:_mapView];
    
    if([[[UIDevice currentDevice] systemVersion]intValue]>7.0)
    {
        loadImage.image = [UIImage imageNamed:@"Default-568h@2x"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(theGoodsMove:) name:@"goodsMove" object:nil];
    isPush = NO;
//    isSecond = NO;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        isFirst = YES;
        [self performSegueWithIdentifier:@"pushFirst" sender:nil];
    }
    else
    {
        isFirst = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPushNotification:) name:@"pushNotification" object:nil];
    
    point = [[BMKPointAnnotation alloc]init];
    userAddress = [[NSString alloc]init];
    userTel = [[NSString alloc]init];
    _mapView.zoomLevel = 16;
    _mapView.delegate = self;
    wait = [[WaitView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-110)/2, (self.view.frame.size.height-110)/2, 110, 110)];
    CourierInfo  = [[NSArray alloc]init];
    errorAler = [[XYZError alloc]init];
    errorAler.title = @"温馨提示!";
    BMKLocationViewDisplayParam *DisplayParam = [[BMKLocationViewDisplayParam alloc]init];
    DisplayParam.locationViewOffsetX=1;
    DisplayParam.locationViewOffsetY=1;
    DisplayParam.isAccuracyCircleShow = NO;
    DisplayParam.locationViewImgName = @"user";
    [_mapView updateLocationViewWithParam:DisplayParam];
    
    [self getUserTel];
 
    [self creatAlertView];
    SelfAlertView.phoneNumber.text = userTel;
    if (isFirst == NO)
    {
        loadView.hidden=NO;
       // [self.view addSubview:loadView];
        
       // [self doLocationLocad];
    }
   // start.hidden=YES;
   // tempdic=[[NSDictionary alloc]init];
}
#pragma mark 地图将要出现
-(void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"视图出现");
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        loadView.hidden=NO;
        [self.view addSubview:loadView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [self doLocationLocad];
        // start.hidden=YES;
        
    }
    [_mapView viewWillAppear];
    self.navigationController.navigationBarHidden = YES;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _locationService.delegate = self;
    if (self.mutableArray.count!=0)
    {
        goodsTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(CourierGetGoods) userInfo:nil repeats:YES];
    }
}
#pragma mark 地图将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
//    _locationService.delegate = nil;
    [goodsTimer invalidate];
}
#pragma mark --button代理--
-(void)doButton:(id)sender
{
    //    NSLog(@"button代理是否执行");
    [SelfAlertView.phoneNumber resignFirstResponder];
    [SelfAlertView.Address resignFirstResponder];
    if ([SelfAlertView validateMobile:SelfAlertView.phoneNumber.text]&&SelfAlertView.Address.text.length!=0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:userTel forKey:@"userTel"];
        if (userTel.length == 0 || ![userTel isEqualToString:SelfAlertView.phoneNumber.text])
        {
            userTel = SelfAlertView.phoneNumber.text;
            [[NSUserDefaults standardUserDefaults] setValue:userTel forKey:@"userTel"];
            NSLog(@"%@",userTel);
        }
        [SelfAlertView Hidden];
        wait.reloadLable.text = @"发货中。。。";
        [self.view addSubview:wait];
        [wait.activityView startAnimating];
        self.view.userInteractionEnabled = NO;
        [NSThread detachNewThreadSelector:@selector(SendThings) toTarget:self withObject:nil];
    }
    else
    {
        //            电话或地址为空
        if (![SelfAlertView validateMobile:SelfAlertView.phoneNumber.text])
        {
            //                电话错误
            if (SelfAlertView.Address.text.length==0)
            {
                //                   电话+ 地址为空
                errorAler.message = @"请输入正确的电话号码和地址！";
            }
            else
            {
                errorAler.message = @"请输入正确的电话号码！";
            }
        }
        else
        {
            //                电话正确，地址为空
            errorAler.message = @"请输入正确的联系地址！";
        }
        [errorAler erroShow];
    }
}
#pragma mark 发货了
-(void)SendThings
{
   // NSLog(@"%@",SelfAlertView.companylabel.text);
    NSString *fangshiStr;
    if (SelfAlertView.button1.selected==YES)
    {
        fangshiStr = @"现金";
    }
    else
    {
        fangshiStr = @"网上";
    }
    NSString *jiageStr;
    if (SelfAlertView.button3.selected==YES)
    {
        jiageStr = @"平台";
    }
    else
    {
        fangshiStr = @"协商";
    }
    NSString *iemi = [APService registrionID];
    NSString *version = @"2.0.5";
    NSString *coord = [[NSString alloc]initWithFormat:@";;%f;%f",usersCoor2D.latitude,usersCoor2D.longitude];
    
    NSString *str = [[NSString alloc]initWithFormat:@"tel=%@&site=%@&coords=%@&version=%@&imei=%@&jiage=%@&fangshi=%@&expresschoice=%@",userTel,SelfAlertView.Address.text,coord,version,iemi,jiageStr,fangshiStr,SelfAlertView.companylabel.text];//设置参数
    NSDictionary *dic = [getZhiFaData sendThings:str];
    [self performSelectorOnMainThread:@selector(returnSendThings:) withObject:dic waitUntilDone:YES];
}
#pragma mark --接收返回结果--
-(void)returnSendThings:(NSDictionary *)temp
{
    [wait removeFromSuperview];
    [wait.activityView stopAnimating];
    self.view.userInteractionEnabled = YES;
    if (temp==nil)
    {
        errorAler.message = @"发货失败!";
    }
    dateString = [temp valueForKey:@"date"];
    if ([[temp valueForKey:@"result"] isEqualToString:@"ok"])
    {
//        isSecond = YES;
        
        errorAler.message = [NSString stringWithFormat:@"您的货物是发货宝第%@件货物",[temp valueForKey:@"expcount"]];
        
        isSendSucc = YES;
        [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timerExmple) userInfo:nil repeats:NO];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.mutableArray];
        [temp addObject:dateString];
        self.mutableArray = temp;
        
        [_mapView removeAnnotation:point];
        point.title = @"您的发货信息已发给周围5公里所有的";
        point.subtitle = @"快递员";
        [_mapView addAnnotation:point];
        [_mapView selectAnnotation:point animated:YES];
        
        [[NSUserDefaults standardUserDefaults] setValue:self.mutableArray forKey:@"DateString"];
        
        if (goodsTimer==nil)
        {
            goodsTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(CourierGetGoods) userInfo:nil repeats:YES];
        }
        else
        {
            [goodsTimer fire];
        }
    }
    else
    {
        errorAler.message = @"发货失败!";
    }
    [errorAler erroShow];
}
#pragma mark --快递员接货提醒--
-(void)CourierGetGoods
{
    //    NSLog(@"计时器");
    for (int i=0; i<self.mutableArray.count; i++)
    {
        NSString *tempString = [self.mutableArray objectAtIndex:i];
        NSDictionary *dic = [getZhiFaData getCourierGoods:[NSString stringWithFormat:@"tel=%@&date=%@",userTel,tempString,nil]];
//        NSLog(@"%@",dic);
        if (dic != nil)
        {
            if ([[dic valueForKey:@"result"] isEqualToString:@"ok"])
            {
                [goodsTimer invalidate];
                [_mapView deselectAnnotation:point animated:YES];
                point.title = @"请等待快递人员";
                point.subtitle = @"";
                dateString = nil;
                NSMutableString *mutableString = [[NSMutableString alloc]initWithFormat:@"%@",[dic valueForKey:@"msg"]];
//                NSLog(@"%@",mutableString);
                NSRange rang = [mutableString rangeOfString:@";"];
                [mutableString deleteCharactersInRange:NSMakeRange(rang.location, mutableString.length-rang.location)];
                [mutableString appendString:@"!"];
                [self.mutableArray removeObjectAtIndex:i];
                [[NSUserDefaults standardUserDefaults] setValue:self.mutableArray forKey:@"DateString"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"goodsMove" object:mutableString];
            }
        }
    }
}
#pragma mark --货物被接受---
-(void)theGoodsMove:(NSNotification *)temp
{
//    私有api
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate); //kSystemSoundID_Vibrate系统震动
    NSString *mutableString = [[NSString alloc]initWithFormat:@"%@",[temp object]];
//    NSLog(@"%@",mutableString);
    UIAlertView *tempAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:mutableString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"点击拨打电话", nil];
    tempAlertView.tag = 101;
    [tempAlertView show];
}

#pragma mark 发货按钮事件
- (IBAction)doSend:(id)sender
{
//    if (isSecond == YES)
//    {
//        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"您是否有一件新的货物要发送" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        aler.tag = 102;
//        [aler show];
//    }
//    else
//    {
        [SelfAlertView show];
//    }
}

-(void)doLocationLocad
{
    [waitActi startAnimating];
//    _mapView.showsUserLocation = NO;
    wait.reloadLable.text = @"努力定位中。。。";
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}
#pragma mark 定位按钮
- (IBAction)doLocation:(id)sender
{
//    [_locationService startUserLocationService];
    wait.reloadLable.text = @"努力定位中。。。";
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:wait];
    [wait.activityView startAnimating];
    self.view.userInteractionEnabled = NO;
    
}
#pragma mark 跳转sendExpress

- (IBAction)pushHome:(id)sender
{
    [self performSegueWithIdentifier:@"TabBarVC" sender:nil];
   //[self ];
}
 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"TabBarVC"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:userTel forKey:@"userID"];
  }
    if ([segue.identifier isEqualToString:@"PushScan"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:courTel forKey:@"courierTel"];
        [theSegue setValue:courCompany forKey:@"courCompany"];
        [theSegue setValue:courName forKey:@"courName"];
    }

}
/*
#pragma mark 地图zoomlevel++
- (IBAction)doSub:(id)sender
{
    _mapView.zoomLevel++;
    if (_mapView.zoomLevel == 19.0)
    {
        [sub setBackgroundImage:[UIImage imageNamed:@"selectedsub"] forState:UIControlStateNormal];
        sub.userInteractionEnabled = NO;
    }
    if (zoom.userInteractionEnabled == NO)
    {
        [zoom setBackgroundImage:[UIImage imageNamed:@"zoom"] forState:UIControlStateNormal];
        [zoom setBackgroundImage:[UIImage imageNamed:@"selectedzoom"] forState:UIControlStateHighlighted];
        zoom.userInteractionEnabled = YES;
    }
}
 */
/*
#pragma mark 地图zoomlevel--
-(IBAction)doZoom:(id)sender
{
    _mapView.zoomLevel--;
    if (_mapView.zoomLevel == 3.0)
    {
        [zoom setBackgroundImage:[UIImage imageNamed:@"selectedzoom"] forState:UIControlStateNormal];
        zoom.userInteractionEnabled = NO;
    }
    if (sub.userInteractionEnabled == NO)
    {
        [sub setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        [sub setBackgroundImage:[UIImage imageNamed:@"selectedsub"] forState:UIControlStateHighlighted];
        sub.userInteractionEnabled = YES;
    }
}
 */
#pragma mark 设置大头针
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        if (annotation == point)
        {
            newAnnotationView.image = [UIImage imageNamed:@"user"];
            newAnnotationView.animatesDrop = NO;
        }
        else
        {
            newAnnotationView.image = [UIImage imageNamed:@"couriers"];
            newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
            
            XYZPointAnnotation *temp = (XYZPointAnnotation *)annotation;
            
       
           
            
            XYZPaopaoView *paopaoView = [[XYZPaopaoView alloc]initWithFrame:CGRectMake(0, 0, 140, 80)];
            paopaoView.empName.text = temp.empName;
            paopaoView.empTel.text = temp.empTel;
            paopaoView.empTel.hidden=YES;
            paopaoView.delegate=self;
            paopaoView.company.text = temp.compayName;

           
          newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:paopaoView];
         // [[NSNotificationCenter defaultCenter] postNotificationName:@"temp" object:temp];
        }
        return newAnnotationView;
    }
    return nil;

}

-(void)btnWithCourieTel:(NSString *)empTel CourieName:(NSString *)empName andCourieCompay: (NSString *)company
{
    courTel=empTel;
    courName=empName;
    courCompany=company;
    [self performSegueWithIdentifier:@"PushScan" sender:nil];


}
#pragma mark 在停止定位后，会调用此函数
- (void)didStopLocatingUser
{

}
#pragma mark 在地图View将要启动定位时，会调用此函数
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
    	NSLog(@"start locate");
}
#pragma mark 用户方向更新后，会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//        [_mapView updateLocationData:userLocation];
       // start.hidden=NO;
}
#pragma mark 用户位置更新后，会调用此函数
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
  
    [loadView removeFromSuperview];
    [wait.activityView stopAnimating];
    [wait removeFromSuperview];
    self.view.userInteractionEnabled = YES;
    usersCoor2D = userLocation.location.coordinate;
    BMKSearch *search = [[BMKSearch alloc]init];
    search.delegate=self;
    [search reverseGeocode:userLocation.location.coordinate];
    _mapView.showsUserLocation = NO;
}
#pragma mark 在地图View停止定位后，会调用此函数
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
    point.coordinate = usersCoor2D;
    [_mapView removeAnnotation:point];
    [_mapView addAnnotation:point];
    NSString * coord = [[NSString alloc]initWithFormat:@";;%f;%f",usersCoor2D.latitude,usersCoor2D.longitude];
    NSString *string = [[NSString alloc]initWithFormat:@"place=%@",coord,nil];
    
    [_mapView removeAnnotations:CourierInfo];
    CourierInfo = [getZhiFaData getCourierInfo:string];
    [_mapView addAnnotations:CourierInfo];
}
#pragma mark 定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
#pragma mark 获取到物理地址信息
-(void)onGetAddrResult:(BMKAddrInfo *)result errorCode:(int)error
{
    userAddress = result.strAddr;
    send.userInteractionEnabled = YES;
    SelfAlertView.Address.text = result.strAddr;
}
#pragma mark 地图改变完成
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}
#pragma mark --点中paopaoview---
-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    
}
#pragma mark --获取推送消息--
-(void)getPushNotification:(NSNotification *)notification
{
//    NSLog(@"jpush：   %@",[notification object]);
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[notification object]];
//    NSLog(@"di一步:%@",dic);
//    NSLog(@"第二部:%@",[dic objectForKey:@"aps"]);
    NSDictionary *temp = [dic objectForKey:@"aps"];
//    NSLog(@"第三部！%@",[temp objectForKey:@"alert"]);
    NSString *string = [temp objectForKey:@"alert"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alertViewTemp= [[UIAlertView alloc]init];
    alertViewTemp.tag = 103;
    alertViewTemp.title = @"温馨提示";
    alertViewTemp.delegate = self;

    [alertViewTemp addButtonWithTitle:@"取消"];
    [alertViewTemp addButtonWithTitle:@"确定"];
    if ([string hasPrefix:@"尊敬的用户"])
    {
        alertViewTemp.message = string;
        if (messageString==nil)
        {
            messageString = [[NSString alloc]initWithString:string];
        }
        messageString = string;
    }
    else
    {
        alertViewTemp.message = @"有新的活动，是否查看？";
    }
    [alertViewTemp show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%d",buttonIndex);
    if (alertView.tag==101)
    {
        NSRange range = [alertView.message rangeOfString:@"他的电话是"];
        NSString * courierTel = [alertView.message substringWithRange:NSMakeRange((range.length+range.location), 11)];
        if (buttonIndex==1&&courierTel!=nil)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",courierTel]]];
        }
        else
        {
            ;
        }
        if (self.mutableArray.count!=0)
        {
            goodsTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(CourierGetGoods) userInfo:nil repeats:YES];
        }
    }
    if (alertView.tag==102)
    {
        if (buttonIndex==1)
        {
            [SelfAlertView show];
        }
    }
    if (alertView.tag == 103)
    {
        if (buttonIndex==0)
        {
            ;
        }
        else
        {
            
            if ([alertView.message isEqualToString:messageString])
            {
                ;
            }
            else
            {
                [self performSegueWithIdentifier:@"pushHD" sender:nil];
            }
        }

    }
}
-(void)firstReturn
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    if (isFirst == NO)
    {
        loadView.hidden=NO;
        [self.view addSubview:loadView];
        
        [self doLocationLocad];
    }
}
#pragma mark 计时器测试
-(void)timerExmple
{
   //    NSLog(@"橡胶巴拉");
   //    isSecond = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
