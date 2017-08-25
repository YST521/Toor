//
//  LocationHander.h
//  WiseAPP
//
//  Created by app on 16/11/1.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationHander : NSObject

+(instancetype)handleCoo2D;
//数据读取
@property(nonatomic,strong)NSMutableArray* handercoo2dArray;
@property(nonatomic,strong)NSMutableDictionary* handelcoo2dDic;
//-(NSMutableArray*)getCoo2dArray;
//-(NSMutableDictionary*)getCoo2dAddress;
@property(nonatomic,strong)NSMutableArray* kaoqinNocationArray;
@end
