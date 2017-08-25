//
//  LocationHander.m
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LocationHander.h"

static LocationHander *locationtHandel = nil;
@implementation LocationHander

+ (LocationHander *)handleCoo2D
{
  
    static dispatch_once_t Once;
    dispatch_once(&Once, ^{
        locationtHandel = [[LocationHander alloc] init];
        locationtHandel.handercoo2dArray =[NSMutableArray array];
        locationtHandel.handelcoo2dDic =[NSMutableDictionary dictionary];
        locationtHandel.kaoqinNocationArray=[NSMutableArray array];
    });
    return locationtHandel;
}

@end
