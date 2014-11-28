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
    UIButton *yuyanBtn;
    UIButton *cnBtn;
    UIButton *enBtn;
    
    UIImageView *passwordIV;
    
    UIButton *loginBtn;
    UIButton *registerBtn;
    UIButton *visitorBtn;
    
    UIImageView *backgroundIV;
    UIImageView *logoIV;
    UIImageView *companyIV;
}
@property(nonatomic,strong)ComboBox *usernameBox;
@property(nonatomic,strong)UITextField *passwordTF;
@end

@implementation LoginVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        yuyanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [yuyanBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_btn"] forState:UIControlStateNormal];
        
        cnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cnBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_cn_sel"] forState:UIControlStateNormal];
        enBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [enBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_En"] forState:UIControlStateNormal];
        [cnBtn setHidden:YES];
        [enBtn setHidden:YES];
        
        _usernameBox = [[ComboBox alloc]initWithFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
        _usernameBox.center = CGPointMake(WIDTH/2, HEIGHT/2.5);
//        [_usernameBox setBackground:[UIImage imageNamed:@"shurukuang"]];
//        UIButton *accountBtn = [[UIButton alloc]initWithFrame:CGRectMake(_usernameBox.bounds.size.width-44, 0, 44, 44)];
//        [accountBtn setBackgroundImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
//        [_usernameBox addSubview:accountBtn];
//        [accountBtn addTarget:self action:@selector(chooseAccount) forControlEvents:UIControlEventTouchUpInside];
        NSMutableArray *mUsers = [NSMutableArray array];
        NSArray *users = @[@"用户1",@"用户2",@"用户3",@"用户4"];
        for (NSString *user in users) {
            [mUsers addObject:user];
        }
        _usernameBox.listArray = mUsers;
        _usernameBox.inputTF.placeholder = @"用户";

        passwordIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuang"]];
        passwordIV.userInteractionEnabled = YES;
        _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, WIDTH*.82, WIDTH/8.4)];
        _passwordTF.placeholder = @"密码";
        [_passwordTF setFont:[UIFont systemFontOfSize:20]];
        [passwordIV addSubview:_passwordTF];
        
        loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_login"] forState:UIControlStateNormal];
        
        registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setBackgroundImage:[UIImage imageNamed:@"btn_re"] forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        visitorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [visitorBtn setBackgroundImage:[UIImage imageNamed:@"btn_re"] forState:UIControlStateNormal];
        [visitorBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        visitorBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        loginBtn.tag = 0;
        registerBtn.tag = 1;
        visitorBtn.tag = 2;
        
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [visitorBtn setTitle:@"游客" forState:UIControlStateNormal];
        
        backgroundIV = [[UIImageView alloc]initWithFrame:CGRectZero];
        backgroundIV.image = [UIImage imageNamed:@"beijing"];
        backgroundIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [backgroundIV addGestureRecognizer:tap];
        
        logoIV = [[UIImageView alloc]initWithFrame:CGRectZero];
        logoIV.image = [UIImage imageNamed:@"logo"];
        companyIV = [[UIImageView alloc]initWithFrame:CGRectZero];
        companyIV.image = [UIImage imageNamed:@"company"];

        [self.view addSubview:backgroundIV];
        [self.view addSubview:logoIV];
        [self.view addSubview:companyIV];
        [self.view addSubview:yuyanBtn];
        [self.view addSubview:cnBtn];
        [self.view addSubview:enBtn];
        [self.view addSubview:_usernameBox];
        [self.view addSubview:passwordIV];
        [self.view addSubview:loginBtn];
        [self.view addSubview:registerBtn];
        [self.view addSubview:visitorBtn];

    }
    return self;
}

