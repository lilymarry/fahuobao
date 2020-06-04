//
//  ZhiFaApi.m
//  Courier
//
//  Created by 智发 on 14-6-25.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//
#import "ZhiFaApi.h"
@implementation ZhiFaApi
static ZhiFaApi *allData=nil;
+(ZhiFaApi *)ChongZai
{
    if (allData==nil)
    {
        allData=[[ZhiFaApi alloc]init];
    }
    return allData;
}
#pragma mark 数据请求
-(NSData *)getRequestData:(NSURL *)temp andType:(NSString *)type
{
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc]initWithURL:temp cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    [mutableRequest setHTTPMethod:@"POST"];
    NSData *data = [type dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:data];
    NSData *received = [NSURLConnection sendSynchronousRequest:mutableRequest returningResponse:nil error:nil];
    return received;
}
#pragma mark 获取周边快递员信息
-(NSArray *)getCourierInfo:(NSString *)place
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@cus/place.do?",mainUrl,nil]];
    NSData *data = [self getRequestData:temp andType:place];
    
    if (data.length>5)
    {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      //  NSLog(@"array =%@",array);
        NSMutableArray *InfoArray = [[NSMutableArray alloc]init];
        for (NSDictionary *tempDic in array)
        {    //  NSLog(@"******%@",tempDic);
            if (tempDic.count!=0)
            {
                float jing = [[tempDic valueForKey:@"jing"] floatValue];
                float wei = [[tempDic valueForKey:@"wei"] floatValue];
                CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(wei, jing);
                XYZPointAnnotation *temp = [[XYZPointAnnotation alloc]init];
                temp.coordinate = coor2d;
                temp.empName = [tempDic valueForKey:@"name"];
                temp.empTel = [tempDic valueForKey:@"tel"];
                temp.compayName = [tempDic valueForKey:@"company"];
                [InfoArray addObject:temp];
            }
        }
        return InfoArray;
    }
    return nil;
}
#pragma mark 发货
-(NSDictionary *)sendThings:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@cus/send.do?",mainUrl,nil]];
    NSData *data = [self getRequestData:temp andType:param];
    if (data.length>5)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return dic;
    }
    return nil;
}
#pragma mark 获取用户表单
-(NSArray *)getUsersInvoice:(NSString *)phoneNumber
{
//    exp/cusOrdAfrw.do?
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/cusOrdAfrw.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:[NSString stringWithFormat:@"phone=%@",phoneNumber]];
    if (data.length>5)
    {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      //  NSLog(@"NSArray  ---%@",array);
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        if (array.count==0)
        {
            return nil;
        }
        else
        {
            @try {
                for (NSDictionary *temp in array)
                {
//                    NSLog(@"%@",temp);
                    PostGoodsList *postList = [[PostGoodsList alloc]init];
                    postList.address = [temp valueForKey:@"address"];
                    postList.cusUpload = [temp valueForKey:@"cusUpload"];
                    postList.empCom = [temp valueForKey:@"empCom"];
                    postList.empName = [temp valueForKey:@"empName"];

                    postList.empState = [temp valueForKey:@"empState"];
                    postList.empTel = [temp valueForKey:@"empTel"];
                    //            postList.emp_id
                    postList.finishtime = [temp valueForKey:@"finishtime"];
                    postList.first = [temp valueForKey:@"first"];
                    postList.gettime = [temp valueForKey:@"gettime"];
                    postList._id = [temp valueForKey:@"id"];
                    postList.lat = [temp valueForKey:@"lat"];
                    postList.len = [temp valueForKey:@"len"];
                    postList.lon = [temp valueForKey:@"lon"];
                    postList.name = [temp valueForKey:@"name"];
                    postList.state = [temp valueForKey:@"state"];
                    postList.tel = [temp valueForKey:@"tel"];
                    postList.time = [temp valueForKey:@"time"];
                    postList.paystate = [temp valueForKey:@"paystate"];
                    postList.cusExpnum = [temp valueForKey:@"cusExpnum"];
                    
                    postList.payway = [temp valueForKey:@"payway"];
                    
                    postList.pricesyso = [temp valueForKey:@"pricesyso"];
                    
                    
                    postList.jifenStaste=[temp valueForKey:@"comment"];
                    
                    
                    [tempArray addObject:postList];
                }
            }
            @catch (NSException *exception) {
//                NSLog(@"异常");
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                NSLog(@"%@",dic);
            }
            return tempArray;
        }
    }
    return nil;
}
#pragma mark    删除是否成功
-(NSString *)deleteUserSingle:(NSString *)SingleID
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/deteord.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:[NSString stringWithFormat:@"id=%@",SingleID]];
    
    if (data.length>5)
    {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return [dic valueForKey:@"result"];
    }
    return nil;
}
#pragma mark --快递员枪单--
-(NSDictionary *)getCourierGoods:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@cus/getsend.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:param];
    if (data.length>5)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return dic;
    }
    return nil;
}
#pragma mark 从新发送或撤单
-(NSString *)aginSend:(NSURL *)temp andParam:(NSString *)param
{
    NSData *data = [self getRequestData:temp andType:param];
    if (data.length>2)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@",dic);
        return [dic valueForKey:@"result"];
    }
    return nil;
}
#pragma mark 确认收货
-(NSString *)tradFinish:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/orderAfrw.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:param];
//    NSLog(@"%@",data);
    if (data.length>0)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@"%@",dic);
        if ([[dic valueForKey:@"result"] isEqualToString:@"ok"])
        {
            return @"ok";
        }
    }
    return @"err";
}
//支付请求结果
-(NSString *)getDataFromZhifuBao:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@pay/pay.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:param];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
   
    
    if ([[dic valueForKey:@"result"] isEqualToString:@"error"])
    {
        return @"err";
    }
    else
    {
        return @"ok";
    }
}
//上传用户对快递员的评价
-(NSString *)getDataFromEvalute:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/appraiseinfo.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:param];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
   //  NSLog(@"getDataFromEvalute:%@",dic);
    
    if ([[dic valueForKey:@"result"] isEqualToString:@"error"])
    {
        return @"err";
    }
    else
    {
        return @"ok";
    }
}

#pragma mark 绑定账号
-(NSString *)BinDingAliPayID:(NSString *)param
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/bindpayzh.do?",mainUrl]];
    NSData *data = [self getRequestData:url andType:param];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [dic valueForKey:@"result"];
}
#pragma mark 上传快递单号
-(NSString *)DoUpLoadCourierNumber:(NSString *)param
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/CouNum.do?",mainUrl]];
    NSData *data = [self getRequestData:url andType:param];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [dic valueForKey:@"result"];
}
//获得快递员评价数据
-(NSDictionary *)getDataFromjife:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@exp/InfoOrder.do?",mainUrl]];
    NSData *data = [self getRequestData:temp andType:param];
 
    if (data.length>5)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return dic;
    }
    return nil;
}
//得到本机用户积分
-(NSString *)getUserjife:(NSString *)param
{
    NSURL *temp = [NSURL URLWithString:[NSString stringWithFormat:@"%@cus/getcus.do?",mainUrl]];
    
    NSData *data = [self getRequestData:temp andType:param];
    if (data.length>5)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
 
        NSString *st=[dic objectForKey:@"point"];
   
        return st;
    }
    return nil;
}

@end
