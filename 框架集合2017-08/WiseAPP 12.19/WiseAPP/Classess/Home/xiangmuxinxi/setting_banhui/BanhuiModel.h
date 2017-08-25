//
//  BanhuiModel.h
//  WiseAPP
//
//  Created by app on 16/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BanhuiModel : NSObject

@property(nonatomic,assign)int banhuiID;
@property(nonatomic,strong)NSArray* image;
@property(nonatomic,strong)NSString* meetingcontent;
@property(nonatomic,strong)NSString* meetingplace;
@property(nonatomic,strong)NSDictionary* service;
@property(nonatomic,strong)NSString*  meetingtime;
//@property(nonatomic,assign)int  service_id;
@end
