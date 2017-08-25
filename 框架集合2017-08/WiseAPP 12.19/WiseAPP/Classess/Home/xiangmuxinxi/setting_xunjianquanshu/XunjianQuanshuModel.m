//
//  XunjianQuanshuModel.m
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjianQuanshuModel.h"

@implementation XunjianQuanshuModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.xunjianquanshuID =[value intValue];
    }
}
@end
