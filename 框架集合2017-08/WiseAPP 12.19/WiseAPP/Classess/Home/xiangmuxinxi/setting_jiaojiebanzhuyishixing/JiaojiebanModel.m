//
//  JiaojiebanModel.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "JiaojiebanModel.h"

@implementation JiaojiebanModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.jiaojiebanID =[value intValue];
    }


}
@end
