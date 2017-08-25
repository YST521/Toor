//
//  XunjiandanModel.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "XunjiandanModel.h"

@implementation XunjiandanModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
    self.xunjiandianID = [value intValue];
                }
}
@end
