//
//  UserInfoVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/11.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "UserInfoVC.h"
#import "MainTabBarVC.h"

#define WIDTH   [[UIScreen mainScreen] bounds].size.width
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
@interface UserInfoVC ()
{
    UIScrollView *bgSV;
    UIImageView *headIV;
    
    UIImageView *usernameIV;
    UIImageView *passwordIV;
    UIImageView *nameIV;
    
    UIImageView *birthIV;
    UIImageView *telphoneIV;
    UIImageView *emailIV;
    UIImageView *socialIV;
    UIImageView *illIV;
    UIImageView *allergicIV;
    UIImageView *docnameIV;
    UIImageView *docemailIV;
    UIImageView *doctelphoneIV;
    
    UILabel *sexLb;
    UILabel *maleLb;
    UILabel *femaleLb;
    
    UIButton* maleBtn;
    UIButton* femaleBtn;
    UIButton* saveBtn;
    NSArray *tfs;
}

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    UINavigationBar *naviBar = self.navigationController.navigationBar;
    [naviBar setBackgroundImage:[UIImage imageNamed:@"navi_bar"] forBarMetrics:UIBarMetricsDefault];
    [naviBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0]}];
    //自定义BarButtonItem图片
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=CGRectMake(0, 0, WIDTH/12, WIDTH/12);
    [btn setBackgroundImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    //添加背景图
    UIImageView *bgIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing"]];
    bgIV.frame =  CGRectMake(0, 0, WIDTH, WIDTH*2.5);
    
    bgSV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    bgSV.scrollEnabled = YES;
    bgSV.contentSize = CGSizeMake(WIDTH, WIDTH*2.5);
    //头像
    headIV = [[UIImageView alloc]initWithFrame:CGRectZero];
    headIV.image = [UIImage imageNamed:@"head"];
    
//中间标签
    sexLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/8, WIDTH/10)];
    maleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, WIDTH/10)];
    femaleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, WIDTH/10)];
    sexLb.text = @"性别";
    maleLb.text = @"男";
    femaleLb.text = @"女";
    NSArray *middleLbs = @[sexLb,maleLb,femaleLb];
    
//性别按钮
    maleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH/12.8, WIDTH/12.8)];
    femaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH/12.8, WIDTH/12.8)];
    [maleBtn setBackgroundImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
    [femaleBtn setBackgroundImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
    [maleBtn addTarget:self action:@selector(chooseMale) forControlEvents:UIControlEventTouchUpInside];
    [femaleBtn addTarget:self action:@selector(chooseFemale) forControlEvents:UIControlEventTouchUpInside];
//保存按钮
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"commit_btn"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [saveBtn addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    //账户输入框
    usernameIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.6, WIDTH/10)];
    passwordIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.6, WIDTH/10)];
    usernameIV.image = [UIImage imageNamed:@"user_word"];
    passwordIV.image = [UIImage imageNamed:@"user_word"];
    usernameIV.userInteractionEnabled = YES;
    passwordIV.userInteractionEnabled = YES;
    [bgSV addSubview:usernameIV];
    [bgSV addSubview:passwordIV];
    
    UITextField *usernameTF = [[UITextField alloc]init];
    UITextField *passwordTF = [[UITextField alloc]init];
    usernameTF.placeholder = @"请输入用户名";
    passwordTF.placeholder = @"请输入密码";
    usernameTF.font = [UIFont systemFontOfSize:14];
    passwordTF.font = [UIFont systemFontOfSize:14];
    usernameTF.textAlignment = NSTextAlignmentLeft;
    passwordTF.textAlignment = NSTextAlignmentLeft;
    usernameTF.borderStyle = UITextBorderStyleNone;
    passwordTF.borderStyle = UITextBorderStyleNone;
    usernameTF.frame = CGRectMake(WIDTH/4, 0, WIDTH/2.8, WIDTH/10);
    passwordTF.frame = CGRectMake(WIDTH/4, 0, WIDTH/2.8, WIDTH/10);

    [usernameIV addSubview:usernameTF];
    [passwordIV addSubview:passwordTF];
    
    //添加标签到输入框上
    UILabel* usernameLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/8, WIDTH/10)];
    UILabel* passwordLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/8, WIDTH/10)];
    UILabel* nameLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/8, WIDTH/10)];
    usernameLb.font = [UIFont systemFontOfSize:15];
    passwordLb.font = [UIFont systemFontOfSize:15];
    nameLb.font = [UIFont systemFontOfSize:15];
    usernameLb.text = @"用户";
    passwordLb.text = @"密码";
    nameLb.text = @"姓名";

