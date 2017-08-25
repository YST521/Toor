//
//  BanciModel.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/20.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BanciModel.h"

@implementation BanciModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.banciID =[value intValue];
    }


}
@end
