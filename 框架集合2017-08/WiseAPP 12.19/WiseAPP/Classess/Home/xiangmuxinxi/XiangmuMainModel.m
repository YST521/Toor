//
//  XiangmuMainModel.m
//  WiseAPP
//
//  Created by app on 16/11/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XiangmuMainModel.h"

@implementation XiangmuMainModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if([key isEqualToString:@"id"])
    {
        self.xuangmuxinxiID = [value intValue];
    }
    
}

@end
