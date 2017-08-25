//
//  YezhuModel.m
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "YezhuModel.h"

@implementation YezhuModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.yezhuID =[value intValue];
    }

}
@end
