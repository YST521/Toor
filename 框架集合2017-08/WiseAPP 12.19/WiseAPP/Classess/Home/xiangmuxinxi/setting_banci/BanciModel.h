//
//  BanciModel.h
//  WiseAPP
//
//  Created by yst911521 on 2016/11/20.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BanciModel : NSObject
//endtime = "14:53";
//id = 2;
//"project_id" = 1;
//servicesname = "\U65e5\U73ed";
//starttime = "09:50";
@property(nonatomic,copy)NSString*endtime;
@property(nonatomic,copy)NSString*starttime;
@property(nonatomic,copy)NSString*servicesname;
@property(nonatomic,assign)int banciID;
@property(nonatomic,assign)int project_id;

@end
