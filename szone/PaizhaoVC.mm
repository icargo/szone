//
//  PaizhaoVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/17.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "PaizhaoVC.h"

@interface PaizhaoVC (){
    UIImageView *divideIV;
    UIImageView *playIV;
}

@end

@implementation PaizhaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测量拍照";
    
    playIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black"]];
    divideIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image_divide"]];
    //divideIV.userInteractionEnabled = YES;
    [self.view addSubview:playIV];
    [self.view addSubview:divideIV];

    _iCamera = [[iCamera alloc]init];
    _iCamera.iCameraDelegate = self;
    NSLog(@"模块版本:%@",[_iCamera iCameraGetVersion]);
}

-(void)viewDidAppear:(BOOL)animated{
    [_iCamera iCameraServerStart];//开启WiFi模块
    [_iCamera iCameraAudioPlay];
    [_iCamera iCameraImgPlay:playIV];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_iCamera iCameraImgStop];
    [_iCamera iCameraServerStop];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillLayoutSubviews{
    playIV.frame = CGRectMake(0, 0, WIDTH, HEIGHT-WIDTH/1.7-92);
    divideIV.frame = CGRectMake(0, HEIGHT-WIDTH/1.7-92, WIDTH, WIDTH/1.7);
}

//-(IBAction)TouchUpInsideSnapPhoto:(id)sender
//{
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.7f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
//    
//    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [UIView commitAnimations];
//    [self.view addSubview:lblRecordTime];
//    [self.view addSubview:m_pViewTop];
//    
//    [iCamera SnapPhoto:true :true];



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
