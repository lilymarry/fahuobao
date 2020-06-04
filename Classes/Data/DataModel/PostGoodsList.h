//
//  PostGoodsList.h
//  Courier
//
//  Created by 智发 on 14-6-26.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostGoodsList : NSObject

@property(nonatomic,retain)NSString *address;// 地址
@property(nonatomic,retain)NSString *cusUpload;//上传面单状态
@property(nonatomic,retain)NSString *empCom;//公司 员工 状态  员工电话 员工ID编号
@property(nonatomic,retain)NSString *empName;
@property(nonatomic,retain)NSString *empState;
@property(nonatomic,retain)NSString *empTel;
@property(nonatomic,retain)NSString *emp_id;
@property(nonatomic,retain)NSString *finishtime;//完成时间
@property(nonatomic,retain)NSString *first;
@property(nonatomic,retain)NSString *gettime;
@property(nonatomic,retain)NSString *_id;
@property(nonatomic,retain)NSString *lat;
@property(nonatomic,retain)NSString *len;
@property(nonatomic,retain)NSString *lon;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *state;//订单状态
@property(nonatomic,retain)NSString *paystate;//支付状态
@property(nonatomic,retain)NSString *cusExpnum;//快递单号
@property(nonatomic,retain)NSString *payway;
@property(nonatomic,retain)NSString *pricesyso;

@property(nonatomic,retain)NSString *jifenStaste;//积分状态

@property(nonatomic,retain)NSString *tel;
@property(nonatomic,retain)NSString *time;

@end
