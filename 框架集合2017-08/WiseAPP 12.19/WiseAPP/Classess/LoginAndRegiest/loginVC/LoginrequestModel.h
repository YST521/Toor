//
//  LoginrequestModel.h
//  WiseAPP
//
//  Created by yst911521 on 2016/11/10.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginrequestModel : NSObject
@property(nonatomic,assign)int resultCode;
@property(nonatomic,strong)NSString* resultMessage;
@property(nonatomic,strong)NSString* data;
@property(nonatomic,strong)NSString* token;
@property(nonatomic,assign)int type;
@end
