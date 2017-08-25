//
//  SingleXiangmuxnxi.m
//  WiseAPP
//
//  Created by app on 16/11/7.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SingleXiangmuxnxi.h"

static SingleXiangmuxnxi* SinglexiangmuManger=nil;
@implementation SingleXiangmuxnxi

+(SingleXiangmuxnxi*)SingleXiangmuxinxiManger{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SinglexiangmuManger=[[SingleXiangmuxnxi alloc]init];
        SinglexiangmuManger.YezhumessageArray=[NSMutableArray array];
        SinglexiangmuManger.xiangmuprojectIdDic=[NSMutableDictionary dictionary];
    });
    return  SinglexiangmuManger;
}

@end
