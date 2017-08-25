//
//  UserModel.m
//  WiseAPP
//
//  Created by app on 16/12/7.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.userID =[value intValue];
    }


}
@end
