//
//  UIView+YSTExtension.h
//  百思不得其姐
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YSTExtension)

@property(nonatomic,assign)CGSize size;

@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//显示在主窗口
- (BOOL)isShowingOnKeyWindow;

//在分类中声明@proprty 只会生成方法声明 不会生成方法的实现和带有下划线的成员变量
//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;



@end
