//
//  PostGoodsListCell.h
//  Courier
//
//  Created by 智发 on 14-6-26.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonClickDelegate <NSObject>

-(void)uploadListClick:(id)object;//传递整个cell的对象

@end
@protocol GestureDelegate <NSObject>

-(void)longPressGestureAction:(id)object;
-(void)tapGestureAction:(id)object;

@end

@interface PostGoodsListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *ActionButton;
@property(nonatomic,assign)id buttonDelegate;
@property(nonatomic,assign)id gestureDelegate;
@property (weak, nonatomic) IBOutlet UILabel *gettimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *empnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *empComLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *CourierNumber;
@property (strong, nonatomic) IBOutlet UILabel *paypric;

@property (strong , nonatomic) NSString *stateString;
@property (strong , nonatomic) NSString *ordString;
@property (strong , nonatomic) NSString *cusString;//面单状态
@property (strong , nonatomic) NSString *paystate;//支付状态
@property (strong , nonatomic) NSString *payway;

@property(strong, nonatomic)NSString *pijiaState;//评价状态

@property (strong, nonatomic) IBOutlet UILabel *tishiLable;

@end
