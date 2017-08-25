//
//  KaoqinModel.h
//  WiseAPP
//
//  Created by app on 16/11/28.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "BaseModel.h"

@interface KaoqinModel : BaseModel
@property(nonatomic,copy)NSString* address;
//@property(nonatomic,assign)NSInteger attendance;
//@property(nonatomic,assign)NSInteger  attendancescope;
//@property(nonatomic,assign)NSInteger contracttime;
//@property(nonatomic,assign)NSInteger fingerprinttime;
//@property(nonatomic,assign)NSInteger project_id;
@property(nonatomic,assign)int  attendance;
@property(nonatomic,assign)int  attendancescope;
@property(nonatomic,assign)int contracttime;
@property(nonatomic,assign)int fingerprinttime;
@property(nonatomic,copy)NSString* area;
@property(nonatomic,strong)NSString* latitude;
@property(nonatomic,strong)NSString* longitude;
//@property(nonatomic,assign)int project_id;
@end
