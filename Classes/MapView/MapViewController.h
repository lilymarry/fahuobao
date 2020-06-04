//
//  MapViewController.h
//  Fahuobao
//
//  Created by 智发 on 14-8-7.
//  Copyright (c) 2014年 西安智发网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import <QuartzCore/QuartzCore.h>
#import "ZhiFaApi.h"
#import "WaitView.h"
#import "APService.h"
#import "XYZAlertview.h"
#import "XYZPointAnnotation.h"
#import "XYZPaopaoView.h"
#import "XYZError.h"
#import "SendExpress.h"
@interface MapViewController : UIViewController<BMKMapViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,okButtonDelegate,BMKSearchDelegate,PaopaoViewBtnDelegate>
{
    WaitView *wait;
     BMKMapView *_mapView;
    IBOutlet UIButton *start;
    IBOutlet UIButton *send;
    IBOutlet UIButton *home;
    IBOutlet UIButton *zoom;
    IBOutlet UIButton *sub;
    IBOutlet UIView *loadView;
    IBOutlet UILabel *waitLabel;
    IBOutlet UIActivityIndicatorView *waitActi;
    
    IBOutlet UIView *mapDiCeng;
    CLLocationCoordinate2D usersCoor2D;
    NSString *userAddress;
    NSString *userTel;
    BMKPointAnnotation *point;
    NSArray *CourierInfo;
    XYZAlertview *SelfAlertView;
    BOOL isSendSucc;
    NSString *filePath;
    NSString *dateString;
    NSTimer *goodsTimer;
    BOOL isPush;
    
    XYZError *errorAler;
    NSString *messageString;
    BOOL isFirst;
    
    NSString *courTel;
    NSString *courName;
    NSString *courCompany;
    IBOutlet UIImageView *loadImage;
//    BOOL isSecond;
}
@property(nonatomic , strong)NSMutableArray *mutableArray;
- (IBAction)doSend:(id)sender;
- (IBAction)doLocation:(id)sender;
- (IBAction)pushHome:(id)sender;
//- (IBAction)doSub:(id)sender;
//- (IBAction)doZoom:(id)sender;
@end
