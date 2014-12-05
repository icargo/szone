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

/**
 *截图功能
 */
//-(void)screenShot{
//    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
//    
//    //设置截屏大小
//    
//    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    CGImageRef imageRef = viewImage.CGImage;
//    CGRect rect = CGRectMake(0, 0, 641, SCREEN_HEIGHT + 300);//这里可以设置想要截图的区域
//    
//    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
//    
//    
//    //以下为图片保存代码
//    
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
//    
//    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName= @"screenShow.png";
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//    
//    CGImageRelease(imageRefRect);
//    
//    
//    
//    //从手机本地加载图片
//    
//    UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
//    
//    
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
