//
//  GangweiModel.m
//  WiseAPP
//
//  Created by app on 16/11/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "GangweiModel.h"

@implementation GangweiModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"])
            {
                self.gangweipeixunID = [value intValue] ;
            }
        
}
@end
