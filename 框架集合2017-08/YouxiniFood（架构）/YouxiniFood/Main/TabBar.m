//
//  TabBar.m
//  YouxiniFood
//
//  Created by youxin on 2017/7/26.
//  Copyright © 2017年 YST. All rights reserved.
//

#import "TabBar.h"

@interface TabBar()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
//        [self setBackgroundImage:[UIImage imageNamed:@"Rectangle 5"]];
        
//        // 添加发布按钮
//        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
//        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
//        publishButton.size = publishButton.currentBackgroundImage.size;
//        [self addSubview:publishButton];
//        self.publishButton = publishButton;
    }
    return self;
}

//- (void)publishClick
//{
//    XMGPublishViewController *publish = [[XMGPublishViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
   
   
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 3;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    added = YES;
}

- (void)buttonClick
{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter]  postNotificationName:TabBarButtonDidRepeatShowClickNotificationCenter  object:nil userInfo:nil];
}


@end
