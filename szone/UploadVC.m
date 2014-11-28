//
//  UploadVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/18.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "UploadVC.h"
#import "UploadView.h"
@interface UploadVC (){
    UIImageView *backgroundIV;
    UIImageView *naviBar;
    UIButton *btn;
    UILabel *titleLb;
    
    UILabel *dateLb;
    UILabel *tempLb;
    UIButton *uploadBtn;
}
@property(nonatomic,strong)UIImageView *uploadIV;
@end

@implementation UploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传";
    backgroundIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    backgroundIV.userInteractionEnabled = YES;
    
    naviBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navi_bar"]];
    naviBar.userInteractionEnabled = YES;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/8, WIDTH/10)];
    titleLb.font = [UIFont boldSystemFontOfSize:20];
    titleLb.textColor = [UIColor whiteColor];
    titleLb.text = @"上传";
    
    [naviBar addSubview:btn];
    [naviBar addSubview:titleLb];
    
    _uploadIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.5, WIDTH/2.5)];
    _uploadIV.image = [UIImage imageNamed:@"logo"];
    _uploadIV.layer.borderWidth = 4;
    _uploadIV.layer.borderColor = [UIColor whiteColor].CGColor;
    _uploadIV.layer.shadowOffset = CGSizeMake(0,0);
    _uploadIV.layer.shadowOpacity = 1;
    _uploadIV.layer.shadowColor = [UIColor grayColor].CGColor;
    _uploadIV.layer.shadowPath = [UIBezierPath bezierPathWithRect:_uploadIV.bounds].CGPath;

    dateLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2, WIDTH/10)];
    tempLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.8, WIDTH/8)];
    dateLb.font = [UIFont systemFontOfSize:16];
    tempLb.font = [UIFont systemFontOfSize:32];
    
    NSDateFormatter *nowDate=[[NSDateFormatter alloc] init];
    //定义时间的显示格式, 再格式化当前的时间
    [nowDate setDateFormat:@"yyyy/MM/dd/HH:mm:ss"];
    NSString *date=[nowDate stringFromDate:[NSDate date]];
    dateLb.text = date;
    tempLb.text = [NSString stringWithFormat:@"温度:36.7℃"];
    
    uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setBackgroundImage:[UIImage imageNamed:@"commit_btn"] forState:UIControlStateNormal];
    uploadBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backgroundIV];
    [backgroundIV addSubview:naviBar];
    [backgroundIV addSubview:_uploadIV];
    
    [backgroundIV addSubview:dateLb];
    [backgroundIV addSubview:tempLb];
    [backgroundIV addSubview:uploadBtn];
}
-(void)backAction{//返回
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)uploadAction{//上传
    UploadView *uploadView = [[UploadView alloc]initWithFrame:CGRectMake(-WIDTH, -WIDTH, WIDTH*7/8, HEIGHT*7/8)];
    uploadView.layer.cornerRadius = 5;
    uploadView.layer.masksToBounds = YES;
    [self.view addSubview:uploadView];
    [UIView animateWithDuration:.3 animations:^ {
        uploadView.center = CGPointMake(WIDTH/2, HEIGHT/2);
    }completion:^(BOOL finished){
        self.view.alpha = .9;
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillLayoutSubviews{
    backgroundIV.frame = [UIScreen mainScreen].bounds;
    naviBar.frame = CGRectMake(0, 0, WIDTH, WIDTH/7.3);
    btn.frame = CGRectMake(0, 0, WIDTH/12, WIDTH/12);
    btn.center = CGPointMake(30, WIDTH/14.6);
    titleLb.center = CGPointMake(WIDTH/2, WIDTH/14.6);
    
    _uploadIV.center = CGPointMake(WIDTH/2, WIDTH/2.1);
    dateLb.center = CGPointMake(WIDTH/2, WIDTH/1.35);
    tempLb.center = CGPointMake(WIDTH/2, WIDTH/1.1);
    uploadBtn.frame = CGRectMake(0, 0, WIDTH/3, WIDTH/9);
    uploadBtn.center = CGPointMake(WIDTH/2, WIDTH*1.1);
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
