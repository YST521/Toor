//
//  YYsModel.h
//  YYKitDemo
//
//  Created by youxin on 2017/6/29.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYsModel : NSObject
//"value" : "所属村落",
//"holdcolumnnum" : 1,
//"order" : true,
//"rowtype" : 1

@property(nonatomic,copy)NSString *value;
@property(nonatomic,assign)NSInteger holdcolumnnum;
@property(nonatomic,assign)NSInteger rowtype;

@end
