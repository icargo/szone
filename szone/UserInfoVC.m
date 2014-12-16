//
//  UserInfoVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/11.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#import "UserInfoVC.h"
#import "MainTabBarVC.h"
#import "CodingBase64.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"

@interface UserInfoVC ()

@property(nonatomic,strong)NSArray *sexImages;
@property(nonatomic,strong)NSMutableArray *sexBtns;
@property(nonatomic,strong)NSMutableArray *userInfoTFs;
@property(nonatomic,strong)NSMutableArray *userTFs;
@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic)int sex;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _sexBtns = [NSMutableArray array];
    _userTFs = [NSMutableArray array];
    _userInfoTFs = [NSMutableArray array];
    self.title = @"用户信息";
    _sex = 1;
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
    
    UIScrollView *bgSV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    bgSV.scrollEnabled = YES;
    bgSV.contentSize = CGSizeMake(WIDTH, WIDTH*2.5);
//头像
    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, WIDTH/4)];
    headIV.image = [UIImage imageNamed:@"head"];
    headIV.center = CGPointMake(WIDTH/5.8, WIDTH/5.23);
    
    [self.view addSubview:bgIV];
    [self.view addSubview:bgSV];
    [bgSV addSubview:headIV];
    
    NSArray *userInfoTexts = @[@"联系电话",@"E-mail",@"社交软件账号",@"疾病史",@"过敏史",@"医生姓名",@"医生E-mail",@"医生电话"];
    NSArray *userInfoPlaceholders = @[@"请输入联系电话",@"请输入E-mail",@"请输入账号",@"请输入疾病史",@"请输入过敏史",@"请输入医生姓名",@"请输入医生E-mail",@"请输入医生电话"];
    NSArray *userStrings = @[@"用户",@"密码",@"姓名",@"出生年月"];
    NSArray *userPlaceholders = @[@"请输入用户名",@"请输入密码",@"请输入姓名"];
    NSArray *sexTexts = @[@"性别",@"男",@"女"];
    NSArray *birthTexts = @[@"年",@"月",@"日"];
    _sexImages = @[@"sex_sel",@"sex"];
    for (int i = 0; i<8; i++) {
//添加中间标签、性别按钮
        if (i<3) {
            UILabel *sexLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/8, WIDTH/10)];
            sexLb.center = CGPointMake(WIDTH/7+i*WIDTH/3.5, WIDTH/1.9);
            sexLb.font = [UIFont systemFontOfSize:16];
            sexLb.text = sexTexts[i];
            [bgSV addSubview:sexLb];
        }
        if (i<2) {
            UIButton* sexBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH/13, WIDTH/13)];
            [sexBtn setImage:[UIImage imageNamed:_sexImages[i]] forState:UIControlStateNormal];
            sexBtn.center = CGPointMake(WIDTH/3.1+i*WIDTH/3.5, WIDTH/1.9);
            [sexBtn addTarget:self action:@selector(chooseMale:) forControlEvents:UIControlEventTouchUpInside];
            sexBtn.tag = i;
            [_sexBtns addObject:sexBtn];
            [bgSV addSubview:sexBtn];
//添加用户输入框及标签
            UIImageView *userIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.6, WIDTH/10)];
            userIV.center = CGPointMake(WIDTH/1.55, WIDTH/8.5+(WIDTH/10+WIDTH/32)*i);
            userIV.image = [UIImage imageNamed:@"user_word"];
            userIV.userInteractionEnabled = YES;
            
            UITextField *userTF = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH/2.8, WIDTH/10)];
            userTF.placeholder = userPlaceholders[i];
            userTF.font = [UIFont systemFontOfSize:15];
            userTF.borderStyle = UITextBorderStyleNone;
            userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
            userTF.tag = i;
            [userTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
            if (i==1) {
                userTF.secureTextEntry = YES;
            }
            [_userTFs addObject:userTF];
            
            UILabel *userLb = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, WIDTH/8, WIDTH/10)];
            userLb.font = [UIFont systemFontOfSize:15];
            userLb.textAlignment = NSTextAlignmentLeft;
            userLb.text = userStrings[i];
            
            [userIV addSubview:userLb];
            [userIV addSubview:userTF];
            [bgSV addSubview:userIV];
