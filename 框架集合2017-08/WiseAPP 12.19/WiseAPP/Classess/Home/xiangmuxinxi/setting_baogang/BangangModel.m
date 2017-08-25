//
//  BangangModel.m
//  WiseAPP
//
//  Created by yst911521 on 2016/11/22.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BangangModel.h"

@implementation BangangModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if([key isEqualToString:@"id"])
            {
                self.baogangID = [value intValue];
            }
}
@end
