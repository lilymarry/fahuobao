//
//  ScanCourierViewController.h
//  Fahuobao
//
//  Created by 智发 on 14-8-23.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanCourieTableViewCell.h"
@interface ScanCourierViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString * courierTel;
@property(nonatomic,strong)NSString *courCompany;
@property(nonatomic,strong)NSString *courName;
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSMutableArray *contentArr;
@property(nonatomic,strong)NSMutableArray *ratingArr;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;
@property (strong, nonatomic) IBOutlet UILabel *jifenLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLable;
@property (strong, nonatomic) IBOutlet UITableView *EtableView;
@property (strong, nonatomic) IBOutlet UILabel *jieguLable;
- (IBAction)chatPerss:(id)sender;

@end
