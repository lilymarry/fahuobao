//
//  ScanCourieTableViewCell.m
//  Fahuobao
//
//  Created by 智发 on 14-8-23.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import "ScanCourieTableViewCell.h"

@implementation ScanCourieTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setIntroductionText:(NSString*)text
//{
//    //获得当前cell高度
//    CGRect frame = [self frame];
//    //文本赋值
//    self.pijiaLable.text = text;
//    //设置label的最大行数
//    self.pijiaLable.numberOfLines = 0;
//    
//    CGSize size = CGSizeMake(300, 1000);
//    CGSize labelSize = [self.pijiaLable.text sizeWithFont:self.pijiaLable.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.pijiaLable.frame = CGRectMake(self.pijiaLable.frame.origin.x, self.pijiaLable.frame.origin.y, labelSize.width, labelSize.height);
//    
//    //计算出自适应的高度
//    frame.size.height = labelSize.height+100;
//    
//    self.frame = frame;
//}
@end
