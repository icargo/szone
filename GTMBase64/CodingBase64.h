//
//  codingBase64.h
//  szone
//
//  Created by zhuyq-MacBook Pro on 14/12/3.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//  对文本、图片进行base64编码解码

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CodingBase64 : NSObject
+(NSString*)encodeString:(NSString*)string;//文本加密
+(NSString*)decodeString:(NSString*)string;//文本解密

+(NSString*)encodeImageToString:(UIImage *)image;//图片加密
+(UIImage *)decodeImageString:(NSString *)imageString;//图片解密
@end
