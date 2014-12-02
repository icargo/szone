//
//  LoginVC.m
//  szong
//
//  Created by zhuyq-MacBook Pro on 14/11/10.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "LoginVC.h"
#import "UserInfoVC.h"
#import "MainTabBarVC.h"

#import "ComboBox.h"

#define WIDTH   [[UIScreen mainScreen] bounds].size.width
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
@interface LoginVC (){
    UIButton *cnBtn;
    UIButton *enBtn;
}

@property(nonatomic,strong)ComboBox *usernameBox;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)NSMutableArray *loginBtns;
@property(nonatomic,strong)NSArray *cnTitles;
@property(nonatomic,strong)NSArray *enTitles;
@end

@implementation LoginVC

-(BOOL)prefersStatusBarHidden{//隐藏状态栏
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{//隐藏naviBar
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginBtns = [NSMutableArray array];
    [self initUI];
}
-(void)initUI{
//添加背景、手势
    UIImageView *backgroundIV = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundIV.image = [UIImage imageNamed:@"beijing"];
    backgroundIV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [backgroundIV addGestureRecognizer:tap];
    
    [self.view addSubview:backgroundIV];
//切换语言的按钮
    UIButton *yuyanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [yuyanBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_btn"] forState:UIControlStateNormal];
    
    cnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cnBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_cn_sel"] forState:UIControlStateNormal];
    enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [enBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_En"] forState:UIControlStateNormal];
    [cnBtn setHidden:YES];
    [enBtn setHidden:YES];
    [yuyanBtn addTarget:self action:@selector(openChangeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [cnBtn addTarget:self action:@selector(turnCn) forControlEvents:UIControlEventTouchUpInside];
    [enBtn addTarget:self action:@selector(turnEn) forControlEvents:UIControlEventTouchUpInside];
    [yuyanBtn setFrame:CGRectMake(WIDTH-HEIGHT/7.1, 0, HEIGHT/7.1, HEIGHT/30)];
    [cnBtn setFrame:CGRectMake(WIDTH-HEIGHT/7.1, HEIGHT/30, HEIGHT/7.1, HEIGHT/16)];
    [enBtn setFrame: CGRectMake(WIDTH-HEIGHT/7.1, HEIGHT/30+HEIGHT/16, HEIGHT/7.1, HEIGHT/16)];
    
    [self.view addSubview:yuyanBtn];
    [self.view addSubview:cnBtn];
    [self.view addSubview:enBtn];
//添加company、logo
    UIImageView *logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/2.7, WIDTH/3.7)];
    UIImageView *companyIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.4, HEIGHT/40)];
    logoIV.image = [UIImage imageNamed:@"logo"];
    companyIV.image = [UIImage imageNamed:@"company"];
    logoIV.center = CGPointMake(WIDTH/2, HEIGHT/6.5);
    companyIV.center = CGPointMake(WIDTH/2, HEIGHT/3.6);
    
    [self.view addSubview:logoIV];
    [self.view addSubview:companyIV];
//添加两个输入框
    _usernameBox = [[ComboBox alloc]initWithFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
    _usernameBox.center = CGPointMake(WIDTH/2, HEIGHT/2);

    NSMutableArray *mUsers = [NSMutableArray array];
    NSArray *users = @[@"用户1",@"用户2",@"用户3",@"用户4"];
    for (NSString *user in users) {
        [mUsers addObject:user];
    }
    _usernameBox.listArray = mUsers;//只可赋值可变数组
    _usernameBox.inputTF.placeholder = @"用户";
    [self.view addSubview:_usernameBox];
    
    UIImageView *passwordIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuang"]];
    passwordIV.userInteractionEnabled = YES;
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, WIDTH*.82, WIDTH/8.4)];
    _passwordTF.placeholder = @"密码";
    [_passwordTF setFont:[UIFont systemFontOfSize:20]];
    [passwordIV addSubview:_passwordTF];
    
    passwordIV.frame = CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4);
    passwordIV.center = CGPointMake(WIDTH/2, HEIGHT/2+HEIGHT/48+WIDTH/8.4);
    [self.view addSubview:passwordIV];
    
    [_usernameBox.inputTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passwordTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    NSArray *btnImages = @[@"btn_login",@"btn_re",@"btn_re"];
    _cnTitles = @[@"登录",@"注册",@"游客"];
    _enTitles = @[@"login",@"register",@"visitor"];
    NSArray *btnColors = @[[UIColor whiteColor],[UIColor darkTextColor],[UIColor darkTextColor]];
    for (int i = 0; i<3; i++) {
        UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [loginBtn setBackgroundImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        [loginBtn setTitleColor:btnColors[i] forState:UIControlStateNormal];
        [loginBtn setTitle:_cnTitles[i] forState:UIControlStateNormal];
        loginBtn.tag = i;
        [_loginBtns addObject:loginBtn];
        [loginBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
        loginBtn.center = CGPointMake(WIDTH/2, HEIGHT/2+(HEIGHT/48+WIDTH/8.4)*(i+2));
        [self.view addSubview:loginBtn];
    }
}


-(void)openChangeLanguage:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            [btn setImage:[UIImage imageNamed:@"yuyan_btn_sel"] forState:UIControlStateNormal];
            [cnBtn setHidden:NO];
            [enBtn setHidden:NO];
            btn.tag = 1;
            break;
        case 1:
            [btn setImage:[UIImage imageNamed:@"yuyan_btn"] forState:UIControlStateNormal];
            [cnBtn setHidden:YES];
            [enBtn setHidden:YES];
            btn.tag = 0;
            break;
    }
}
-(void)turnCn{//中文
    [cnBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_cn_sel"] forState:UIControlStateNormal];
    [enBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_En"] forState:UIControlStateNormal];
    [_usernameBox.inputTF setPlaceholder:@"用户"];
    [_passwordTF setPlaceholder:@"密码"];
    for (int i = 0;i<_loginBtns.count;i++) {
        [_loginBtns[i] setTitle:_cnTitles[i] forState:UIControlStateNormal];
    }
}
-(void)turnEn{//英文
    [cnBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_cn"] forState:UIControlStateNormal];
    [enBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_En_sel"] forState:UIControlStateNormal];
    [_usernameBox.inputTF setPlaceholder:@"username"];
    [_passwordTF setPlaceholder:@"password"];
    for (int i = 0;i<_loginBtns.count;i++) {
        [_loginBtns[i] setTitle:_enTitles[i] forState:UIControlStateNormal];
    }
}
-(void)tapAction{//点击背景图收起键盘
    [_usernameBox resignFirstResponder];
    [_passwordTF resignFirstResponder];
}
-(void)didExitInput:(UITextField*)sender{
    [sender resignFirstResponder];
}

-(void)clicked:(UIButton*)btn{
    UserInfoVC *userInfoVC = [[UserInfoVC alloc]initWithNibName:@"UserInfoVC" bundle:nil];
    switch (btn.tag) {
        case 0://登录
            break;
        case 1://注册
            [self.navigationController pushViewController:userInfoVC animated:YES];
            break;
        case 2://访客
        {
            MainTabBarVC *mainTabBarVC = [[MainTabBarVC alloc]initWithNibName:@"MainTabBarVC" bundle:nil];
            [self presentViewController:mainTabBarVC animated:YES completion:nil];
        }
            break;
    }
}

@end
