//
//  PaibanheadeModel.h
//  WiseAPP
//
//  Created by app on 16/12/14.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaibanheadeModel : NSObject
@property (nonatomic, copy) NSString *sectionTitle;
@property(nonatomic,copy)NSString* gongshititle;
// 是否是展开的
@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, strong) NSMutableArray *cellModels;

@end

@interface PaiBanCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property(nonatomic,copy) NSString* gongshiStr;

@end
