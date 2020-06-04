//
//  XYZError.m
//  xilaikd
//
//  Created by 智发 on 14-7-23.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "XYZError.h"

@implementation XYZError

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark --提示展示--
-(void)erroShow
{
    [super show];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(ErrorHidden) userInfo:nil repeats:NO];
}
#pragma mark --提示消失--
-(void)ErrorHidden
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}
@end
