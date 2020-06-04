//
//  PostGoodsListCell.m
//  Courier
//
//  Created by 智发 on 14-6-26.
//  Copyright (c) 2014年 com.xilaikd. All rights reserved.
//

#import "PostGoodsListCell.h"

@implementation PostGoodsListCell
@synthesize buttonDelegate;
@synthesize gestureDelegate;
@synthesize gettimeLabel;
@synthesize timeLabel;
@synthesize empComLabel;
@synthesize empnameLabel;
@synthesize telLabel;
@synthesize idLabel;
@synthesize stateString;
@synthesize ordString;
@synthesize cusString;
@synthesize CourierNumber;
@synthesize paystate;
@synthesize payway;
@synthesize paypric;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      //        NSLog(@"初始化 1");
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
//     NSLog(@"初始化 2");
    //添加长按手势和轻拍手势
   // self.userInteractionEnabled = YES;
    @autoreleasepool {
    
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
        [self addGestureRecognizer:longPressGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGesture];
    
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)buttonClick:(id)sender
{
   
    if (self.buttonDelegate != nil && [self.buttonDelegate respondsToSelector:@selector(uploadListClick:)]) {
        
        [self.buttonDelegate uploadListClick:self];
    }
}
-(void)longPressAction
{
    if (self.gestureDelegate != nil && [self.gestureDelegate respondsToSelector:@selector(longPressGestureAction:)]) {
        
        for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
            
            if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                
                if (gesture.state == UIGestureRecognizerStateBegan) {
                    
                    [self.gestureDelegate longPressGestureAction:self];
                }
                
            }
        }
        
    }
}
-(void)tapAction
{
    if (self.gestureDelegate != nil && [self.gestureDelegate respondsToSelector:@selector(tapGestureAction:)])
    {
        
        [self.gestureDelegate tapGestureAction:self];
    }
}

@end
