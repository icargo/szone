//
//  MainTabBarVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/14.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "MainTabBarVC.h"
#import "CustomTabButton.h"
#import "BaseNaviVC.h"
#import "PhotoCollectionVC.h"
#import "PaizhaoVC.h"
#import "MoreTableVC.h"
#import "iCamera.h"


@interface MainTabBarVC ()<iCameraFunDelegate>
@property (nonatomic,strong)UIImageView *tabBarView;
@property (nonatomic,strong)UIButton *selectedBtn;
@property (nonatomic,strong)iCamera *iCamera;
@property (nonatomic)BOOL isCamera;
@end

@implementation MainTabBarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewControllers];
    [self initTabBarView];
    _isCamera=YES;
    _iCamera = [[iCamera alloc]init];
    _iCamera.iCameraDelegate = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [_iCamera iCameraServerStart];//开启WiFi模块
    //[_iCamera iCameraAudioPlay];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_iCamera iCameraImgStop];
    [_iCamera iCameraServerStop];
}
-(void)initViewControllers{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    button.frame = CGRectMake(15, 8.6, WIDTH/12, WIDTH/12);
    //button.center = CGPointMake(WIDTH/11, WIDTH/15);
    [button addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    PhotoCollectionVC *photosVC = [[PhotoCollectionVC alloc]initWithNibName:@"PhotoCollectionVC" bundle:nil];
    PaizhaoVC *paizhaoVC = [[PaizhaoVC alloc]init];
    MoreTableVC *moreVC = [[MoreTableVC alloc]init];
    
    NSArray *views = @[photosVC,paizhaoVC,moreVC];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (UIViewController*view in views) {
        BaseNaviVC *navi = [[BaseNaviVC alloc]initWithRootViewController:view];
        [viewControllers addObject:navi];
    }
    self.viewControllers = viewControllers;
}

-(void)initTabBarView{
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEIGHT-48, WIDTH, 48)];
    _tabBarView.image = [UIImage imageNamed:@"tabbar_bg"];
    _tabBarView.userInteractionEnabled = YES;
    [self.view addSubview:_tabBarView];
    
    CustomTabButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CustomTabButton *paizhaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CustomTabButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    photoBtn.frame = CGRectMake(0, 0, 31, 40);
    paizhaoBtn.frame = CGRectMake(0, 0, 80, 40);
    moreBtn.frame = CGRectMake(0, 0, 31, 40);
    photoBtn.center = CGPointMake(WIDTH/7.2, 24);
    paizhaoBtn.center = CGPointMake(WIDTH/2, 24);
    moreBtn.center = CGPointMake(WIDTH/1.16, 24);
    NSArray *tabbarBtns = @[photoBtn,paizhaoBtn,moreBtn];
    
    NSArray *tabbarImages = @[@"tabbar_tupian",@"tabbar_paizhao",@"tabbar_more"];
    NSArray *tabbarSelImages = @[@"tabbar_tupian_sel",@"tabbar_paizhao_sel",@"tabbar_more_sel"];
//    NSArray *tabbarEnImages = @[@"tabbar_tupian_en",@"tabbar_paizhao_en",@"tabbar_more_en"];
//    NSArray *tabbarEnSelImages = @[@"tabbar_tupian_selen",@"tabbar_paizhao_selen",@"tabbar_more_selen"];
    
    for (int i=0; i<tabbarBtns.count; i++) {
        CustomTabButton *btn = tabbarBtns[i];
        [btn setImage:[UIImage imageNamed:tabbarImages[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:tabbarSelImages[i]] forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:btn];

        //设置刚进入时,第二个按钮为选中状态
        if (1 == i) {
            btn.selected = YES;
            _selectedBtn = btn;  //设置该按钮为选中的按钮
            self.selectedIndex = 1;
        }
    }
}

//自定义TabBar的按钮点击事件
-(void)selectedTab:(UIButton*) btn{
    //1.先将之前选中的按钮设置为未选中
    _selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    btn.selected = YES;
    //3.最后把当前按钮赋值给之前选中的按钮
    _selectedBtn = btn;
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = btn.tag;
    if (btn.tag!=1) {
        _isCamera=NO;
    }
    if (btn.tag==1&&_selectedBtn.selected==YES) {
        if ( !_isCamera)
           _isCamera=YES;
         else [self paizhao];
    }
}
-(void)paizhao{
    [iCamera SnapPhoto:true :true];
    NSString *nstrPath=[iCamera documentsPath:@"Image"];
    NSLog(@"拍照了:%@",nstrPath);
}


-(void)backToFront{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"backTofrontVC");
}
@end
