//
//  UserIDmanger.h
//  WiseAPP
//
//  Created by app on 16/11/9.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserIDmanger : NSObject

+(instancetype)shareUseridMangwer;

@property(nonatomic,strong)NSMutableArray* userIDarray;
@property(nonatomic,strong)NSMutableArray* loginHangyeManger;

@end