//添加9个输入框及标签
    nameIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    birthIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    telphoneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    emailIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    socialIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    illIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    allergicIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    docnameIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    docemailIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    doctelphoneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
    
    NSArray *tfIVs = @[nameIV,birthIV,telphoneIV,emailIV,socialIV,illIV,allergicIV,docnameIV,docemailIV,doctelphoneIV];
    UITextField *nameTF = [[UITextField alloc]init];
    UITextField *birthTF = [[UITextField alloc]init];
    UITextField *telphoneTF = [[UITextField alloc]init];
    UITextField *emailTF = [[UITextField alloc]init];
    UITextField *socialTF = [[UITextField alloc]init];
    UITextField *illTF = [[UITextField alloc]init];
    UITextField *allergicTF = [[UITextField alloc]init];
    UITextField *docnameTF = [[UITextField alloc]init];
    UITextField *docemailTF = [[UITextField alloc]init];
    UITextField *doctelphoneTF = [[UITextField alloc]init];
    [nameIV addSubview:nameTF];
    [birthIV addSubview:birthTF];
    [telphoneIV addSubview:telphoneTF];
    [emailIV addSubview:emailTF];
    [socialIV addSubview:socialTF];
    [illIV addSubview:illTF];
    [allergicIV addSubview:allergicTF];
    [docnameIV addSubview:docnameTF];
    [docemailIV addSubview:docemailTF];
    [doctelphoneIV addSubview:doctelphoneTF];
    
    tfs = @[nameTF,birthTF,telphoneTF,emailTF,socialTF,illTF,allergicTF,docnameTF,docemailTF,doctelphoneTF];
    
    nameTF.placeholder = @"请输入姓名";
    telphoneTF.placeholder = @"请输入联系电话";
    emailTF.placeholder = @"请输入E-mail";
    socialTF.placeholder = @"请输入账号";
    illTF.placeholder = @"请输入疾病史";
    allergicTF.placeholder = @"请输入过敏史";
    docnameTF.placeholder = @"请输入医生姓名";
    docemailTF.placeholder = @"请输入医生E-mail";
    doctelphoneTF.placeholder = @"请输入医生电话";
    
    UILabel* birthLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* telphoneLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* emailLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* socialLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/3.5, WIDTH/10)];
    UILabel* illLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* allergicLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* docNameLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];
    UILabel* docEmailLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/4, WIDTH/10)];
    UILabel* docTelphoneLb = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, WIDTH/5, WIDTH/10)];

    birthLb.font = [UIFont systemFontOfSize:15];
    telphoneLb.font = [UIFont systemFontOfSize:15];
    emailLb.font = [UIFont systemFontOfSize:15];
    socialLb.font = [UIFont systemFontOfSize:15];
    illLb.font = [UIFont systemFontOfSize:15];
    allergicLb.font = [UIFont systemFontOfSize:15];
    docNameLb.font = [UIFont systemFontOfSize:15];
    docEmailLb.font = [UIFont systemFontOfSize:15];
    docTelphoneLb.font = [UIFont systemFontOfSize:15];
    
    birthLb.text = @"出生年月";
    telphoneLb.text = @"联系电话";
    emailLb.text = @"E-mail";
    socialLb.text = @"社交软件账号";
    illLb.text = @"疾病史";
    allergicLb.text = @"过敏史";
    docNameLb.text = @"医生姓名";
    docEmailLb.text = @"医生E-mail";
    docTelphoneLb.text = @"医生电话";
    
    [usernameIV addSubview:usernameLb];
    [passwordIV addSubview:passwordLb];
    [nameIV addSubview:nameLb];
    [birthIV addSubview:birthLb];
    [telphoneIV addSubview:telphoneLb];
    [emailIV addSubview:emailLb];
    [socialIV addSubview:socialLb];
    [illIV addSubview:illLb];
    [allergicIV addSubview:allergicLb];
    [docnameIV addSubview:docNameLb];
    [docemailIV addSubview:docEmailLb];
    [doctelphoneIV addSubview:docTelphoneLb];
