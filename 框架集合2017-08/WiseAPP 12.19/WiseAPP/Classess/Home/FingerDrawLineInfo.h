//
//  FingerDrawLineInfo.h
//  jiantou
//
//  Created by app on 16/11/8.
//  Copyright © 2016年 i. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FingerDrawLineInfo : NSObject

@property (nonatomic,strong)NSMutableArray <__kindof NSValue *>*linePoints;//线条所包含的所有点
@property (nonatomic,strong)UIColor *lineColor;//线条的颜色
@property (nonatomic)float lineWidth;//线条的粗细

@end