//姓名、出生输入框
            UIImageView *nameIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
            nameIV.center = CGPointMake(WIDTH/2, WIDTH/2.6+WIDTH/3.6*i);
            nameIV.image = [UIImage imageNamed:@"text_long"];
            nameIV.userInteractionEnabled = YES;
            
            UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, WIDTH/5, WIDTH/10)];
            nameLb.font = [UIFont systemFontOfSize:15];
            nameLb.textAlignment = NSTextAlignmentLeft;
            nameLb.text = userStrings[i+2];
            [nameIV addSubview:nameLb];
            if (i==0) {
                _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH/3, 0, WIDTH/1.75, WIDTH/10)];
                _nameTF.placeholder = [userPlaceholders lastObject];
                _nameTF.font = [UIFont systemFontOfSize:15];
                _nameTF.textAlignment = NSTextAlignmentLeft;
                _nameTF.borderStyle = UITextBorderStyleNone;
                _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
                _nameTF.tag = 2;
                [_nameTF addTarget:self action:@selector(didExitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
                [nameIV addSubview:_nameTF];
            }
            if (i==1) {
                for (int i=0; i<3; i++) {
                    UIButton *birthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    birthBtn.frame = CGRectMake(WIDTH/4+WIDTH/5*i, 0, WIDTH/5, WIDTH/10);
                    UILabel *birthLabel = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, WIDTH/5, WIDTH/10)];
                    birthLabel.text = birthTexts[i];
                    birthLabel.textColor = [UIColor darkTextColor];
                    birthLabel.font = [UIFont systemFontOfSize:15];
                    birthLabel.textAlignment = NSTextAlignmentRight;
                    birthBtn.tag = i;
                    [birthBtn addTarget:self action:@selector(chooseBirth:) forControlEvents:UIControlEventTouchUpInside];
                    [birthBtn addSubview:birthLabel];
                    [nameIV addSubview:birthBtn];
                }
            }
            [bgSV addSubview:nameIV];
        }
