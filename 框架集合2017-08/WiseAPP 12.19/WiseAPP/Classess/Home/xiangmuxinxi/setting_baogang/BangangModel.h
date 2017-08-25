//
//  BangangModel.h
//  WiseAPP
//
//  Created by yst911521 on 2016/11/22.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BangangModel : NSObject
@property(nonatomic,strong)NSString* jetlag;
@property(nonatomic,strong)NSString*  reportingtime;
@property(nonatomic,assign)int baogangID;
@property(nonatomic,strong)NSDictionary* postsetting;
@property(nonatomic,strong)NSDictionary* service;
@end
