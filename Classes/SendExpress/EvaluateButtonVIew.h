//
//  EvaluateButtonVIew.h
//  Fahuobao
//
//  Created by 智发 on 14-8-20.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol butDelegate <NSObject>

-(void)buttonGrade:(float)grade viewTag:(int)tag  andBtnJifen:(int)jiFen;

@end
@interface EvaluateButtonVIew : UIView
{
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIButton *but4;
    
      int jifen;
 
    
}
@property (nonatomic, assign)id<butDelegate>delegate;
@end