//添加8个用户信心输入框
        UIImageView *userInfoIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/1.1, WIDTH/10)];
        userInfoIV.center = CGPointMake(WIDTH/2, WIDTH/1.52+(WIDTH/10+WIDTH/32)*(i+1));
        userInfoIV.userInteractionEnabled = YES;
        userInfoIV.image = [UIImage imageNamed:@"text_long"];
        
        UILabel *userInfoLb = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, WIDTH/4, WIDTH/10)];
        if (i==2) {
            [userInfoLb setFrame:CGRectMake(6, 0, WIDTH/3.2, WIDTH/10)];
        }
        userInfoLb.font = [UIFont systemFontOfSize:15];
        userInfoLb.textAlignment = NSTextAlignmentLeft;
        userInfoLb.text = userInfoTexts[i];
        [userInfoIV addSubview:userInfoLb];
        
        UITextField *userInfoTF = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH/3, 0, WIDTH/1.75, WIDTH/10)];
        userInfoTF.placeholder = userInfoPlaceholders[i];
        userInfoTF.font = [UIFont systemFontOfSize:15];
        userInfoTF.textAlignment = NSTextAlignmentLeft;
        userInfoTF.borderStyle = UITextBorderStyleNone;
        userInfoTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (i==0||i==7) {
            userInfoTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        userInfoTF.tag = i;
        [userInfoTF addTarget:self action:@selector(exitInput:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_userInfoTFs  addObject:userInfoTF];
        
        [userInfoIV addSubview:userInfoTF];
        [bgSV addSubview:userInfoIV];
    }
    
//保存按钮
    UIButton* saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"commit_btn"] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [saveBtn addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.frame = CGRectMake(0, 0, WIDTH/3.2, WIDTH/10);
    saveBtn.center = CGPointMake(WIDTH/2, WIDTH*1.85);
    [bgSV addSubview:saveBtn];
    
}
-(void)backAction{//返回
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didExitInput:(UITextField*)sender{
    if (sender.tag+1<_userTFs.count) {
        [_userTFs[sender.tag+1] becomeFirstResponder];
    }else if (sender.tag==1)[_nameTF becomeFirstResponder];
    else [_userInfoTFs[0] becomeFirstResponder];
}
-(void)exitInput:(UITextField*)sender{
    [sender resignFirstResponder];//点击收起键盘
    if (sender.tag+1<_userInfoTFs.count) {
        [_userInfoTFs[sender.tag+1] becomeFirstResponder];
    }
}
-(void)viewWillAppear:(BOOL)animated{//显示naviBar
    self.navigationController.navigationBarHidden = NO;
}
-(BOOL)prefersStatusBarHidden{
    return YES;//隐藏状态栏
}
-(void)chooseMale:(UIButton*)btn{
    [btn setImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
    switch (btn.tag) {
        case 0: _sex = 1;
            [_sexBtns[1] setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
            break;
        case 1: _sex = 0;
            [_sexBtns[0] setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
            break;
    }
}

-(void)chooseBirth:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            NSLog(@"年");
            break;
        case 1:
            NSLog(@"月");
            break;
    }
}

-(NSDictionary*)getRegisterParamsByUserInfo{
    
    NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionary];
    UITextField *usernameTF = _userTFs[0];
    UITextField *passwordTF = _userTFs[1];
    NSString *password = [CodingBase64 encodeString:passwordTF.text];
    
    NSString *headString = [CodingBase64 encodeImageToString:[UIImage imageNamed:@""]];
    [userInfoDic setObject:headString forKey:@"Image"];
    [userInfoDic setObject:usernameTF.text forKey:@"LoginName"];
    [userInfoDic setObject:password forKey:@"Password"];
    [userInfoDic setObject:@"" forKey:@"DocKey"];
    [userInfoDic setObject:_nameTF.text forKey:@"Name"];
    [userInfoDic setObject:@(_sex) forKey:@"Gender"];
    [userInfoDic setObject:@"2000-01-01" forKey:@"Birthday"];
    NSArray *keys = @[@"Phone",@"Email",@"SocialNumber",@"MedicalHistory",@"AllergyHistory",@"DoctorName",@"DoctorEmail",@"DoctorPhone"];
    for (int i = 0; i<_userInfoTFs.count; i++) {
        UITextField *userInfo = _userInfoTFs[i];
        [userInfoDic setObject:userInfo.text forKey:keys[i]];
    }
    return userInfoDic;
}
-(void)saveUserInfo{//保存信息
    NSDictionary *userInfoParams = [self getRegisterParamsByUserInfo];
//    NSString *userInfoParams = [userInfoDic JSONString];
    NSLog(@"参数:%@",userInfoParams);
    AFHTTPRequestOperationManager* httpManager = [AFHTTPRequestOperationManager manager];//创建HTTP请求对象
    [httpManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];//去掉智能转换
    httpManager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求类型
    //httpManager.responseSerializer = [AFJSONResponseSerializer serializer];//指定返回类型
    
    [httpManager POST:@"http://182.254.228.203:8080/api/user" parameters:userInfoParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSDictionary *registerInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        [self.view makeToast:@"注册成功,祝您使用愉快!" duration:2 position:@"center"];
        NSLog(@"registerInfo:%@",registerInfo);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *response = [operation valueForKey:@"response"];
        if (response) [SVProgressHUD showErrorWithStatus:@"注册失败,请您重新注册!"];
        else [SVProgressHUD showErrorWithStatus:@"网络连接失败" duration:2];
    }];
}


@end
