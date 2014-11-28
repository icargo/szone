//
//  PaizhaoVC.h
//  szoneL
//
//  Created by zhuyq-MacBook Pro on 14/11/17.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCamera.h"
@interface PaizhaoVC : UIViewController <iCameraFunDelegate>
@property(nonatomic,strong)iCamera *iCamera;
@end
