//
//  UserIDmanger.m
//  WiseAPP
//
//  Created by app on 16/11/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "UserIDmanger.h"


static UserIDmanger* userID =nil;
@implementation UserIDmanger

+(instancetype)shareUseridMangwer{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userID=[[UserIDmanger alloc]init];
        userID.userIDarray=[NSMutableArray array];
        userID.loginHangyeManger=[NSMutableArray array];
        
    });
    return userID;

}

@end
