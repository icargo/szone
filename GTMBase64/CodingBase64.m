//
//  codingBase64.m
//  szone
//
//  Created by zhuyq-MacBook Pro on 14/12/3.
//  Copyright (c) 2014年 lewei.com. All rights reserved.
//

#import "CodingBase64.h"
#import "GTMBase64.h"

@implementation CodingBase64
//文本加密
+(NSString*)encodeString:(NSString*)string{
    //转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //进行编码
    NSString *encodeStr = [[NSString alloc]initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    return encodeStr;
}
//文本解密
+(NSString*)decodeString:(NSString*)string{
    //转化成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //解码data
    data = [GTMBase64 decodeData:data];
    NSString *decodeStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return decodeStr;
}
//图片加密
+(NSString*)encodeImageToString:(UIImage *)image{
    
    NSData *data=UIImageJPEGRepresentation(image, 1.0);//UIImageJPEGRepresentation返回图片较小，但是清晰度模糊
    //    NSData *data=UIImagePNGRepresentation(image);//UIImagePNGRepresentation图片大，清晰
    
    data= [GTMBase64 encodeData:data];
    NSString *encodeImageStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return encodeImageStr;
}
//图片解密
+(UIImage *)decodeImageString:(NSString *)imageString{

    NSData *data=[imageString dataUsingEncoding:NSUTF8StringEncoding];
    data=[GTMBase64 decodeData:data];
    UIImage *image=[UIImage imageWithData:data];
    return image;
}

@end
