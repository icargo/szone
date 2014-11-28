//
//  PhotoVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/17.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "PhotoVC.h"

@interface PhotoVC (){
    UIImageView *backgroundIV;
    int imageCount;
}
@property(nonatomic,strong)NSMutableArray *photoPaths;
@end

@implementation PhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    
    backgroundIV = [[UIImageView alloc]initWithFrame:CGRectZero];
    backgroundIV.image = [UIImage imageNamed:@"beijing"];
    backgroundIV.userInteractionEnabled = YES;
    [self.view addSubview:backgroundIV];
    
}

-(void)findJpgInPath:(NSString *)path{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:Nil];
    for (NSString *fileName in fileNames) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        
        BOOL isDir;
        if ([fm fileExistsAtPath:filePath isDirectory:&isDir]&&isDir) {//如果是文件夹
            [self findJpgInPath:filePath];//递归继续搜索
        }else{//说明是文件
            if ([filePath hasSuffix:@"jpg"]) {
                NSLog(@"照片路径%@",filePath);
                [_photoPaths addObject:filePath];
                UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(8+imageCount%3*WIDTH/3, 10+imageCount/3*WIDTH/3, 90, 90)];
                iv.layer.cornerRadius = 5;
                iv.layer.masksToBounds = YES;
                iv.image = [UIImage imageWithContentsOfFile:filePath];
                [self.view addSubview:iv];
                imageCount++;
            }
        }
    }
}
//-(void)showPhotos{
//    for (int i=0; i<_photoPaths.count; i++) {
//        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i%4*80, i/4*80, 80, 80)];
//        iv.image = [UIImage imageWithContentsOfFile:imagePaths[i]];
//        [self.mySV addSubview:iv];
//        //给图片添加手势
//        UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
//        //让控件记录自己的位置
//        iv.tag = i;
//        [iv addGestureRecognizer:longP];
//        iv.userInteractionEnabled = YES;
//        
//    }
//    NSLog(@"self.iv count:%d,sv:%d",self.ivs.count,self.mySV.subviews.count);
//    int row = imagePaths.count%4==0?imagePaths.count/4:imagePaths.count/4+1;
//    self.mySV.contentSize = CGSizeMake(0, 80*row);
//
//}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    [self.view setNeedsDisplay];//刷新子控件显示
    _photoPaths = [NSMutableArray array];
    //获取document路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    [self findJpgInPath:documentPath];
    backgroundIV.frame = [UIScreen mainScreen].bounds;
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
