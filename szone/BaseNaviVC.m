//
//  BaseNaviVC.m
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/16.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "BaseNaviVC.h"
@interface BaseNaviVC ()

@end

@implementation BaseNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0]}];
    
}
//    //自定义BarButtonItem图片
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame=CGRectMake(0, 0, WIDTH/12, WIDTH/12);
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
