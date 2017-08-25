//
//  LinbaoModel.m
//  WiseAPP
//
//  Created by app on 16/11/21.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "LinbaoModel.h"

@implementation LinbaoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.des =value;
    }
    
}
@end
