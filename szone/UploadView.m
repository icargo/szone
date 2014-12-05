//
//  UploadView.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/27.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//
#define _WIDTH self.bounds.size.width
#define _HEIGHT self.bounds.size.height
#import "UploadView.h"
#import "CustomTabButton.h"
@interface UploadView(){
    NSMutableArray *yesBtns;
    NSMutableArray *noBtns;
    NSMutableArray *troubleLbs;
}
@property (nonatomic,strong)UIButton *selectedPainBtn;
@property (nonatomic,strong)UIButton *selectedcoughBtn;
@property (nonatomic) Boolean isPain;
@property (nonatomic) Boolean isCough;
@end
@implementation UploadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        yesBtns = [NSMutableArray array];
        noBtns = [NSMutableArray array];
        troubleLbs= [NSMutableArray array];
        _isPain = YES;
        _isCough = YES;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH/22, _HEIGHT/56.8, _WIDTH/1.2, _WIDTH/10)];
    titleLb.font = [UIFont boldSystemFontOfSize:19];
    titleLb.textColor = [UIColor colorWithRed:90/255.0 green:186/255.0 blue:225/255.0 alpha:1];
    titleLb.text = @"补充信息(以下内容选填)";
    UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH/22, _HEIGHT/56.8+_HEIGHT/14.2, _WIDTH/1.1, 1)];
    lineLb.backgroundColor = [UIColor  colorWithRed:90/255.0 green:186/255.0 blue:225/255.0 alpha:1];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(_WIDTH/1.2, _HEIGHT/50, _WIDTH/6.5, _WIDTH/13);
    [closeBtn addTarget:self action:@selector(closeUploadAction) forControlEvents:UIControlEventTouchUpInside];
    NSArray *troubleStrings = @[@"喉咙是否痛?",@"如果是,痛多久了?",@"是否服用了抗生素?",@"是否咳嗽?",@"如果是咳嗽的频率?",@"是否流鼻涕?",@"目前服用什么药物"];
    NSArray *doneBtnTitles = @[@"取消",@"提交"];
    NSArray *doneBtnImages = @[@"cancel_btn",@"commit_btn"];
    NSArray *colors = @[[UIColor darkTextColor],[UIColor whiteColor]];
    for (int i = 0; i<7; i++) {
        UILabel *troubleLb = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH/22, _HEIGHT/8+_HEIGHT/10*i, _WIDTH/1.5, _WIDTH/10)];
        troubleLb.font = [UIFont systemFontOfSize:16];
        troubleLb.text = troubleStrings[i];
        [troubleLbs addObject:troubleLb];
        [self addSubview:troubleLb];
        if (i<2) {
            UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [doneBtn setBackgroundImage:[UIImage imageNamed:doneBtnImages[i]] forState:UIControlStateNormal];
            [doneBtn setTitle:doneBtnTitles[i] forState:UIControlStateNormal];
            doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [doneBtn setTitleColor:colors[i] forState:UIControlStateNormal];
            doneBtn.frame = CGRectMake(_WIDTH/22+i*_WIDTH/2.1, _HEIGHT*.875, _WIDTH/2.3, _WIDTH/8);
            doneBtn.tag = i;
            [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:doneBtn];
        }
        
        if (i==1||i==4||i>5)
            continue;
        UILabel *yesLb = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH/20, _HEIGHT/5.8+_HEIGHT/10*i, _WIDTH/16, _WIDTH/10)];
        UILabel *noLb = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH/2.6, _HEIGHT/5.8+_HEIGHT/10*i, _WIDTH/16, _WIDTH/10)];
        yesLb.font = [UIFont boldSystemFontOfSize:15];
        noLb.font = [UIFont boldSystemFontOfSize:15];
        noLb.text = @"否";
        yesLb.text = @"是";
        [self addSubview:noLb];
        [self addSubview:yesLb];
        
        UIButton* yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton* noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [yesBtn setImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
        [noBtn setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
        yesBtn.frame = CGRectMake(_WIDTH/8,_HEIGHT/5.6+_HEIGHT/10*i,_WIDTH/12.8,_WIDTH/12.8);
        noBtn.frame = CGRectMake(_WIDTH/2.2,_HEIGHT/5.6+_HEIGHT/10*i,_WIDTH/12.8,_WIDTH/12.8);
        yesBtn.tag = i;
        noBtn.tag = i;
        [yesBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn addTarget:self action:@selector(denyAction:) forControlEvents:UIControlEventTouchUpInside];
        [yesBtns addObject:yesBtn];
        [noBtns addObject:noBtn];
        [self addSubview:yesBtn];
        [self addSubview:noBtn];
    }
    UITextField *medicineTF = [[UITextField alloc]initWithFrame:CGRectMake(_WIDTH/21, _HEIGHT*.79, _WIDTH/1.1, _WIDTH/9.8)];
    medicineTF.background = [UIImage imageNamed:@"text_medicine"];
    
    [self addSubview:medicineTF];
    [self addSubview:titleLb];
    [self addSubview:lineLb];
    [self addSubview:closeBtn];
    [self layoutTimeButton];
}
-(void)layoutTimeButton{
    NSArray *painTimeStrings = @[@"<24h",@"24~72h",@">72h"];
    NSArray *coughFrequencyStrings = @[@"1~3次/小时",@"3~5次/小时",@"1~3次/分钟"];
    for (int i = 0; i<3; i++) {
        CustomTabButton *painTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        painTimeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [painTimeBtn setTitle:painTimeStrings[i] forState:UIControlStateNormal];
        painTimeBtn.frame = CGRectMake(_WIDTH/28+i*_WIDTH/4.5, _HEIGHT/5.8+_HEIGHT/10, _WIDTH/5, _WIDTH/10);
        [painTimeBtn setTitleColor:[UIColor colorWithRed:75/255.0 green:177/255.0 blue:225/255.0 alpha:1] forState:UIControlStateSelected];
        painTimeBtn.tag = i;
        if (0==i) {
            painTimeBtn.selected = YES;
            _selectedPainBtn = painTimeBtn;
        }
        [painTimeBtn addTarget:self action:@selector(choosePainTime:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:painTimeBtn];
        
        CustomTabButton *coughFrequencyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coughFrequencyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [coughFrequencyBtn setTitle:coughFrequencyStrings[i] forState:UIControlStateNormal];
        coughFrequencyBtn.frame = CGRectMake(_WIDTH/22+i*_WIDTH/3.2, _HEIGHT/5.8+_HEIGHT/10*4, _WIDTH/3.2, _WIDTH/10);
        [coughFrequencyBtn setTitleColor:[UIColor colorWithRed:75/255.0 green:177/255.0 blue:225/255.0 alpha:1] forState:UIControlStateSelected];
        coughFrequencyBtn.tag = i;
        if (1==i) {
            coughFrequencyBtn.selected = YES;
            _selectedcoughBtn = coughFrequencyBtn;
        }
        [coughFrequencyBtn addTarget:self action:@selector(chooseCoughFrequency:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coughFrequencyBtn];
        switch (_isPain) {
            case YES:
                [painTimeBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                break;
            case NO:
                [painTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                painTimeBtn.enabled = NO;
                break;
        }
        switch (_isCough) {
            case YES:
                [coughFrequencyBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                break;
            case NO:
                [coughFrequencyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                coughFrequencyBtn.enabled = NO;
                break;
        }
    }
}
-(void)closeUploadAction{
    [UIView animateWithDuration:.3 animations:^{
        self.frame = CGRectMake(_WIDTH/2.5, _HEIGHT/1.6, _WIDTH/8, _WIDTH/6);
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
        case 0://<24h
            break;
        case 1://24~72h
            break;
        case 2://>72h
            break;
    }
}

-(void)chooseCoughFrequency:(UIButton*)btn{
    _selectedcoughBtn.selected = NO;
    btn.selected = YES;
    _selectedcoughBtn = btn;
    switch (btn.tag) {
        case 0://1~3次/小时
            break;
        case 1://3~5次/小时
            break;
        case 2://1~3次/分钟
            break;
    }
}
-(void)sureAction:(UIButton*)btn{
    [btn setImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
    int i = 0;
    switch (btn.tag) {
        case 0: i = 0;
            [troubleLbs[1] setTextColor:[UIColor darkTextColor]];
            _isPain = YES;
            [self layoutTimeButton];
            break;
        case 2: i = 1;
            
            break;
        case 3: i = 2;
            [troubleLbs[4] setTextColor:[UIColor darkTextColor]];
            _isCough = YES;
            [self layoutTimeButton];
            break;
        case 5: i = 3;
            break;
    }
    [noBtns[i] setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
}
-(void)denyAction:(UIButton*)btn{
    [btn setImage:[UIImage imageNamed:@"sex_sel"] forState:UIControlStateNormal];
    int i = 0;
    switch (btn.tag) {
        case 0: i = 0;
            [troubleLbs[1] setTextColor:[UIColor grayColor]];
            _isPain = NO;
            [self layoutTimeButton];
            break;
        case 2: i = 1;
            break;
        case 3: i = 2;
            [troubleLbs[4] setTextColor:[UIColor grayColor]];
            _isCough = NO;
            [self layoutTimeButton];
            break;
        case 5: i = 3;
            break;
    }
    [yesBtns[i] setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
}
@end
