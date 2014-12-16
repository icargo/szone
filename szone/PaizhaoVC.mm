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
#import <AudioToolbox/AudioToolbox.h>

@interface PaizhaoVC (){
    UIImageView *divideIV;
    UIImageView *playIV;
}
@property(nonatomic)int count;
@end

@implementation PaizhaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 0;
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

/**
 *截图功能
 */
-(void)snapshot{
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/photoShutter.caf"];
    //注册服务
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    AudioServicesPlaySystemSound(soundID);

    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    //animation.subtype = @"fromLeft";//控制动画的方向`fromLeft', `fromRight', `fromTop' and `fromBottom'//    cube suckEffect oglFlip rippleEffect pageCurl pageUnCurl cameraIrisHollowOpen cameraIrisHollowClose
    animation.duration = .7;
    animation.delegate = self;
    [playIV.layer addAnimation:animation forKey:@"animation"];
        
    CGSize imageSize = CGSizeMake(WIDTH, HEIGHT-WIDTH/1.7-92);
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    
    //设置截屏大小
    
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = playIV.frame;//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    
    //以下为图片保存代码
    //UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //获得系统日期
    NSDate *currentDate = [NSDate date];
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [calendar components:unitFlags fromDate:currentDate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"image"];
    NSString * imageFile = [NSString stringWithFormat:@"%4d%02d%02d",year,month,day];
    imagePath = [imagePath stringByAppendingPathComponent:imageFile];

    //判断路径是否存在
    BOOL isDrectory = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:imagePath isDirectory:&isDrectory];
    if (!(isExist&&isDrectory)) [fm createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    _count++;
    NSString * imageName = [NSString stringWithFormat:@"%4d%02d%02d%d.png",year,month,day,_count];
    
    NSString *savedImagePath = [imagePath stringByAppendingPathComponent:imageName];
    NSLog(@"savedImagePath:%@",savedImagePath);
    
    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    CGImageRelease(imageRefRect);
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
