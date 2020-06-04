//
//  ZhiFaApi.h
//  Courier
//
//  Created by 智发 on 14-6-25.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import "PostGoodsList.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "XYZPointAnnotation.h"
#define getZhiFaData [ZhiFaApi ChongZai]
//    服务器地址http://115.28.78.87:8080/kdb_server/
#define mainUrl [NSURL URLWithString:@"http://115.28.78.87:8080/kdb_server/"]//正确
//#define mainUrl [NSURL URLWithString:@"http://192.168.0.122:8080/kdb_server/"]

@interface ZhiFaApi : NSObject

+(ZhiFaApi *)ChongZai;
/**
 *数据请求
 *  @param      temp    url连接
 *  @param      type    参数
 *  @return     data    返回数据
 */
-(NSData *)getRequestData:(NSURL *)temp andType:(NSString *)type;
/**
 *获取周围快递员
 *  @param      place   位置信息
 *  @return     array   数据数组
 */
-(NSArray *)getCourierInfo:(NSString *)place;
/**
 *发货
 *  @param      param   参数
 *  @return     bool    发货结果
 */
-(NSDictionary *)sendThings:(NSString *)param;
/**
 *获取用户发货单
 *  @param      phoneNumber     用户电话号码
 *  @return     array           数据数组
 */
-(NSMutableArray *)getUsersInvoice:(NSString *)phoneNumber;
/**
 *删除发货单
 *  @param      singleid        表单ID
 *  @return     nsstring            删除是否成功
 */
-(NSString *)deleteUserSingle:(NSString *)SingleID;
/**
 *获取发货单抢单快递员
 *  @param      param           参数列表
 *  @return     获取快递员抢单
 */
-(NSDictionary *)getCourierGoods:(NSString *)param;
/**
 *重新发送或撤单
 *  @param      param           参数列表
 *  @return     bool            
 */
-(NSString *)aginSend:(NSURL *)temp andParam:(NSString *)param;
/**
 *收货确认
 *  @param      param            货单id
 *  @return     收货确认
 */
-(NSString *)tradFinish:(NSString *)param;
/**
 *付款结果发送到服务器
 *  @param      param            
 *  @return     收货确认
 */
-(NSString *)getDataFromZhifuBao:(NSString *)param;
/**
 *绑定支付宝账号
 *  @param      param           用户ID 支付宝账号
 *  @return     结果
 */
-(NSString *)BinDingAliPayID:(NSString *)param;
/**
 *上传快递单号
 *  @param      param           交易ID 快递单号
 *  @return     结果
 */
-(NSString *)DoUpLoadCourierNumber:(NSString *)param;
//评价完成上传服务器
-(NSString *)getDataFromEvalute:(NSString *)param;
//上传积分
-(NSString *)getUserjife:(NSString *)param;
//获得快递员积分
-(NSDictionary *)getDataFromjife:(NSString *)param;
@end