-(BOOL)prefersStatusBarHidden{//隐藏状态栏
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{//隐藏naviBar
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [_usernameBox addTarget:self action:@selector(didBeginInput:) forControlEvents:UIControlEventEditingDidBegin];
//    [_usernameBox addTarget:self action:@selector(didEndInput:) forControlEvents:UIControlEventEditingDidEnd];
//    [passwordIV addTarget:self action:@selector(didBeginInput:) forControlEvents:UIControlEventEditingDidBegin];
//    [passwordIV addTarget:self action:@selector(didEndInput:) forControlEvents:UIControlEventEditingDidEnd];
    [yuyanBtn addTarget:self action:@selector(openChangeLanguage:) forControlEvents:UIControlEventTouchUpInside];
    [cnBtn addTarget:self action:@selector(turnCn) forControlEvents:UIControlEventTouchUpInside];
    [enBtn addTarget:self action:@selector(turnEn) forControlEvents:UIControlEventTouchUpInside];

    [_usernameBox.inputTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passwordTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [loginBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [visitorBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillLayoutSubviews{//重新布局子控件
    [backgroundIV setFrame:[[UIScreen mainScreen] bounds]];
    [logoIV setFrame:CGRectMake(0, 0, WIDTH/2.7, WIDTH/3.7)];
    [companyIV setFrame:CGRectMake(0, 0, WIDTH/1.4, HEIGHT/40)];
    logoIV.center = CGPointMake(WIDTH/2, HEIGHT/6.5);
    companyIV.center = CGPointMake(WIDTH/2, HEIGHT/3.6);
    
    
    [yuyanBtn setFrame:CGRectMake(WIDTH-HEIGHT/7.1, 0, HEIGHT/7.1, HEIGHT/30)];
    [cnBtn setFrame:CGRectMake(WIDTH-HEIGHT/7.1, HEIGHT/30, HEIGHT/7.1, HEIGHT/16)];
    [enBtn setFrame: CGRectMake(WIDTH-HEIGHT/7.1, HEIGHT/30+HEIGHT/16, HEIGHT/7.1, HEIGHT/16)];
    
    passwordIV.frame = CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4);
    passwordIV.center = CGPointMake(WIDTH/2, HEIGHT/2.5+HEIGHT/48+WIDTH/8.4);
    
    [loginBtn setFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
    [registerBtn setFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
    [visitorBtn setFrame:CGRectMake(0, 0, WIDTH*.875, WIDTH/8.4)];
    loginBtn.center = CGPointMake(WIDTH/2, HEIGHT/2.5+HEIGHT/24+WIDTH/4.2);
    registerBtn.center = CGPointMake(WIDTH/2, HEIGHT/2.5+HEIGHT/16+WIDTH/2.8);
    visitorBtn.center = CGPointMake(WIDTH/2, HEIGHT/2.5+HEIGHT/12+WIDTH/2.1);
    
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
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [visitorBtn setTitle:@"游客" forState:UIControlStateNormal];
}
-(void)turnEn{//英文
    [cnBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_cn"] forState:UIControlStateNormal];
    [enBtn setBackgroundImage:[UIImage imageNamed:@"yuyan_En_sel"] forState:UIControlStateNormal];
    [_usernameBox.inputTF setPlaceholder:@"username"];
    [_passwordTF setPlaceholder:@"password"];
    [loginBtn setTitle:@"login" forState:UIControlStateNormal];
    [registerBtn setTitle:@"register" forState:UIControlStateNormal];
    [visitorBtn setTitle:@"visitor" forState:UIControlStateNormal];
}
-(void)tapAction{//点击背景图收起键盘
    [_usernameBox resignFirstResponder];
    [passwordIV resignFirstResponder];
}
-(void)didExitInput:(UITextField*)sender{
    [sender resignFirstResponder];
}
//-(void)didBeginInput:(UITextField*)sender{
//    switch (sender.tag) {
//        case 0:
//            [self moveView:15];
//            break;
//        case 1:
//            [self moveView:-35];
//            break;
//    }
//}
//-(void)didEndInput:(UITextField*)sender{
//    [sender resignFirstResponder];//return收起键盘
//    switch (sender.tag) {
//        case 0:
//            [self moveView:-15];
//            break;
//        case 1:
//            [self moveView:35];
//            break;
//    }
//}
//
//-(void)moveView:(float)moveLength{
//    [UIView animateWithDuration:.3 animations:^{
//        CGRect frame = self.view.frame;
//        frame.origin.y +=moveLength;//view的y轴上移
//        self.view.frame = frame;
//    }];
//}
-(void)clicked:(UIButton*)btn{
    UserInfoVC *userInfoVC = [[UserInfoVC alloc]initWithNibName:@"UserInfoVC" bundle:nil];
    switch (btn.tag) {
        case 0://登录
            [_usernameBox resignFirstResponder];
            [passwordIV resignFirstResponder];
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
