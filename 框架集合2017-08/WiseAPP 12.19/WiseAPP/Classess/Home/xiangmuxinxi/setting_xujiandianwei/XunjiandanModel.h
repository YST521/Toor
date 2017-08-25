//
//  XunjiandanModel.h
//  WiseAPP
//
//  Created by yst911521 on 2016/11/23.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XunjiandanModel : NSObject
@property(nonatomic,assign)int xunjiandianID;
@property(nonatomic,strong)NSArray* image;
@property(nonatomic,strong)NSString* inspectioncontent;
@property(nonatomic,strong)NSString* inspectionmethod;
@property(nonatomic,strong)NSString* inspectionname;
@end
