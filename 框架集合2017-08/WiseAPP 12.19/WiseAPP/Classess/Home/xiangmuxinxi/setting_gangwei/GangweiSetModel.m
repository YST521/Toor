//
//  GangweiSetModel.m
//  WiseAPP
//
//  Created by app on 16/11/25.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiSetModel.h"

@implementation GangweiSetModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.gangweiID =[value intValue];
    }

}
@end
