//
//  BanhuiModel.m
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanhuiModel.h"

@implementation BanhuiModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.banhuiID= [value intValue];
    }
}
@end
