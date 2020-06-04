//
//  XYZPaopaoView.h
//  xilaikd
//
//  Created by 智发 on 14-7-17.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PaopaoViewBtnDelegate<NSObject>

-(void)btnWithCourieTel:(NSString *)empTel CourieName:(NSString *)empName andCourieCompay: (NSString *)company;

@end
@interface XYZPaopaoView : UIView
@property (nonatomic, assign)id<PaopaoViewBtnDelegate>delegate;

@property(nonatomic , strong)UILabel *empName;
@property(nonatomic , strong)UILabel *empTel;
@property(nonatomic , strong)UILabel *company;
@property(nonatomic,  strong)UIButton *paopaoImage;
@end
