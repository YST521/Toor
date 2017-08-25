//
//  LoginMessageManger.h
//  WiseAPP
//
//  Created by app on 16/11/17.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginMessageManger : NSObject
+(instancetype)loginMessageSingleManger;
@property(nonatomic,strong)NSMutableDictionary* loginMangerDic;
@end
