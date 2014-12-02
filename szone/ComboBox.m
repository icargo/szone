//
//  ComboBox.m
//  ComboBox
//
//  Created by Becks on 14-10-27.
//  Copyright (c) 2014年 Becks_Zeng(曾光). All rights reserved.
//

#import "ComboBox.h"

#define INPUTTEXTFEILDHIEGHT  [[UIScreen mainScreen] bounds].size.width/8.4

@interface ComboBox()

@property (nonatomic, strong) UIButton *dropDownBtn;

@end

@implementation ComboBox

- (id)initWithFrame:(CGRect)frame
{
    
//    frame.size.height = INPUTTEXTFEILDHIEGHT;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.alpha = .9;
        _showtableList = NO;
        
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, INPUTTEXTFEILDHIEGHT, frame.size.width, 0)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.hidden = YES;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [self addSubview:_listTableView];
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shurukuang"]];
        iv.frame = CGRectMake(0, 0, frame.size.width, INPUTTEXTFEILDHIEGHT);
        _inputTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-INPUTTEXTFEILDHIEGHT, INPUTTEXTFEILDHIEGHT)];
        _inputTF.delegate = self;
        _inputTF.font = [UIFont systemFontOfSize:20];
        _inputTF.borderStyle = UITextBorderStyleNone; // 设置文本框的边框风格,也可以使用none,设置背景图片
        [_inputTF addTarget:self action:@selector(edit:) forControlEvents:UIControlEventAllTouchEvents];
        
        _dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dropDownBtn.frame = CGRectMake(frame.size.width-INPUTTEXTFEILDHIEGHT, 0, INPUTTEXTFEILDHIEGHT, INPUTTEXTFEILDHIEGHT);
        [_dropDownBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
        [_dropDownBtn addTarget:self action:@selector(dropDown) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:iv];
        [self addSubview:_inputTF];
        [self addSubview:_dropDownBtn];
        
    }
    return self;
}

- (void)setListArray:(NSMutableArray *)listArray
{
    _listArray = listArray;
    CGFloat count = listArray.count;
    self.frameHeight = count==0?self.frame.size.height:INPUTTEXTFEILDHIEGHT * (count + 1);
    self.frameHeight = count>3?INPUTTEXTFEILDHIEGHT * 4:INPUTTEXTFEILDHIEGHT * (count + 1);
    self.tabHeight = self.frameHeight - INPUTTEXTFEILDHIEGHT;
}

#pragma mark controlAction
- (void)dropDown
{
    self.dropDownBtn.selected = !self.showtableList;
    // 计算comboBox的frame
    CGRect rect = self.frame;
    rect.size.height = self.showtableList?INPUTTEXTFEILDHIEGHT:self.frameHeight;
    
    // 计算comboBox的tableView
    CGRect frame = self.listTableView.frame;
    if (self.showtableList) {
        
        frame.size.height = 0;
    } else {
        // 将listTableView放到前面,防止被其他控件挡到
        [self.superview bringSubviewToFront:self];
        self.listTableView.hidden = NO;
        frame.size.height = 0;
        self.listTableView.frame = frame;
        frame.size.height = self.tabHeight;
    }
    self.showtableList = !self.showtableList;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDisStop)];
    self.listTableView.frame = frame;
    self.frame = rect;
    [UIView commitAnimations];
}
-(void)edit:(UITextField*)sender{
    self.showtableList = !_inputTF.enabled;
    CGRect rect = self.frame;
    rect.size.height = _inputTF.enabled?INPUTTEXTFEILDHIEGHT:self.frameHeight;
    self.frame = rect;
    [self performSelector:@selector(animationDisStop)];
}
#pragma mark UIView AnimationDelegate
- (void)animationDisStop
{
    self.listTableView.hidden = !self.showtableList;
}

#pragma mark UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiala"]];
    cell.textLabel.text = [self.listArray objectAtIndex:[indexPath row]];
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiala_sel"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return INPUTTEXTFEILDHIEGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.inputTF.text = [self.listArray objectAtIndex:[indexPath row]];
    self.showtableList = NO;
    self.listTableView.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = self.listTableView.frame;
    frame.size.height = 0;
    self.listTableView.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
