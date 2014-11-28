//
//  ComboBox.h
//  ComboBox
//
//  Created by Becks on 14-10-27.
//  Copyright (c) 2014年 Becks_Zeng(曾光). All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ComboBox : UIView<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *listTableView;   // 下拉列表
@property (nonatomic, strong) NSMutableArray *listArray;    // 下拉列表数据
@property (nonatomic, strong) UITextField *inputTF;         // 输入框
@property (nonatomic, assign) BOOL showtableList;           // 是否显示列表
@property (nonatomic, assign) CGFloat tabHeight;            // 下拉列表高度
@property (nonatomic, assign) CGFloat frameHeight;          // frame高度

@end
