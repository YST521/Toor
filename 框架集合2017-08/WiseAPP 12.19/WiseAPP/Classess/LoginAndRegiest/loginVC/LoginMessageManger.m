//
//  LoginMessageManger.m
//  WiseAPP
//
//  Created by app on 16/11/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LoginMessageManger.h"

static LoginMessageManger* loginManger =nil;
@implementation LoginMessageManger
+(instancetype)loginMessageSingleManger{
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManger=[[LoginMessageManger alloc]init];
        loginManger.loginMangerDic=[NSMutableDictionary dictionary];
    });
    
    return loginManger;
}
@end