//将控件添加到view上
    [self.view addSubview:bgIV];
    [self.view addSubview:bgSV];
    [bgSV addSubview:headIV];
    
    [bgSV addSubview:maleBtn];
    [bgSV addSubview:femaleBtn];
    [bgSV addSubview:saveBtn];
    for (int i=0; i<tfIVs.count; i++) {
        UITextField* tf = tfs[i];
        tf.font = [UIFont systemFontOfSize:14];
        tf.textAlignment = NSTextAlignmentLeft;
        tf.borderStyle = UITextBorderStyleNone;
        tf.frame = CGRectMake(WIDTH/2.7, 0, WIDTH/2, WIDTH/10);
        tf.tag = i;
        [tf addTarget:self action:@selector(exitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        UIImageView *tfIV = tfIVs[i];
        tfIV.userInteractionEnabled = YES;
        tfIV.image = [UIImage imageNamed:@"text_long"];
        [bgSV addSubview:tfIV];
        
        if (i<3) {
            UILabel *middleLb = middleLbs[i];
            middleLb.font = [UIFont systemFontOfSize:15];
            [bgSV addSubview:middleLb];
        }
    }
}
-(void)backAction{//返回
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)exitInput:(UITextField*)sender{
    [sender resignFirstResponder];//点击收起键盘
    if (sender.tag+1<tfs.count) {
        [tfs[sender.tag+1] becomeFirstResponder];
    }
}
-(void)viewWillAppear:(BOOL)animated{//显示naviBar
    self.navigationController.navigationBarHidden = NO;
}
-(BOOL)prefersStatusBarHidden{
    return YES;//隐藏状态栏
}
-(void)chooseMale{//男
    [maleBtn setBackgroundImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
    [femaleBtn setBackgroundImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
}
-(void)chooseFemale{//
    [maleBtn setBackgroundImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
    [femaleBtn setBackgroundImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
}
-(void)saveUserInfo{//保存信息
    
}
-(void)viewWillLayoutSubviews{

    headIV.frame = CGRectMake(0, 0, WIDTH/4, WIDTH/4);
    headIV.center = CGPointMake(WIDTH/5.8, WIDTH/5.23);
    
    usernameIV.center = CGPointMake(WIDTH/1.55, WIDTH/8.5);
    passwordIV.center = CGPointMake(WIDTH/1.55, WIDTH/8.5+WIDTH/10+WIDTH/32);
    nameIV.center = CGPointMake(WIDTH/2, WIDTH/8.5+(WIDTH/10+WIDTH/32)*2);
    
    sexLb.center = CGPointMake(WIDTH/7.2, WIDTH/1.9);
    maleLb.center = CGPointMake(WIDTH/1.98, WIDTH/1.9);
    maleBtn.center = CGPointMake(WIDTH/3, WIDTH/1.9);
    femaleLb.center = CGPointMake(WIDTH/1.26, WIDTH/1.9);
    femaleBtn.center = CGPointMake(WIDTH/1.6, WIDTH/1.9);
    saveBtn.frame = CGRectMake(0, 0, WIDTH/3.2, WIDTH/10);
    saveBtn.center = CGPointMake(WIDTH/2, WIDTH*1.85);
    
    birthIV.center = CGPointMake(WIDTH/2, WIDTH/1.52);
    telphoneIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+WIDTH/10+WIDTH/32);
    emailIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*2);
    socialIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*3);
    illIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*4);
    allergicIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*5);
    docnameIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*6);
    docemailIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*7);
    doctelphoneIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*8);
    
}


@end
