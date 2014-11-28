//
//  UploadView.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/27.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height
#import "UploadView.h"
#import "CustomTabButton.h"
@interface UploadView()
@property (nonatomic,strong)UIButton *selectedPainBtn;
@property (nonatomic,strong)UIButton *selectedcoughBtn;
@end
@implementation UploadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/22, HEIGHT/56.8, WIDTH/1.2, WIDTH/10)];
    titleLb.font = [UIFont boldSystemFontOfSize:19];
    titleLb.textColor = [UIColor colorWithRed:90/255.0 green:186/255.0 blue:225/255.0 alpha:1];
    titleLb.text = @"补充信息(以下内容选填)";
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/22, HEIGHT/56.8+HEIGHT/14.2, WIDTH/1.1, 1)];
    lineLb.backgroundColor = [UIColor  colorWithRed:90/255.0 green:186/255.0 blue:225/255.0 alpha:1];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(WIDTH/1.2, HEIGHT/52, WIDTH/6.5, WIDTH/13);
    [closeBtn addTarget:self action:@selector(closeUploadAction) forControlEvents:UIControlEventTouchUpInside];
    NSArray *troubleStrings = @[@"喉咙是否痛?",@"如果是,痛多久了?",@"是否服用了抗生素?",@"是否咳嗽?",@"如果是咳嗽的频率?",@"是否流鼻涕?",@"目前服用什么药物"];
    NSArray *painTimeStrings = @[@"<24h",@"24~72h",@">72h"];
    NSArray *coughFrequencyStrings = @[@"1~3次/小时",@"3~5次/小时",@"1~3次/分钟"];
    NSArray *doneBtnTitles = @[@"取消",@"提交"];
    NSArray *doneBtnImages = @[@"cancel_btn",@"commit_btn"];
    NSArray *colors = @[[UIColor darkTextColor],[UIColor whiteColor]];
    for (int i = 0; i<7; i++) {
        UILabel *troubleLb = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/22, HEIGHT/8+HEIGHT/10*i, WIDTH/1.5, WIDTH/10)];
        troubleLb.font = [UIFont boldSystemFontOfSize:16];
        troubleLb.text = troubleStrings[i];
        [self addSubview:troubleLb];
        if (i<2) {
            UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [doneBtn setBackgroundImage:[UIImage imageNamed:doneBtnImages[i]] forState:UIControlStateNormal];
            [doneBtn setTitle:doneBtnTitles[i] forState:UIControlStateNormal];
            doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [doneBtn setTitleColor:colors[i] forState:UIControlStateNormal];
            doneBtn.frame = CGRectMake(WIDTH/22+i*WIDTH/2.1, HEIGHT*.875, WIDTH/2.3, WIDTH/8);
            doneBtn.tag = i;
            [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:doneBtn];
        }
        if (i<3) {
            CustomTabButton *painTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [painTimeBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            painTimeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [painTimeBtn setTitle:painTimeStrings[i] forState:UIControlStateNormal];
            painTimeBtn.frame = CGRectMake(WIDTH/28+i*WIDTH/4.5, HEIGHT/5.8+HEIGHT/10, WIDTH/5, WIDTH/10);
            [painTimeBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:176/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
            painTimeBtn.tag = i;
            if (0==i) {
                painTimeBtn.selected = YES;
                _selectedPainBtn = painTimeBtn;
            }
            [painTimeBtn addTarget:self action:@selector(choosePainTime:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:painTimeBtn];
            
            CustomTabButton *coughFrequencyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            coughFrequencyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [coughFrequencyBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [coughFrequencyBtn setTitle:coughFrequencyStrings[i] forState:UIControlStateNormal];
            coughFrequencyBtn.frame = CGRectMake(WIDTH/22+i*WIDTH/3.2, HEIGHT/5.8+HEIGHT/10*4, WIDTH/3.2, WIDTH/10);
            [coughFrequencyBtn setTitleColor:[UIColor colorWithRed:81/255.0 green:176/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
            coughFrequencyBtn.tag = i;
            if (1==i) {
                coughFrequencyBtn.selected = YES;
                _selectedcoughBtn = coughFrequencyBtn;
            }
            [coughFrequencyBtn addTarget:self action:@selector(chooseCoughFrequency:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:coughFrequencyBtn];
        }
        
        if (i==1||i==4||i>5)
            continue;
        UILabel *yesLb = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/20, HEIGHT/5.8+HEIGHT/10*i, WIDTH/16, WIDTH/10)];
        UILabel *noLb = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2.6, HEIGHT/5.8+HEIGHT/10*i, WIDTH/16, WIDTH/10)];
        yesLb.font = [UIFont boldSystemFontOfSize:15];
        noLb.font = [UIFont boldSystemFontOfSize:15];
        noLb.text = @"否";
        yesLb.text = @"是";
        [self addSubview:noLb];
        [self addSubview:yesLb];
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [yesBtn setImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
        [noBtn setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
        yesBtn.frame = CGRectMake(WIDTH/8,HEIGHT/5.6+HEIGHT/10*i,WIDTH/12.8,WIDTH/12.8);
        noBtn.frame = CGRectMake(WIDTH/2.2,HEIGHT/5.6+HEIGHT/10*i,WIDTH/12.8,WIDTH/12.8);
        yesBtn.tag = i;
        noBtn.tag = i;
        [yesBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn addTarget:self action:@selector(denyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yesBtn];
        [self addSubview:noBtn];
    }
    
    UIImageView *medicineIV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/21, HEIGHT*.79, WIDTH/1.1, WIDTH/9.3)];
    medicineIV.userInteractionEnabled = YES;
    //medicineIV.image = [UIImage imageNamed:@"text_medicine"];
    UITextField *medicineTF = [[UITextField alloc]initWithFrame:CGRectMake(WIDTH/21, HEIGHT*.79, WIDTH/1.1, WIDTH/9.8)];
    medicineTF.background = [UIImage imageNamed:@"text_medicine"];
    //medicineTF.borderStyle = UITextBorderStyleNone;
    
    [medicineIV addSubview:medicineTF];
    [self addSubview:medicineTF];
    [self addSubview:titleLb];
    [self addSubview:lineLb];
    [self addSubview:closeBtn];

}

-(void)closeUploadAction{
    [UIView animateWithDuration:.3 animations:^{
        self.frame = CGRectMake(WIDTH/2.5, HEIGHT/1.6, WIDTH/8, WIDTH/6);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)doneAction:(UIButton*)btn{
    [self closeUploadAction];
    switch (btn.tag) {
        case 0:
            //取消
            break;
        case 1:
            //提交
            break;
    }
}
-(void)choosePainTime:(UIButton*)btn{
    _selectedPainBtn.selected = NO;
    btn.selected = YES;
    _selectedPainBtn = btn;
    switch (btn.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
    }
}

-(void)chooseCoughFrequency:(UIButton*)btn{
    _selectedcoughBtn.selected = NO;
    btn.selected = YES;
    _selectedcoughBtn = btn;
    switch (btn.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
    }
}
-(void)sureAction:(UIButton*)btn{
    switch (btn.tag) {
        case 0:
            break;
        case 2:
            break;
        case 3:
            break;
        case 5:
            break;
    }
}
-(void)denyAction:(UIButton*)btn{}
@end
