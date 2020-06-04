//
//  PostGoodsList.m
//  Courier
//
//  Created by 智发 on 14-6-26.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//

#import "PostGoodsList.h"

@implementation PostGoodsList

@synthesize address;
@synthesize cusUpload;
@synthesize empCom;
@synthesize empName;
@synthesize empState;
@synthesize empTel;
@synthesize emp_id;
@synthesize finishtime;
@synthesize first;
@synthesize gettime;
@synthesize _id;
@synthesize lat;
@synthesize len;
@synthesize lon;
@synthesize name;
@synthesize state;
@synthesize tel;
@synthesize time;
@synthesize paystate;
@synthesize cusExpnum;
@synthesize payway;
@synthesize pricesyso;
@synthesize jifenStaste;

-(void)dealloc
{
    self.address = nil;
    self.empCom = nil;
    self.empName = nil;
    self.empState = nil;
    self.empTel = nil;
    self.emp_id = nil;
    self.first = nil;
    self.gettime = nil;
    self._id = nil;
    self.lat = nil;
    self.len = nil;
    self.lon = nil;
    self.name = nil;
    self.state = nil;
    self.tel = nil;
    self.time = nil;
    self.paystate = nil;
    self.jifenStaste=nil;
    [super dealloc];
}

@end
